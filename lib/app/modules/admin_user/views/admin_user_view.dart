import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:rental/app/components/mybutton.dart';
import 'package:rental/app/models/adminUser.dart';
import 'package:rental/app/routes/app_pages.dart';

import '../controllers/admin_user_controller.dart';

class AdminUserView extends GetView<AdminUserController> {
  const AdminUserView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Get.put(AdminUserController());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Users'),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await controller.getUsers();
        },
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          child: GetBuilder<AdminUserController>(
            builder: (controller) {
              if (controller.adminUserResponse == null) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              var adminUsers = controller.adminUserResponse?.users
                      ?.where((user) => user.role == 'admin')
                      .toList() ??
                  [];
              var normalUsers = controller.adminUserResponse?.users
                      ?.where((user) => user.role == 'user')
                      .toList() ??
                  [];

              return DefaultTabController(
                length: 2,
                child: Column(
                  children: [
                    TabBar(
                      labelStyle: const TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                      ),
                      tabs: [
                        Tab(
                          text: 'Users',
                        ),
                        Tab(
                          text: 'Admins',
                        ),
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height -
                          kToolbarHeight -
                          kBottomNavigationBarHeight -
                          60, // Adjust the height according to your needs
                      child: TabBarView(
                        children: [
                          ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: normalUsers.length,
                            itemBuilder: (context, index) => UserCard(
                              user: normalUsers[index],
                            ),
                          ),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: adminUsers.length,
                            itemBuilder: (context, index) => UserCard(
                              user: adminUsers[index],
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFF2E9E95),
        onPressed: () {
          Get.dialog(
            const AddUserDialog(),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class UserCard extends StatelessWidget {
  final User user;
  const UserCard({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: GestureDetector(
        onTap: () {
          Get.toNamed(Routes.USER_DETAIL, arguments: user);
        },
        child: ListTile(
          title: Text(toBeginningOfSentenceCase(user.fullName) ?? ''),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(user.email ?? ''),
              Text(
                user.contact!,
              ),
            ],
          ),
          isThreeLine: true,
          trailing: Text(
            user.role?.toUpperCase() ?? '',
            style: TextStyle(
              color: user.role == 'admin' ? Colors.red : Colors.green,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

class AddUserDialog extends StatelessWidget {
  const AddUserDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog.fullscreen(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Add User'),
          centerTitle: true,
        ),
        body: GetBuilder<AdminUserController>(
          builder: (controller) => SingleChildScrollView(
            child: Form(
              key: controller.formKey,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    Text(
                      'Select Liscence Image',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    controller.imageBytes != null
                        ? Stack(
                            children: [
                              Image.memory(
                                controller.imageBytes!,
                                height: 200,
                              ),
                              Positioned(
                                right: 0,
                                child: IconButton(
                                    padding: EdgeInsets.all(0.0),
                                    style: IconButton.styleFrom(
                                      padding: EdgeInsets.all(0.0),
                                    ),
                                    onPressed: controller.onImageDelete,
                                    icon: Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    )),
                              )
                            ],
                          )
                        : const SizedBox(),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF2E9E95),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      onPressed: controller.onImagePick,
                      child: Text(
                        'Pick Image',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Visibility(
                      visible: controller.isImageError,
                      child: Text(
                        'Please select image',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                        textInputAction: TextInputAction.next,
                        controller: controller.fullNameController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          hintText: "Full Name",
                          labelText: "Full Name",
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Field Required";
                          }
                          return null;
                        }),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                        textInputAction: TextInputAction.next,
                        controller: controller.contactController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          hintText: "Phone Number",
                          labelText: "Phone Number",
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Field Required";
                          } else if (value.length < 10 || value.length > 10) {
                            return "Phone number must be 10 character";
                          }
                          return null;
                        }),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                        textInputAction: TextInputAction.next,
                        controller: controller.addressController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          hintText: "Address",
                          labelText: "Address",
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Field Required";
                          }
                          return null;
                        }),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                        textInputAction: TextInputAction.next,
                        controller: controller.emailController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          hintText: "Email",
                          labelText: "Email",
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Field Required";
                          } else if (!GetUtils.isEmail(value)) {
                            return "please enter valid email";
                          }
                          return null;
                        }),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                        textInputAction: TextInputAction.next,
                        controller: controller.passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          hintText: "Password",
                          labelText: "Password",
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter your password";
                          } else if (value.length < 6) {
                            return "Password must be at least 6 characters long";
                          } else if (!RegExp(
                                  r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#$%^&*()_+{}|:"<>?/\\~-]).{6,}$')
                              .hasMatch(value)) {
                            return "Password must contain at least one uppercase letter, one lowercase letter, one digit, and one special character";
                          }
                          return null;
                        }),
                    const SizedBox(height: 20),
                    DropdownButtonFormField<String>(
                      value: controller.selectedRole.value,
                      items: const [
                        DropdownMenuItem(
                          value: 'admin',
                          child: Text('Admin'),
                        ),
                        DropdownMenuItem(
                          value: 'user',
                          child: Text('User'),
                        ),
                      ],
                      onChanged: (v) {
                        if (v == null) {
                          return;
                        }
                        controller.selectedRole.value = v;
                      },
                      validator: (v) {
                        if (v == null || v.isEmpty) {
                          return 'Please select your property type';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        hintText: 'Select your property type',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 40),
                    MyButton(
                      text: 'Add User',
                      onPressed: controller.addUser,
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
