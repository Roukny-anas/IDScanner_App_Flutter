class AuthRequest {
  final String email;
  final String password;
  final int? otpCode;

  AuthRequest({
    required this.email,
    required this.password,
    this.otpCode,
  });

  // Method to convert AuthRequest instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      'otpCode': otpCode,
    };
  }
}
