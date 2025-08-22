class LoginResponse {
  final bool success;
  final String message;
  final LoginData? data;

  LoginResponse({
    required this.success,
    required this.message,
    this.data,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      success: json['success'] as bool,
      message: json['message'] as String,
      data: json['data'] != null ? LoginData.fromJson(json['data']) : null,
    );
  }
}

class LoginData {
  final User user;
  final String accessToken;

  LoginData({required this.user, required this.accessToken});

  factory LoginData.fromJson(Map<String, dynamic> json) {
    return LoginData(
      user: User.fromJson(json['user']),
      accessToken: json['accessToken'],
    );
  }
}

class User {
  final String id;
  final String name;
  final String email;
  final String mobile;
  final String role;
  final bool isEmailVerified;
  final bool isPhoneVerified;
  // Add more fields as needed (profile, etc.)

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.mobile,
    required this.role,
    required this.isEmailVerified,
    required this.isPhoneVerified,
    // You can extend here: profile fields/objects
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'],
      name: json['name'],
      email: json['email'],
      mobile: json['mobile'],
      role: json['role'],
      isEmailVerified: json['isEmailVerified'] ?? false,
      isPhoneVerified: json['isPhoneVerified'] ?? false,
    );
  }
}
