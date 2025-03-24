import 'package:e_globalpen_app/presentation/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';
import '../../core/services/auth_service.dart';

class OtpVerificationScreen extends StatefulWidget {
  final String phoneNumber;

  OtpVerificationScreen({required this.phoneNumber});

  @override
  _OtpVerificationScreenState createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  bool isLoading = false;
  final AuthService _authService = AuthService(); // Auth Service Instance

  void showLoadingDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircularProgressIndicator(color: Color(0xFFFFC107)),
              const SizedBox(height: 20),
              Text("Please wait", style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w500)),
            ],
          ),
        );
      },
    );
  }

  void showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.check_circle, color: Colors.green, size: 50),
              const SizedBox(height: 15),
              Text("Verification Successful!", style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w600)),
              const SizedBox(height: 15),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFFC107),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: Text("Continue", style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        );
      },
    );
  }

  void showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Error"),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }

  // Function to verify OTP using API
  void verifyOtp(String otp) async {
    showLoadingDialog();

    var response = await _authService.verifyOtp(phone: widget.phoneNumber, otp: otp);

    Navigator.pop(context); // Close loading dialog

    if (response.containsKey('error')) {
      showErrorDialog(response['error']); // Show error if OTP is invalid
    } else {
      showSuccessDialog();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
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
                  Image.asset('assets/images/logo.png', width: 70, height: 70, fit: BoxFit.contain),
                  const SizedBox(height: 10),
                  Text("Global Pen Reads", style: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            const SizedBox(height: 30),
            Text("OTP verification", style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.bold)),
            Text("Confirmation code sent on ${widget.phoneNumber}", style: GoogleFonts.poppins(fontSize: 16)),
            const SizedBox(height: 30),
            Center(
              child: Pinput(
                length: 6,
                showCursor: true,
                onCompleted: (pin) => verifyOtp(pin),
              ),
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  // Simulate OTP verification when the button is clicked
                  verifyOtp("123456"); // Replace with real input
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF790679),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: Text("Verify", style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
