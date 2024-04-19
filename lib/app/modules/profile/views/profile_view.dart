import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rental/app/routes/app_pages.dart';
import 'package:rental/utils/constant.dart';
import 'package:rental/utils/memory.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(ProfileController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
        centerTitle: true,
      ),
      body: GetBuilder<ProfileController>(
        builder: (controller) {
          if (controller.userResponse == null) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          var user = controller.userResponse!.user!;

          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      height: 150,
                      width: 150,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [Color(0xFF2E9E95), Color(0xFF8A2387)],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            blurRadius: 10,
                            offset: Offset(0, 5),
                          ),
                        ],
                      ),
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(75),
                      child: user.imageUrl != null
                          ? Image.network(
                              getImageUrl(user.imageUrl!),
                              height: 150,
                              width: 150,
                              fit: BoxFit.cover,
                            )
                          : Text(
                              user.fullName![0].toUpperCase(),
                              style:
                                  TextStyle(fontSize: 60, color: Colors.white),
                            ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Text(
                  user.fullName?.toUpperCase() ?? '',
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87),
                ),
                SizedBox(height: 10),
                Text(
                  user.email!,
                  style: TextStyle(fontSize: 18, color: Colors.black54),
                ),
                SizedBox(height: 40),
                Visibility(
                  visible: Memory.getRole() == 'admin',
                  child: ProfileMenuItem(
                    onTap: () => Get.toNamed(Routes.GPS_TRACKING),
                    icon: Icons.track_changes_outlined,
                    title: 'Track Vehicle',
                  ),
                ),
                Visibility(
                  visible: Memory.getRole() == 'admin',
                  child: ProfileMenuItem(
                    onTap: () => Get.toNamed(Routes.ADMIN_CATEGORY),
                    icon: Icons.category,
                    title: 'Vehicle Category',
                  ),
                ),
                ProfileMenuItem(
                  onTap: () => Get.toNamed(Routes.BOOKINGS),
                  icon: Icons.book_online,
                  title: 'Bookings',
                ),
                ProfileMenuItem(
                  onTap: () => Get.toNamed(Routes.PAYMENTS),
                  icon: Icons.payment,
                  title: 'Payments',
                ),
                ProfileMenuItem(
                  onTap: () {
                    Get.toNamed(Routes.CHANGE_PASSWORD);
                  },
                  icon: Icons.change_circle,
                  title: 'Change Password',
                ),
                ProfileMenuItem(
                  onTap: () =>
                      Get.toNamed(Routes.EDIT_PROFILE, arguments: user),
                  icon: Icons.account_box, 
                  title: 'Edit Profile',
                ),
                ProfileMenuItem(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text("Logout Confirmation"),
                          content: Text("Are you sure you want to logout?"),
                          actions: [
                            TextButton(
                              onPressed: () => Get.back(),
                              child: Text(
                                "Cancel",
                                style: TextStyle(color: Colors.red),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Memory.clear();
                                Get.offAllNamed(Routes.LOGIN);
                              },
                              child: Text("Confirm"),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  icon: Icons.logout,
                  title: 'Logout',
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class ProfileMenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const ProfileMenuItem({
    Key? key,
    required this.icon,
    required this.title,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      title: Text(
        title,
        style: TextStyle(
            fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
      ),
      leading: Icon(
        icon,
        size: 24,
        color: Color(0xFF2E9E95),
      ),
      trailing: Icon(
        Icons.arrow_forward_ios,
        size: 16,
        color: Color(0xFF2E9E95),
      ),
    );
  }
}
