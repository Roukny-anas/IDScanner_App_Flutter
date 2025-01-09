import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isPasswordVisible = false;
  bool isLoading = false;

  void login() {
    setState(() {
      isLoading = true;
    });

    // Simulate a login process
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        isLoading = false;
      });

      // Navigate to the IDScannerPage regardless of input
      Navigator.pushReplacementNamed(context, '/idscanner');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5DC),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 48.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Add the image here
              Image.asset(
                'assets/IDScanner.png',
                height: 150, // Adjust the height as needed
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 24),

              const Text(
                'Welcome Back!',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2E8B57),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              const Text(
                'Login to continue',
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF3CB371),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),

              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10.0,
                      spreadRadius: 2.0,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    TextField(
                      controller: emailController,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        labelStyle: const TextStyle(color: Color(0xFF3CB371)),
                        prefixIcon: const Icon(Icons.email, color: Color(0xFF2E8B57)),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Color(0xFF2E8B57)),
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    TextField(
                      controller: passwordController,
                      obscureText: !isPasswordVisible,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        labelStyle: const TextStyle(color: Color(0xFF3CB371)),
                        prefixIcon: const Icon(Icons.lock, color: Color(0xFF2E8B57)),
                        suffixIcon: IconButton(
                          icon: Icon(
                            isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                            color: const Color(0xFF2E8B57),
                          ),
                          onPressed: () {
                            setState(() {
                              isPasswordVisible = !isPasswordVisible;
                            });
                          },
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Color(0xFF2E8B57)),
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              ElevatedButton(
                onPressed: isLoading ? null : login,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2E8B57),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text('Login', style: TextStyle(fontSize: 18, color: Colors.white)),
              ),
              const SizedBox(height: 16),

              Row(
                children: [
                  Expanded(
                    child: Divider(
                      color: const Color(0xFF3CB371),
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
                      color: const Color(0xFF3CB371),
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
                      "Don't have an account?",
                      style: TextStyle(color: Color(0xFF3CB371)),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/signup');
                      },
                      child: const Text(
                        'Sign up',
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
    );
  }
}