import 'dart:io';

import 'package:NexaHome/controller/userDataController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ManageAccountScreen extends StatefulWidget {
  @override
  State<ManageAccountScreen> createState() => _ManageAccountScreenState();
}

class _ManageAccountScreenState extends State<ManageAccountScreen> {
  final controller = Get.put(UserDataController());

  final Color darkPurple = Color(0xFF4A148C);
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){
      controller.emailController.value.text = controller.email.value;
      controller.nameController.value.text = controller.username.value;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: darkPurple,
        leading: InkWell(
            onTap: (){
              Get.back();
            },
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            child: Icon(Icons.arrow_back_ios,color: Colors.white,size: 18,)),
        title: Text("Manage Account", style: GoogleFonts.nunito(color: Colors.white)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Obx(() => Column(
          children: [
            GestureDetector(
              onTap: controller.updateProfilePic,
              child: CircleAvatar(
                radius: 50,
                backgroundColor: Colors.grey[300],
                backgroundImage: controller.profilePic.value.isEmpty
                    ? null
                    : FileImage(File(controller.profilePic.value)),
                child: controller.profilePic.value.isEmpty
                    ? Icon(Icons.camera_alt, color: darkPurple, size: 30)
                    : null,
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: controller.nameController.value,
              style: GoogleFonts.nunito(),
              decoration: InputDecoration(
                labelText: "Name",
                prefixIcon: Icon(Icons.person, color: darkPurple),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: darkPurple, width: 2),
                ),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: controller.emailController.value,
              style: GoogleFonts.nunito(),
              decoration: InputDecoration(
                labelText: "Email",
                prefixIcon: Icon(Icons.email, color: darkPurple),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: darkPurple, width: 2),
                ),
              ),
            ),
            SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: darkPurple,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed:(){
                  if(controller.isUpdating.value ==true){
                    print('Updating...');
                  }
                  else{
                    controller.saveChanges();
                  }
                },
                child: Obx(
                    ()=>controller.isUpdating.value ==true?
                        Center(
                          child: CircularProgressIndicator(color: Colors.white,),
                        )
                        : Text("Save Changes",
                      style: GoogleFonts.nunito(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 16)),
                ),
              ),
            )
          ],
        )),
      ),
    );
  }
}
