class UserProfile {
  final String name;
  final String email;
  final String image;

  UserProfile({
    required this.name,
    required this.email,
    required this.image,
  });

  factory UserProfile.fromMap(Map<String, dynamic> map) {
    return UserProfile(
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      image: map['image'] ?? '',
    );
  }
}
