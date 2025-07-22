import 'package:NexaHome/View/Admin/adminScreen.dart';
import 'package:NexaHome/app/modules/home/views/home_view.dart';
import 'package:NexaHome/controller/userDataController.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  var isPasswordVisible = false.obs;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }


  RxBool loggingUser = false.obs;
  Future<void> loginUser(String email, String password) async {
    final UserDataController userDataController = Get.put(UserDataController());
    try {
      loggingUser.value = true;
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      String uid = userCredential.user!.uid;
      if(email.toLowerCase()=='nexaadmin@gmail.com'){
        Get.offAll(AllUsersPage());
        Get.snackbar("Success", "Logged in successfully!",
            backgroundColor: Color(0xFF4A148C), colorText: Colors.white);
      }
      else{
        DocumentSnapshot userDoc =
        await _firestore.collection('users').doc(uid).get();

        if (userDoc.exists) {
          await  userDataController.getUserData();
          Get.offAll(()=>HomeView());
          loggingUser.value = false;
          Get.snackbar("Success", "Logged in successfully!",
              backgroundColor: Color(0xFF4A148C), colorText: Colors.white);
        } else {
          loggingUser.value = false;
          Get.snackbar("Error", "User  not found!",
              backgroundColor:Color(0xFF4A148C), colorText: Colors.white);
        }
      }


    } on FirebaseAuthException catch (e) {
      loggingUser.value = false;
      Get.snackbar("Login Failed", e.message ?? "An error occurred",
          backgroundColor:Color(0xFF4A148C), colorText: Colors.white);
    } catch (e) {
      loggingUser.value = false;
      Get.snackbar("Error", e.toString(),
          backgroundColor: Color(0xFF4A148C), colorText: Colors.white);
    }
  }
}
