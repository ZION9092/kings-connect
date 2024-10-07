class UserModel {
  final String fullName;
  final String email;
  final String profileImageUrl;

  UserModel({required this.fullName, required this.email, required this.profileImageUrl,});

  // Method to convert Firestore document to UserModel instance
  factory UserModel.fromMap(Map<String, dynamic> data) {
    return UserModel(
      fullName: data['fullName'],
      email: data['email'],
      profileImageUrl: data['profileImageUrl'],
    );
  }

  // Method to convert UserModel instance to a Map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'fullName': fullName,
      'email': email,
      'profileImageUrl': profileImageUrl,
    };
  }
}

