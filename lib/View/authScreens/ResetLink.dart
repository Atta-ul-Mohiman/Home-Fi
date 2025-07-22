import 'package:NexaHome/View/authScreens/loginScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ResetLinkSentScreen extends StatelessWidget {
  final darkPurple = Color(0xFF4A148C);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.mail_outline, size: 80, color: darkPurple),
              SizedBox(height: 30),
              Text("Check your email",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.nunito(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: darkPurple,
                  )),
              SizedBox(height: 16),
              Text(
                "We’ve sent a password reset link to your email address. Tap on the link to reset your password.",
                textAlign: TextAlign.center,
                style: GoogleFonts.nunito(
                  fontSize: 16,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                 Get.to(()=>LoginScreen());
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: darkPurple,
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text("Back to Login",
                    style: GoogleFonts.nunito(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
