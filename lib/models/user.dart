class UserModel {
  String uid;
  String name;
  String email;
  String profilePictureUrl;

  UserModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.profilePictureUrl,
  });

  factory UserModel.fromMap(Map<String, dynamic> data) {
    return UserModel(
      uid: data['uid'],
      name: data['name'],
      email: data['email'],
      profilePictureUrl: data['profilePictureUrl'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'profilePictureUrl': profilePictureUrl,
    };
  }
}

