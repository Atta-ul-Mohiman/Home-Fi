import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

class UserDataController extends GetxController {
  // Reactive fields
  RxString username = ''.obs;
  RxString email = ''.obs;
  RxString profilePic = ''.obs;
  RxString profilePicPath = ''.obs;
  RxString profilePicName = ''.obs;
  var pickedImageGallery = Rx<File?>(null);

  final nameController = TextEditingController().obs;
  final emailController = TextEditingController().obs;

  void clearUserData() {
    username.value = '';
    email.value = '';
    profilePic.value = '';
  }
  Future<void> getUserData() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) return;

      final userDoc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();

      if (userDoc.exists) {
        final data = userDoc.data()!;
        final userEmail = data['email'] ?? '';
        final firstName = data['fullName'] ?? '';
        final profilePicUrl = data['profilePicture'] ?? '';
        username.value = firstName;
        email.value = userEmail;
        profilePic.value = profilePicUrl;


      }
    } catch (e) {
      print('Error getting user data: $e');
    }
  }
  // For debug/logging
  @override
  void onInit() {
    super.onInit();
    print('UserDataController initialized');
  }

  void updateProfilePic() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      profilePic.value = pickedImage.path;
      pickedImageGallery.value = File(pickedImage.path);

    }
  }
RxBool isUpdating = false.obs;
  void saveChanges() async {
    try {
      isUpdating.value = true;
      username.value = nameController.value.text.trim();
      email.value = emailController.value.text.trim();

      String? savedPath;

      if (pickedImageGallery.value != null) {
        final appDir = await getApplicationDocumentsDirectory();
        final fileName = path.basename(pickedImageGallery.value!.path); // ✅ get correct file name
        final localImage = await pickedImageGallery.value!.copy('${appDir.path}/$fileName');
        profilePicPath.value = localImage.path;
        profilePicName.value = fileName;
        savedPath = localImage.path;
      }

      await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser?.uid).update({
        'email': emailController.value.text,
        'fullName': nameController.value.text,
        if (savedPath != null) 'profilePicture': savedPath,
      });
username.value = nameController.value.text;
email.value = emailController.value.text;
profilePic.value = savedPath??"";
      isUpdating.value = false;
      Get.snackbar("Success", "Profile updated!",
          backgroundColor: Color(0xFF4A148C), colorText: Colors.white);
    } catch (e) {
      isUpdating.value = false;
      print('Error in updating profile $e');
      Get.snackbar("Failed to update", "Failed to update profile",
          backgroundColor: Color(0xFF4A148C), colorText: Colors.white);
    }
  }

}