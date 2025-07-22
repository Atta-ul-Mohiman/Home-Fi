import 'package:NexaHome/View/Devices/DeviceToogle.dart';
import 'package:NexaHome/View/Devices/addDevice.dart';
import 'package:NexaHome/app/global_widgets/animated_switch.dart';
import 'package:NexaHome/app/global_widgets/smart_systems.dart';
import 'package:NexaHome/app/theme/color_theme.dart';
import 'package:NexaHome/app/theme/text_theme.dart';
import 'package:NexaHome/controller/DeviceController.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class AllDevicesScreen extends StatelessWidget {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final Color purple = const Color(0xFF6A1B9A);
  final DeviceController controller = Get.put(DeviceController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Your Devices",
          style: GoogleFonts.nunito(fontWeight: FontWeight.bold,color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: purple,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection('Devices').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(color: Colors.purple,));
          }

          final devices = snapshot.data?.docs ?? [];

          if (devices.isEmpty) {
            return Center(
              child: ElevatedButton(
                onPressed: () {
                  Get.to(()=>AddDeviceScreen());
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: purple,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  "Add Device",
                  style: GoogleFonts.nunito(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            );
          }

          return GridView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: devices.length + 1, // Add one extra for the "Add Device" button
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 1.2,
            ),
            itemBuilder: (context, index) {
              // Show "Add Device" button at the end
              if (index == devices.length) {
                return InkWell(
                  onTap: () {
                    // Navigate to Add Device screen
                    Get.to(() => AddDeviceScreen());
                  },
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  child: Container(
                    height: Get.width * 0.414,
                    width: Get.width * 0.4,
                    margin: EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: GFTheme.lightBlue,
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.add_circle_outline, size: 50, color: GFTheme.primaryMaroon),
                          SizedBox(height: 10),
                          Text(
                            'Add Device',
                            style: HomeFiTextTheme.kSub2HeadTextStyle.copyWith(
                              color: GFTheme.primaryMaroon,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }

              final doc = devices[index];
              final docId = doc.id;
              final name = doc['deviceName'] ?? 'Unnamed';
              final type = doc['deviceType'] ?? 'Unknown';

              controller.initToggle(docId, false); // default toggle

              return InkWell(
                onTap: () {},
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                child: Container(
                  height: Get.width * 0.414,
                  width: Get.width * 0.4,
                  margin: EdgeInsets.only(bottom: 10),
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          height: Get.width * 0.06,
                          width: Get.width * 0.34,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: GFTheme.lightPurple,
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                          height: Get.width * 0.4,
                          width: Get.width * 0.4,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: GFTheme.lightBlue,
                          ),
                          child: Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Positioned(
                                top: 15,
                                left: Get.width * 0.032,
                                child: Image(
                                  image: type == 'LED'
                                      ? AssetImage('assets/images/icons8-light-96.png')
                                      : type == 'Music Player'
                                      ? AssetImage('assets/images/icons8-music-record-96.png')
                                      : AssetImage('assets/images/icons8-rgb-lamp-96.png'),
                                  fit: BoxFit.fill,
                                  height: Get.width * 0.16,
                                ),
                              ),
                              Positioned(
                                top: 20,
                                right: 15,
                                child: Obx(
                                      () => deviceToogle(
                                    isToggled: controller.toggleStates[docId]?.value ?? false,
                                    index: index,
                                    onTap: () {
                                      controller.toggleDevice(docId);
                                      FirebaseFirestore.instance
                                          .collection('Devices')
                                          .doc(docId)
                                          .update({'isOn': controller.toggleStates[docId]!.value});
                                    },
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 25,
                                left: 18,
                                child: Text(
                                  name,
                                  style: HomeFiTextTheme.kSub2HeadTextStyle.copyWith(
                                    color: GFTheme.primaryMaroon,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          );


        },
      ),
    );
  }
}
