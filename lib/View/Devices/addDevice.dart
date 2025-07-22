import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class AddDeviceScreen extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final RxString selectedType = ''.obs;

  final List<String> deviceTypes = [
    'LED',
    'Music Player',
    'RGB LED',
    'TV',
    'AC',
    'Camera',
    'Refrigerator'
  ];

  final Color purple = const Color(0xFF6A1B9A);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: purple,
        title: Text(
          "Add Device",
          style: GoogleFonts.nunito(fontWeight: FontWeight.bold,color: Colors.white),
        ),
        centerTitle: true
        ,
        leading: InkWell(
            onTap: (){
              Get.back();
            },
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            child: Icon(Icons.arrow_back_ios,color: Colors.white,size: 18,)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Obx(() {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Device Name",
                style: GoogleFonts.nunito(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  hintText: 'Enter device name',
                  filled: true,
                  fillColor: Colors.grey[100],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                "Device Type",
                style: GoogleFonts.nunito(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                value: selectedType.value.isEmpty ? null : selectedType.value,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[100],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
                hint: Text("Select a type", style: GoogleFonts.nunito()),
                items: deviceTypes.map((String type) {
                  return DropdownMenuItem<String>(
                    value: type,
                    child: Text(type, style: GoogleFonts.nunito()),
                  );
                }).toList(),
                onChanged: (value) {
                  selectedType.value = value!;
                },
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: purple,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: ()async {
                    final name = nameController.text.trim();
                    final type = selectedType.value.trim();

                    if (name.isEmpty || type.isEmpty) {
                      Get.snackbar("Missing Info", "Please fill all fields",
                          backgroundColor: Color(0xFF4A148C), colorText: Colors.white);
                      return;
                    }
                    FirebaseFirestore.instance
                        .collection('users').doc(FirebaseAuth.instance.currentUser?.uid).
                    collection('Devices').add({
                      'deviceType':type,
                      'deviceName':name
                      ,'isOn':false,
                    });

                    Get.snackbar("Success", "Device Added: $name ($type)",
                        backgroundColor:  Color(0xFF4A148C), colorText: Colors.white);

                    nameController.clear();
                    selectedType.value = '';
                  },
                  child: Text(
                    "Add Device",
                    style: GoogleFonts.nunito(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
