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
      backgroundColor: Color.fromARGB(255, 234, 240, 235),
      appBar: AppBar(
        // backgroundColor: Color(0xFF2E9E95),
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

          return Column(
            children: [
              const SizedBox(height: 30),
              CircleAvatar(
                backgroundColor: Color(0xFF2E9E95),
                radius: 50,
                child: user.imageUrl != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(60),
                        child: Image.network(
                          getImageUrl(user.imageUrl!),
                          height: 120,
                          width: 120,
                          fit: BoxFit.cover,
                        ),
                      )
                    : Text(
                        user.fullName![0].toUpperCase(),
                        style:
                            const TextStyle(fontSize: 40, color: Colors.white),
                      ),
              ),
              const SizedBox(height: 20),
              Text(
                user.fullName?.toUpperCase() ?? '',
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 5),
              Text(
                user.email!,
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 40),
              ListTile(
                onTap: () {
                  Get.toNamed(Routes.BOOKINGS);
                },
                title: const Text("My Bookings"),
                trailing: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.book_online),
                ),
              ),
              ListTile(
                onTap: () {
                  Get.toNamed(Routes.PAYMENTS);
                },
                title: const Text("Payments"),
                trailing: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.payment),
                ),
              ),
              ListTile(
                title: Text("Change Password"),
                trailing: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.change_circle),
                ),
              ),
              ListTile(
                onTap: () {
                  Get.toNamed(Routes.EDIT_PROFILE, arguments: user);
                },
                title: Text("Edit Profile"),
                trailing: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.account_box),
                ),
              ),
              ListTile(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text("Logout Confirmation"),
                        content: Text("Are you sure you want to logout?"),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Get.close(1);
                              },
                              child: Text("Cancel")),
                          TextButton(
                              onPressed: () {
                                Memory.clear();
                                Get.offAllNamed(Routes.LOGIN);
                              },
                              child: Text("Confirm"))
                        ],
                      );
                    },
                  );
                },
                title: Text("Logout"),
                trailing: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.logout),
                ),
              )
            ],
          );
        },
      ),
      floatingActionButton: Visibility(
        visible: Memory.getRole() == 'admin',
        child: FloatingActionButton(
          backgroundColor: Color(0xFF2E9E95),
          onPressed: () {
            Get.toNamed(Routes.ADD_VEHICLE);
          },
          child: const Icon(
            Icons.add,
          ),
        ),
      ),
    );
  }
}
