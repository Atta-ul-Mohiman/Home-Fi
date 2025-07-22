import 'package:NexaHome/View/authScreens/Forgotpassword.dart';
import 'package:NexaHome/View/authScreens/SignupScreen.dart';
import 'package:NexaHome/controller/loginController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class LoginScreen extends StatelessWidget {
  final Color darkPurple = Color(0xFF4A148C);
  final LoginController controller = Get.put(LoginController());
FocusNode emailNode = FocusNode();
FocusNode passwordNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        emailNode.unfocus();
        passwordNode.unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: [
                Image.asset('assets/images/logo.jpeg',height:250,width:250),
                SizedBox(height: 0),
                Text(
                  "Welcome Back",
                  style: GoogleFonts.nunito(
                    fontSize: 32,
                    color: darkPurple,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 30),

                // Email TextField
                Container(
                  height: 55,
                  child: TextField(
                    focusNode: emailNode,
                    controller: controller.emailController,
                    cursorColor: darkPurple,
                      style: GoogleFonts.nunito(color: Colors.black),
                    decoration: InputDecoration(
                      hintText: "Email",
                      hintStyle:   GoogleFonts.nunito(color: Colors.black),
                      prefixIcon: Icon(Icons.email, color: darkPurple),
                      filled: true,
                      fillColor: Colors.black12,
                      contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 18),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: darkPurple),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: darkPurple, width: 2),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),

                // Password TextField with Eye Toggle
                Obx(() => Container(
                  height: 55,
                  child: TextField(
                    controller: controller.passwordController,
                    obscureText: !controller.isPasswordVisible.value,
                    focusNode: passwordNode,
                    cursorColor: darkPurple,
                    style: GoogleFonts.nunito(color: Colors.black),

                    decoration: InputDecoration(
                      hintText: "Password",
                      hintStyle:   GoogleFonts.nunito(color: Colors.black),
                      prefixIcon: Icon(Icons.lock, color: darkPurple),
                      suffixIcon: IconButton(
                        icon: Icon(
                          controller.isPasswordVisible.value
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: darkPurple,
                        ),
                        onPressed: controller.togglePasswordVisibility,
                      ),
                      filled: true,
                      fillColor: Colors.black12,
                      contentPadding:
                      EdgeInsets.symmetric(vertical: 16, horizontal: 18),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: darkPurple),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: darkPurple, width: 2),
                      ),
                    ),
                  ),
                )),
                SizedBox(height: 15,),
                Align(
                  alignment: Alignment.centerRight,
                  child:
                  InkWell(
                    onTap: (){
                      Get.to(()=>ForgotPasswordScreen());
                    },
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    child: Text(
                      "Forgot Password?",
                      style: GoogleFonts.nunito(
                        color: darkPurple,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 15,),
                SizedBox(height: 10),

                // Login Button
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: darkPurple,
             fixedSize: Size(Get.width/1.15, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    final email = controller.emailController.text.trim();
                    final password = controller.passwordController.text;
                 if(email.isEmpty||password.isEmpty){
                   Get.snackbar("Incomplete info", "Kindly enter the complete info",
                       backgroundColor: Color(0xFF4A148C), colorText: Colors.white);
                 }else{
                   if(controller.loggingUser.value==true){
                     print('Logging user...');
                   }
                   else{
                     controller.loginUser(email, password);
                   }

                 }
                  },
                  child: Obx(
                    ()=>controller.loggingUser.value==true?
                        Center(child: CircularProgressIndicator(color: Colors.white,))
                        : Text(
                      "Login",
                      style: GoogleFonts.nunito(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
SizedBox(height: 10,),
                TextButton(
                  onPressed: () {
                    Get.to(SignupScreen());
                  },

                  child: Text(
                    "Don\'t have an account? SignUp",
                    style: GoogleFonts.nunito(
                      color: darkPurple,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
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
