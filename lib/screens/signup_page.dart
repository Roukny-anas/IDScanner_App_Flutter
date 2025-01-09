import 'package:flutter/material.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  bool isPasswordVisible = false;
  bool isConfirmPasswordVisible = false;
  final _formKey = GlobalKey<FormState>();

  InputDecoration _inputDecoration(String labelText, IconData icon, {bool isPassword = false, bool? isVisible, Function()? toggleVisibility}) {
    return InputDecoration(
      labelText: labelText,
      labelStyle: TextStyle(color: Color(0xFF3CB371)),
      floatingLabelStyle: TextStyle(color: Color(0xFF2E8B57)),
      prefixIcon: Icon(icon, color: Color(0xFF2E8B57)),
      suffixIcon: isPassword
          ? IconButton(
              icon: Icon(
                isVisible! ? Icons.visibility : Icons.visibility_off,
                color: Color(0xFF2E8B57),
              ),
              onPressed: toggleVisibility,
            )
          : null,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: BorderSide(color: Color(0xFF2E8B57)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: BorderSide(color: Color(0xFF2E8B57), width: 2.0),
      ),
    );
  }

  String? _validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return 'Username cannot be empty';
    } else if (value.length < 3) {
      return 'Username must be at least 3 characters';
    }
    return null;
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email cannot be empty';
    } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
      return 'Enter a valid email';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password cannot be empty';
    } else if (value.length < 8) {
      return 'Password must be at least 8 characters';
    }
    return null;
  }

  String? _validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    } else if (value != passwordController.text) {
      return 'Passwords do not match';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5DC),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 48.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 55),
                Text(
                  'Create an Account',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Color(0xFF2E8B57)),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 8),
                Text(
                  'Sign up to get started',
                  style: TextStyle(fontSize: 16, color: Color(0xFF3CB371)),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 40),
                Container(
                  padding: EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.0),
                    boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10.0, spreadRadius: 2.0)],
                  ),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: usernameController,
                        decoration: _inputDecoration('Username', Icons.person),
                        validator: _validateUsername,
                      ),
                      SizedBox(height: 16),
                      TextFormField(
                        controller: emailController,
                        decoration: _inputDecoration('Email', Icons.email),
                        validator: _validateEmail,
                      ),
                      SizedBox(height: 16),
                      TextFormField(
                        controller: passwordController,
                        obscureText: !isPasswordVisible,
                        decoration: _inputDecoration(
                          'Password',
                          Icons.lock,
                          isPassword: true,
                          isVisible: isPasswordVisible,
                          toggleVisibility: () {
                            setState(() {
                              isPasswordVisible = !isPasswordVisible;
                            });
                          },
                        ),
                        validator: _validatePassword,
                      ),
                      SizedBox(height: 16),
                      TextFormField(
                        controller: confirmPasswordController,
                        obscureText: !isConfirmPasswordVisible,
                        decoration: _inputDecoration(
                          'Confirm Password',
                          Icons.lock,
                          isPassword: true,
                          isVisible: isConfirmPasswordVisible,
                          toggleVisibility: () {
                            setState(() {
                              isConfirmPasswordVisible = !isConfirmPasswordVisible;
                            });
                          },
                        ),
                        validator: _validateConfirmPassword,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Simulate a successful signup
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Registration successful!')),
                      );
                      Navigator.pushReplacementNamed(context, '/login');
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF2E8B57),
                    padding: EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'Sign Up',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: Divider(
                        color: Color(0xFF3CB371),
                        thickness: 1,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        'or',
                        style: TextStyle(color: Color(0xFF3CB371)),
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        color: Color(0xFF3CB371),
                        thickness: 1,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Already have an account?',
                        style: TextStyle(color: Color(0xFF3CB371)),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/login');
                        },
                        child: const Text(
                          'Login',
                          style: TextStyle(
                            color: Color(0xFF2E8B57),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}