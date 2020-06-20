class User {
  String userId;
  String name;
  String email;
  String token;

  User({
    this.userId,
    this.name,
    this.email,
  });
  User.initial()
      : userId = '',
        name = '',
        email = '';
  factory User.fromJson(Map<String, dynamic> parsedJson) {
    return User(
      userId: parsedJson['_id'],
      name: parsedJson['name'],
      email: parsedJson['email'],
    );
  }
}

const userSample = {
  "user": {
    "_id": "5ece9547bb1b46054eee645d",
    "name": "Test User2",
    "email": "test2@gmail.com",
    "createdAt": "2020-05-27T16:28:55.577Z",
    "updatedAt": "2020-05-27T16:28:56.043Z",
    "__v": 1
  },
  "token":
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI1ZWNlOTU0N2JiMWI0NjA1NGVlZTY0NWQiLCJpYXQiOjE1OTA1OTY5MzZ9.pmgmeg7NV7rTxSgEzVPR9Q6O8wXq7zzBJJmtfHbz2KE"
};
