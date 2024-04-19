import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart'; // Import for date formatting
import 'package:rental/app/models/adminUser.dart';
import 'package:rental/utils/constant.dart';
import '../controllers/user_detail_controller.dart';

class UserDetailView extends StatelessWidget {
  final User user = Get.arguments;

  UserDetailView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(UserDetailController());

    String formattedDate = DateFormat.yMMMd().format(user.createdAt!);

    return Scaffold(
      appBar: AppBar(
        title: Text('User Details'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Text(
                  'User ID: ${user.userId!}',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      color: Colors.blueGrey),
                ),
                Spacer(),
                Text(
                  'Registered on: $formattedDate',
                  textAlign: TextAlign.end,
                  style: TextStyle(
                    fontSize: 20,
                    fontStyle: FontStyle.italic,
                    color: Colors.blueGrey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Center(
              child: Stack(
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
                            errorBuilder: (context, error, stackTrace) {
                              return Text(
                                user.fullName![0].toUpperCase(),
                                style: TextStyle(
                                    fontSize: 60, color: Colors.white),
                              );
                            },
                          )
                        : Text(
                            user.fullName![0].toUpperCase(),
                            style: TextStyle(fontSize: 60, color: Colors.white),
                          ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            // User Details
            _buildDetailRow('Full Name:', user.fullName ?? 'N/A'),
            _buildDetailRow('Contact:', user.contact ?? 'N/A'),
            _buildDetailRow('Address:', user.address ?? 'N/A'),
            _buildDetailRow('Email:', user.email ?? 'N/A'),
            SizedBox(height: 10),
            Text('Licence Image:',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                    color: Colors.blueGrey)),
            SizedBox(height: 10),
            Center(
              child: user.liscenceImage != null
                  ? Image.network(
                      getImageUrl(user.liscenceImage!),
                      height: 240,
                      width: 410,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Text(
                          'License Image N/A',
                          style: TextStyle(fontSize: 20, color: Colors.red),
                        );
                      },
                    )
                  : Text(
                      'License Image N/A',
                      style: TextStyle(fontSize: 20, color: Colors.red),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 20,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.bold,
              color: Colors.blueGrey,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 20,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
