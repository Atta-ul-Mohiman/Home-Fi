import 'package:NexaHome/View/Settings/ManageAccount.dart';
import 'package:NexaHome/View/authScreens/loginScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'NexaHome.dart'; // Assuming this contains TermsConditionsScreen

class SettingsScreen extends StatelessWidget {
  final Color darkPurple = Color(0xFF4A148C);
  final Color lightPurple = Color(0xFFEDE7F6);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF6F6F6),
      appBar: AppBar(
        backgroundColor: darkPurple,
        title: Text(
          "Settings",
          style: GoogleFonts.nunito(fontWeight: FontWeight.bold, fontSize: 20,color: Colors.white),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildSettingsCard(
              icon: Icons.person,
              title: "Account",
              subtitle: "Manage your account settings",
              onTap: () {
                Get.to(()=>ManageAccountScreen());
              },
            ),
            // SizedBox(height: 12),
            // _buildSettingsCard(
            //   icon: Icons.notifications,
            //   title: "Notifications",
            //   subtitle: "Customize notification preferences",
            //   onTap: () {
            //     // Navigate to Notification Settings
            //   },
            // ),
            SizedBox(height: 12),
            _buildSettingsCard(
              icon: Icons.privacy_tip,
              title: "Terms & Conditions",
              subtitle: "View app legal policies",
              onTap: () {
                Get.to(() => TermsConditionsScreen());
              },
            ),
         SizedBox(height: Get.height/5,),
            ElevatedButton.icon(
              onPressed: () {
                Get.offAll(LoginScreen());
               FirebaseAuth.instance.signOut();

              },
              icon: Icon(Icons.logout, color: Colors.white),
              label: Text("Logout", style: GoogleFonts.nunito(fontSize: 16,color: Colors.white)),
              style: ElevatedButton.styleFrom(
                backgroundColor: darkPurple,
                minimumSize: Size(double.infinity, 50),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 8,
              offset: Offset(0, 2),
            ),
          ],
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Color(0xFFEDE7F6),
                shape: BoxShape.circle,
              ),
              padding: EdgeInsets.all(10),
              child: Icon(icon, color: darkPurple),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: GoogleFonts.nunito(fontSize: 16, fontWeight: FontWeight.w600)),
                  SizedBox(height: 4),
                  Text(subtitle, style: GoogleFonts.nunito(fontSize: 13, color: Colors.grey[600])),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios_rounded, size: 16, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}
