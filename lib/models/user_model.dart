// lib/models/user_model.dart
class User {
  final int id;
  final String email;
  final String name;
  final String? address; // Nullable
  final String? phoneNumber; // Nullable
  final String? image; // Nullable
  final String? status; // Nullable

  User({
    required this.id,
    required this.email,
    required this.name,
    this.address, // Nullable
    this.phoneNumber, // Nullable
    this.image, // Nullable
    this.status, // Nullable
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      email: json['email'],
      name: json['name'],
      address: json['alamat'] ?? '', // Default to empty string if null
      phoneNumber: json['no_hp'] ?? '', // Default to empty string if null
      image: json['image'] ?? '', // Default to empty string if null
      status: json['status'] ?? '', // Default to empty string if null
    );
  }

  String get userProfileImageUrl => 'http://192.168.100.151:8000/$image';
  // String get userProfileImageUrl => 'http://127.0.0.1:8000/$image';
}
