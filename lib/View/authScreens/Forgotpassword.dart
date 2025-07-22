import 'package:NexaHome/controller/forgotPasController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ForgotPasswordScreen extends StatelessWidget {
  final controller = Get.put(ForgotPasswordController());
  final darkPurple = Color(0xFF4A148C);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                      onTap: (){
                        Get.back();
                      },
                      child: Icon(Icons.arrow_back_ios,color: darkPurple,size: 18,)),
                  Center(
                    child: Text("Forgot Password",
                        style: GoogleFonts.nunito(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: darkPurple,
                        )),
                  ),
                  SizedBox(width: 20,)
                ],
              ),
              SizedBox(height: 40),
              Obx(() => TextField(
                controller: controller.emailController,
                onChanged: controller.validateEmail,
                cursorColor: darkPurple,
                style: GoogleFonts.nunito(color: Colors.black),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(top: 10),
                  hintText: "Enter your email",
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
              SizedBox(height: 80),
              Center(
                child: ElevatedButton(
                  onPressed: controller.sendResetLink,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: darkPurple,
fixedSize: Size(Get.width/1.15, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Obx(
                      ()=>controller.sendingLink.value ==true?
                          Center(
                            child: CircularProgressIndicator(color: Colors.white,),
                          )
                          : Text("Send Reset Link",
                        style: GoogleFonts.nunito(
                          fontSize: 15,
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
}
