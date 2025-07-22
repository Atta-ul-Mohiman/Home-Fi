import 'package:NexaHome/View/authScreens/loginScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';

class AllUsersPage extends StatelessWidget {
  const AllUsersPage({Key? key}) : super(key: key);

  static const Color darkPurple = Color(0xFF4B0082);
  static const Color white = Colors.white;

  String formatDate(Timestamp timestamp) {
    final date = timestamp.toDate();
    final formatter = DateFormat("d MMM yyyy");
    return "Joined on ${formatter.format(date)}";
  }

  Future<void> deleteUserFromAuth(String uid) async {
    try {
      await FirebaseFirestore.instance.collection('users').doc(uid).delete();
      print('User deleted from Firestore.');
      Get.snackbar('Deleted', 'User deleted successfully',
      backgroundColor: darkPurple,
        colorText: white
      );
    } catch (e) {
      print('Error deleting user from Firestore: $e');
    }
  }


  void showDeleteDialog(BuildContext context, String uid, String name) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: white,
          title: Text(
            'Delete User',
            style: GoogleFonts.nunito(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: darkPurple,
            ),
          ),
          content: Text(
            'Are you sure you want to delete "$name"?',
            style: GoogleFonts.nunito(fontSize: 16),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                'Cancel',
                style: GoogleFonts.nunito(color: Colors.grey[700]),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: darkPurple,
              ),
              onPressed: () async {
               Get.back();
                await deleteUserFromAuth(uid);
              },
              child: Text(
                'Delete',
                style: GoogleFonts.nunito(color: white),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        title: Text(
          'All Users',
          style: GoogleFonts.nunito(
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        centerTitle: true,
        backgroundColor: darkPurple,
        foregroundColor: white,
        elevation: 2,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: InkWell(
              onTap: () {
                FirebaseAuth.instance.signOut();
                Get.offAll(LoginScreen());
              },
              child: const Icon(Icons.logout, color: white),
            ),
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(
              child: Text(
                'No users found.',
                style: GoogleFonts.nunito(
                  fontSize: 16,
                  color: Colors.black54,
                ),
              ),
            );
          }

          final users = snapshot.data!.docs;

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: users.length,
            itemBuilder: (context, index) {
              final data = users[index].data() as Map<String, dynamic>;
              final name = data['fullName'] ?? 'No Name';
              final email = data['email'] ?? 'No Email';
              final uid = users[index].id;
              final createdAt = data['createdAt'] as Timestamp?;

              return Container(
                margin: const EdgeInsets.only(bottom: 16),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: darkPurple.withOpacity(0.2),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // User Icon
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: darkPurple.withOpacity(0.1),
                      ),
                      child: const Icon(
                        Icons.person_outline_rounded,
                        color: darkPurple,
                        size: 28,
                      ),
                    ),
                    const SizedBox(width: 16),

                    // User Details
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            name,
                            style: GoogleFonts.nunito(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: darkPurple,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            email,
                            style: GoogleFonts.nunito(
                              fontSize: 14,
                              color: Colors.black87,
                            ),
                          ),
                          if (createdAt != null) ...[
                            const SizedBox(height: 6),
                            Text(
                              formatDate(createdAt),
                              style: GoogleFonts.nunito(
                                fontSize: 13,
                                color: darkPurple.withOpacity(0.8),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),

                    IconButton(
                      icon: const Icon(
                        Icons.delete_forever_outlined,
                        size: 28,
                      ),
                      color: darkPurple,
                      onPressed: () => showDeleteDialog(context, uid, name),
                      tooltip: "Delete User",
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
