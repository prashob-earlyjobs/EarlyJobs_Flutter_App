class SignupResponse {
  final bool success;
  final String message;
  final Map<String, dynamic>? data; // or a dedicated User model
  final String? accessToken;

  SignupResponse({
    required this.success,
    required this.message,
    this.data,
    this.accessToken,
  });

  factory SignupResponse.fromJson(Map<String, dynamic> json) {
    return SignupResponse(
      success: json['success'] as bool,
      message: json['message'] as String,
      data: json['data'],
      accessToken: json['accessToken'],
    );
  }
}
