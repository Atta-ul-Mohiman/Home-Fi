import 'package:NexaHome/app/modules/home/views/home_view.dart';
import 'package:NexaHome/controller/userDataController.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  var fullName = ''.obs;
  var email = ''.obs;
  var password = ''.obs;
  RxBool isLoading = false.obs;

  var isNameValid = true.obs;
  var isEmailValid = true.obs;

  var hasMinLength = false.obs;
  var hasNumber = false.obs;
  var hasUppercase = false.obs;
  var hasLowercase = false.obs;
  var hasSpecialChar = false.obs;
  RxBool isPasswordVisible = false.obs;
  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }
  final fullNameController = TextEditingController().obs;
  final emailController = TextEditingController().obs;
  final passwordController = TextEditingController().obs;

  final FocusNode fullNameFocus = FocusNode();
  final FocusNode emailFocus = FocusNode();
  final FocusNode passwordFocus = FocusNode();

  void validateInputs() {
    isNameValid.value = fullNameController.value.text.trim().length >= 3;
    isEmailValid.value = GetUtils.isEmail(emailController.value.text.trim());
  }

  void validatePassword(String value) {
    password.value = value;
    hasMinLength.value = value.length >= 8;
    hasNumber.value = value.contains(RegExp(r'\d'));
    hasUppercase.value = value.contains(RegExp(r'[A-Z]'));
    hasLowercase.value = value.contains(RegExp(r'[a-z]'));
    hasSpecialChar.value = value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
  }

  bool get isFormValid =>
      isNameValid.value &&
          isEmailValid.value &&
          hasMinLength.value &&
          hasNumber.value &&
          hasUppercase.value &&
          hasLowercase.value &&
          hasSpecialChar.value;

  void submit() {
    validateInputs();
    validatePassword(passwordController.value.text);
    if (isFormValid) {
      if(isLoading.value ==true){
        print('wait a while...');
      }
      else{
        signUp();
      }

    } else {
      Get.snackbar("Error", "Please fix validation errors");
    }
  }
  Future<void> signUp() async {
    final UserDataController userDataController = Get.put(UserDataController());
    isLoading.value = true;
    try {
      final UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: emailController.value.text.trim(),
        password: passwordController.value.text,
      );

      final uid = userCredential.user?.uid;

      await _firestore.collection("users").doc(uid).set({
        "fullName": fullNameController.value.text.trim(),
        "email": emailController.value.text.trim(),
        "profilePicture":'',
        "createdAt": DateTime.now(),
      });
      userDataController.username.value = fullNameController.value.text;
      userDataController.email.value = emailController.value.text;
      userDataController.profilePic.value = '';
Get.offAll(HomeView());
      Get.snackbar("Success", "Account created successfully",
      backgroundColor: Color(0xFF4A148C),
        colorText: Colors.white
      );
      emailController.value.clear();
      passwordController.value.clear();
    } on FirebaseAuthException catch (e) {
      Get.snackbar("Error", e.message ?? "Signup failed",
          backgroundColor: Color(0xFF4A148C),
          colorText: Colors.white
      );
    } finally {
      isLoading.value = false;
    }
  }


}
