class ProfileModel {
  final int id;
  final String userId;
  final String name;
  final String email;
  final String avatarUrl;
  final String phoneNumber;
  final bool isAdmin;

  ProfileModel({
    required this.id,
    required this.userId,
    required this.name,
    required this.email,
    required this.avatarUrl,
    required this.phoneNumber,
    required this.isAdmin,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      id: json['id'] as int,
      userId: json['user_id'].toString(),
      name: json['name']?.toString() ?? '',
      email: json['email']?.toString() ?? '',
      phoneNumber: json['phone_number']?.toString() ?? '',
      isAdmin: json['is_admin'] ?? false,
      avatarUrl: json['avatarUrl']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'name': name,
      'email': email,
      'phone_number': phoneNumber,
      'is_admin': isAdmin,
      'avatarUrl': avatarUrl,
    };
  }
}