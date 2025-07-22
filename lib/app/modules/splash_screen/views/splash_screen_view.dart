import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:NexaHome/app/theme/text_theme.dart';
import 'package:lottie/lottie.dart';

import '../controllers/splash_screen_controller.dart';

class SplashScreenView extends GetView<SplashScreenController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: GetBuilder<SplashScreenController>(builder: (_) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            Image.asset('assets/images/logo.jpeg'),
              SizedBox(
                height: 80.0,
              ),

            ],
          );
        }),
      ),
    );
  }
}
