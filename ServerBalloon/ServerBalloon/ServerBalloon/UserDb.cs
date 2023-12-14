using Google.Cloud.Firestore;

namespace ServerBalloon;

[FirestoreData]
public class UserDb
{
    [FirestoreDocumentId]
    public string Id { get; set; }
    [FirestoreProperty]
    public string Name { get; set; }
    [FirestoreProperty]
    public DateTime BirthDate { get; set; }
    [FirestoreProperty]
    public string TypeDiabet { get; set; }
    [FirestoreProperty]
    public int Height { get; set; }
    [FirestoreProperty]
    public int Weight { get; set; }
    [FirestoreProperty]
    public string Male { get; set; }
}