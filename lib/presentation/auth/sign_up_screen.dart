import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import '../../core/services/auth_service.dart';
import 'otp_screen.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final AuthService _authService = AuthService();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _isLoading = false;
  bool _obscurePassword = true;

  void _register() async {
    String name = nameController.text.trim();
    String email = emailController.text.trim();
    String phone = phoneController.text.trim();
    String password = passwordController.text.trim();

    if (name.isEmpty || email.isEmpty || phone.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("All fields are required")),
      );
      return;
    }

    setState(() => _isLoading = true);

    var response = await _authService.register(
      name: name,
      email: email,
      phone: phone,
      password: password,
    );

    setState(() => _isLoading = false);

    if (response.containsKey('error')) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(response['error'])),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => OtpVerificationScreen(phoneNumber: phone),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.black87),
                onPressed: () => Navigator.pop(context),
              ),

              Align(
                alignment: Alignment.center,
                child: Column(
                  children: [
                    Image.asset('assets/images/logo.png', width: 70, height: 70),
                    const SizedBox(height: 10),
                    Text("Global Pen Reads",
                        style: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              const SizedBox(height: 30),

              Text("Sign up", style: GoogleFonts.poppins(fontSize: 28, fontWeight: FontWeight.bold)),
              Text("Sign in to continue", style: GoogleFonts.poppins(fontSize: 16, color: Colors.black54)),
              const SizedBox(height: 30),

              _buildInputField(Icons.person, "Enter your name", nameController),
              const SizedBox(height: 15),
              _buildInputField(Icons.email, "Enter your email", emailController),
              const SizedBox(height: 15),

              Container(
                decoration: _inputDecoration(),
                child: IntlPhoneField(
                  controller: phoneController,
                  decoration: InputDecoration(
                    labelText: "Enter your mobile number",
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                    prefixIcon: const Icon(Icons.phone, color: Colors.black54),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  initialCountryCode: 'NG',
                ),
              ),
              const SizedBox(height: 15),

              Container(
                decoration: _inputDecoration(),
                child: TextField(
                  controller: passwordController,
                  obscureText: _obscurePassword,
                  decoration: InputDecoration(
                    labelText: "Enter your password",
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                    filled: true,
                    fillColor: Colors.white,
                    suffixIcon: IconButton(
                      icon: Icon(_obscurePassword ? Icons.visibility_off : Icons.visibility, color: Colors.grey),
                      onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),

              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _register,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF790679),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: _isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : Text("Sign up", style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputField(IconData icon, String hintText, TextEditingController controller) {
    return Container(
      decoration: _inputDecoration(),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: hintText,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
          prefixIcon: Icon(icon, color: Colors.black54),
          filled: true,
          fillColor: Colors.white,
        ),
      ),
    );
  }

  BoxDecoration _inputDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 8, spreadRadius: 2)],
    );
  }
}
