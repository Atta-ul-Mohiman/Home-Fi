import 'dart:async';

import 'package:NexaHome/View/authScreens/loginScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:NexaHome/app/modules/home/views/home_view.dart';

class SplashScreenController extends GetxController
    with SingleGetTickerProviderMixin {
  // animation controller for lottie
  late AnimationController animationController;

  @override
  void onInit() {
    super.onInit();
    // spalsh animation config
    animationController = AnimationController(
      duration: Duration(seconds: 4),
      vsync: this,
    );
    animationController.forward();
    animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        // checkLogin();
        Timer(
          Duration(milliseconds: 1000),
          () {
            if(FirebaseAuth.instance.currentUser?.uid!=null){
              Get.offAll(() => HomeView());
            }
            else{
              Get.offAll(LoginScreen());
            }

          }
        );
      }
    });
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    animationController.dispose();
    super.onClose();
  }
}
