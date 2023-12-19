using Google.Cloud.Firestore;
using Microsoft.AspNetCore.Mvc;

namespace ServerBalloon;

[Route("api/db")]
[ApiController]
public class FirestoreController:ControllerBase
{
    private FirestoreDb _firestoreDb;
    public FirestoreController()
    {
        _firestoreDb = FirestoreDb.Create("serverforballoon");
    }

    [HttpPost("addUser")]
    public async Task<IActionResult> AddUser(UserDb user)
    {
        user.BirthDate = user.BirthDate.ToUniversalTime();
        CollectionReference collectionReference = _firestoreDb.Collection("users");
        try
        {
            await collectionReference.Document(user.Id).SetAsync(user);
            return Ok();
        }
        catch (Exception ex)
        {
            if (string.IsNullOrEmpty(user.Id))
            {
                return BadRequest("User Id is empty or null.");
            }
            return BadRequest($"AddUser failed: {ex.Message}");
        }
    }
    
    [HttpPut("updateUser/{userId}")]
    public async Task<IActionResult> UpdateUser(string userId, UserDb updatedUserData)
    {
        updatedUserData.BirthDate = updatedUserData.BirthDate.ToUniversalTime();
        try
        {
            DocumentReference docRef = _firestoreDb.Collection("users").Document(userId);
            await docRef.SetAsync(updatedUserData, SetOptions.MergeAll);

            return Ok();
        }
        catch (Exception ex)
        {
            return BadRequest($"UpdateUser failed: {ex.Message}");
        }
    }
    
    [HttpGet("getUser/{userId}")]
    public async Task<IActionResult> GetUser(string userId)
    {
        try
        {
            DocumentReference docRef = _firestoreDb.Collection("users").Document(userId);
            DocumentSnapshot snapshot = await docRef.GetSnapshotAsync();

            if (snapshot.Exists)
            {
                UserDb userData = snapshot.ConvertTo<UserDb>();
                return Ok(userData);
            }
            else
            {
                return NotFound("User not found");
            }
        }
        catch (Exception ex)
        {
            return BadRequest($"GetUser failed: {ex.Message}");
        }
    }


}