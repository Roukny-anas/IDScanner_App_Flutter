class User {
  final int? id;
  final String email;
  final String password;
  final String? secretKey;
  final int? otpCode;

  User({
    this.id,
    required this.email,
    required this.password,
    this.secretKey,
    this.otpCode,
  });

  // Factory constructor to create a User instance from JSON
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      email: json['email'],
      password: json['password'],
      secretKey: json['secretKey'],
      otpCode: json['otpCode'],
    );
  }

  // Method to convert a User instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'password': password,
      'secretKey': secretKey,
      'otpCode': otpCode,
    };
  }
}
