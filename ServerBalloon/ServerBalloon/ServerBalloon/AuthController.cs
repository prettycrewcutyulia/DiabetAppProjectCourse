using Firebase.Auth;
using Firebase.Auth.Providers;
using FirebaseAdmin;
using FirebaseAdmin.Auth;
using Microsoft.AspNetCore.Mvc;

namespace ServerBalloon;
[Route("api/auth")]
[ApiController]
public class AuthController : ControllerBase
{
    private FirebaseApp _firebaseApp;
    private FirebaseAuth _auth;
    private FirebaseAuthClient _provider;
    public AuthController(FirebaseApp app)
    {
        _firebaseApp = app;
        _auth = FirebaseAuth.GetAuth(_firebaseApp);
        var client = new EmailProvider();
        _provider = new FirebaseAuthClient(new FirebaseAuthConfig
        {
            ApiKey = "AIzaSyBJUgGVzYj-QPbaD59ENOAlyTA82JyPzYo",
            AuthDomain = "serverforballoon.firebaseapp.com",
            Providers = new []{client}
        });
    }
    [HttpPost("register")]
    public async Task<IActionResult> RegisterAsync(UserRecordArgs args)
    {
        try
        {

            var userRecord = await _auth.CreateUserAsync(args);

            return Ok(userRecord.Uid);
        }
        catch (Exception ex)
        {
            return BadRequest($"Registration failed: {ex.Message}");
        }
    }

    [HttpPost("login")]
    public async Task<IActionResult> LoginAsync(UserRecordArgs args)
    {
        try
        {
            var user = await _provider.SignInWithEmailAndPasswordAsync(args.Email, args.Password);
            
            return Ok(user.User.Uid);
        }
        catch (Exception ex)
        {
            return BadRequest($"Login failed: {ex.Message}");
        }
    }

    [HttpPost("reset-password")]
    public async Task<IActionResult> ResetPasswordAsync(ResetPassword email)
    {
        try
        {
            await _provider.ResetEmailPasswordAsync(email.Email);
            return Ok($"Password reset email sent to {email.Email}");
        }
        catch (Exception ex)
        {
            return BadRequest($"Password reset failed: {ex.Message}");
        }
    }
}

public class ResetPassword
{
    public string Email { get; set; }
}