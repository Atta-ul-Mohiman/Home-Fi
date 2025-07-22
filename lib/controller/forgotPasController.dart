import 'package:NexaHome/View/authScreens/ResetLink.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ForgotPasswordController extends GetxController {
  final emailController = TextEditingController();
  var isEmailValid = true.obs;

  void validateEmail(String value) {
    isEmailValid.value = GetUtils.isEmail(value.trim());
  }

  void sendResetLink()async {
    validateEmail(emailController.text);
    if (isEmailValid.value) {
  if(sendingLink.value==true){
    print('Sending previous link...');
  }
  else{
   await  sendPasswordResetIfExists(emailController.text.trim());
   emailController.clear();
  }
    } else {
      Get.snackbar("Invalid Email", "Please enter a valid email address.",
      backgroundColor: Color(0xFF4A148C),
        colorText: Colors.white
      );
    }
  }
  RxBool sendingLink = false.obs;

  Future<void> sendPasswordResetIfExists(String email) async {
    try {
      sendingLink.value = true;
      // Query Firestore to check if user with this email exists
      final querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('email', isEqualTo: email)
          .limit(1)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        // If user exists, send password reset email
        await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
        sendingLink.value = false;
        Get.snackbar(
          "Email Sent",
          "Password reset link has been sent to $email",
          backgroundColor: Color(0xFF4A148C),
          colorText: Colors.white,
        );
        Get.to(()=>ResetLinkSentScreen());
      } else {
        sendingLink.value = false;
        Get.snackbar(
          "Email Not Found",
          "No account found with this email",
          backgroundColor: Color(0xFF4A148C),
          colorText: Colors.white,
        );
      }
    } catch (e) {
      sendingLink.value = false;
      Get.snackbar(
        "Error",
        e.toString(),
        backgroundColor: Color(0xFF4A148C),
        colorText: Colors.white,
      );
    }
  }
}
