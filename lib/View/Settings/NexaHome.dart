import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class TermsConditionsScreen extends StatelessWidget {
  final Color darkPurple = const Color(0xFF4A148C);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: darkPurple,
        leading: InkWell(
            onTap: (){
              Get.back();
            },
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            child: Icon(Icons.arrow_back_ios,color: Colors.white,size: 18,)),
        title: Text("Terms & Conditions",
            style: GoogleFonts.nunito(fontWeight: FontWeight.w400,color: Colors.white)),
        centerTitle: true
        ,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _sectionCard(
                context,
                title: "Welcome to NexaHome!",
                icon: Icons.home_rounded,
                content:
                "By using NexaHome, you agree to the following Terms & Conditions:",
              ),
              const SizedBox(height: 12),
              _sectionCard(
                context,
                title: "1. Usage Agreement",
                icon: Icons.check_circle_outline,
                content:
                "NexaHome provides services to help users discover, manage, and interact with home-related offerings. Usage must comply with applicable laws.",
              ),
              const SizedBox(height: 12),
              _sectionCard(
                context,
                title: "2. Privacy",
                icon: Icons.lock_outline,
                content:
                "Your privacy is important. We do not sell your personal data. All data is securely stored and used solely to improve your NexaHome experience.",
              ),
              const SizedBox(height: 12),
              _sectionCard(
                context,
                title: "3. User Responsibilities",
                icon: Icons.person_outline,
                content:
                "Users must provide accurate information and use the app respectfully. Any misuse may lead to suspension.",
              ),
              const SizedBox(height: 12),
              _sectionCard(
                context,
                title: "4. Content",
                icon: Icons.article_outlined,
                content:
                "NexaHome is not liable for user-generated content. We reserve the right to remove content that violates our policies.",
              ),
              const SizedBox(height: 12),
              _sectionCard(
                context,
                title: "5. Changes to Terms",
                icon: Icons.sync_alt_outlined,
                content:
                "NexaHome may update these terms at any time. Continued use of the app implies acceptance of the new terms.",
              ),
              const SizedBox(height: 12),
              _sectionCard(
                context,
                title: "6. Support",
                icon: Icons.support_agent_outlined,
                content:
                "For any questions, please contact support@nexahome.com.",
              ),
              const SizedBox(height: 24),
              Center(
                child: Text(
                  "Thank you for using NexaHome!",
                  style: GoogleFonts.nunito(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: darkPurple),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _sectionCard(BuildContext context,
      {required String title,
        required String content,
        required IconData icon}) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      elevation: 3,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: darkPurple),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    title,
                    style: GoogleFonts.nunito(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: darkPurple,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              content,
              style: GoogleFonts.nunito(
                  fontSize: 15, color: Colors.black87, height: 1.4),
            ),
          ],
        ),
      ),
    );
  }
}
