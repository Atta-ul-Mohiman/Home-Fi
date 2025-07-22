import 'package:NexaHome/controller/signupController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class SignupScreen extends StatelessWidget {
  final controller = Get.put(SignupController());
  final darkPurple = Color(0xFF4A148C);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus(); // Dismiss keyboard on tap
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Lottie.asset(
                  'assets/lottie/light-bulb.json',
                  repeat: false,
                  width: 150,
                ),
              ),
              Center(
                child: Text("Create Account",
                    style: GoogleFonts.nunito(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: darkPurple,
                    )),
              ),
              SizedBox(height: 30),

              // Full Name Field
              Obx(() => TextField(
                    controller: controller.fullNameController.value,
                    focusNode: controller.fullNameFocus,
                    onChanged: (_) => controller.validateInputs(),
                    cursorColor: darkPurple,
                    style: GoogleFonts.nunito(color: Colors.black),
                    decoration: InputDecoration(
                      hintText: "Full Name",
                      errorText: controller.isNameValid.value
                          ? null
                          : "Name must be at least 3 characters",
                      prefixIcon: Icon(Icons.person, color: darkPurple),
                      filled: true,
                      fillColor: Colors.black12,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: darkPurple),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: darkPurple, width: 2),
                      ),
                    ),
                  )),
              SizedBox(height: 20),

              // Email Field
              Obx(() => TextField(
                    controller: controller.emailController.value,
                    focusNode: controller.emailFocus,
                    onChanged: (_) => controller.validateInputs(),
                    cursorColor: darkPurple,
                    style: GoogleFonts.nunito(color: Colors.black),
                    decoration: InputDecoration(
                      hintText: "Email",
                      errorText: controller.isEmailValid.value
                          ? null
                          : "Enter a valid email",
                      prefixIcon: Icon(Icons.email, color: darkPurple),
                      filled: true,
                      fillColor: Colors.black12,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: darkPurple),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: darkPurple, width: 2),
                      ),
                    ),
                  )),
              SizedBox(height: 20),

              // Password Field
              Obx(() => TextField(
                controller: controller.passwordController.value,
                focusNode: controller.passwordFocus,
                onChanged: controller.validatePassword,
                obscureText: !controller.isPasswordVisible.value,
                cursorColor: darkPurple,
                style: GoogleFonts.nunito(color: Colors.black),
                decoration: InputDecoration(
                  hintText: "Password",
                  prefixIcon: Icon(Icons.lock, color: darkPurple),
                  suffixIcon:  InkWell(
                    onTap: (){
                      controller.togglePasswordVisibility();
                    },
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    child: Icon(
                      controller.isPasswordVisible.value ? Icons.visibility : Icons.visibility_off,
                      color: darkPurple,
                    ),
                  ),
                  filled: true,
                  fillColor: Colors.black12,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: darkPurple),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: darkPurple, width: 2),
                  ),
                ),
              )),

              SizedBox(height: 20),

              // Password Checklist
              Obx(() => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _checkItem("At least 8 characters",
                          controller.hasMinLength.value),
                      _checkItem("Contains number", controller.hasNumber.value),
                      _checkItem(
                          "Uppercase letter", controller.hasUppercase.value),
                      _checkItem(
                          "Lowercase letter", controller.hasLowercase.value),
                      _checkItem(
                          "Special character", controller.hasSpecialChar.value),
                    ],
                  )),
              SizedBox(height: 30),

              // Submit Button
              Center(
                child: ElevatedButton(
                  onPressed: controller.submit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: darkPurple,
                    fixedSize: Size(Get.width / 1.15, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Obx(
                      ()=>controller.isLoading.value ==true?
                          Center(
                            child: CircularProgressIndicator(color: Colors.white,),
                          )
                          : Text("Sign Up",
                        style: GoogleFonts.nunito(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        )),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _checkItem(String text, bool valid) {
    return Row(
      children: [
        Icon(
          valid ? Icons.check_circle : Icons.cancel,
          color: valid ? Colors.green : Colors.red,
          size: 20,
        ),
        SizedBox(width: 8),
        Text(
          text,
          style: GoogleFonts.nunito(
            fontSize: 14,
            color: valid ? Colors.green : Colors.red,
            fontWeight: FontWeight.w600,
          ),
        )
      ],
    );
  }
}
