import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:rental/app/components/mybutton.dart';
import 'package:rental/app/models/bookings.dart';
import 'package:rental/app/modules/bookings/controllers/bookings_controller.dart';
import 'package:rental/app/modules/vehicle/controllers/vehicle_controller.dart';
import 'package:rental/utils/constant.dart';
import 'package:rental/utils/memory.dart';
import '../controllers/booking_detail_controller.dart';

class BookingDetailView extends GetView<BookingDetailController> {
  final Booking booking = Get.arguments;

  BookingDetailView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(BookingsController());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Booking Details'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 20.0, top: 10),
                  padding: EdgeInsets.symmetric(vertical: 10.0),
                  width: 400,
                  height: 300, // Adjust as needed
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(getImageUrl(booking.imageUrl ?? '')),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 20, left: 20, right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        booking.title ?? 'N/A',
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Icon(
                        Icons.star,
                        color: Colors.orange,
                        size: 22,
                      ),
                      Text(
                        booking.rating ?? '',
                        style: TextStyle(fontSize: 22, color: Colors.black),
                      ),
                    ],
                  ),
                  SizedBox(height: 3),
                  Text(
                    booking.status ?? 'N/A',
                    style: TextStyle(
                      fontSize: 20,
                      color: booking.status == 'Pending'
                          ? Colors.orange
                          : booking.status == 'Success'
                              ? Colors.green
                              : Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Visibility(
                    visible: Memory.getRole() == 'admin',
                    child: Text(
                      "Plate Number:  ${booking.plateNumber ?? ''}",
                      style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueGrey,
                          fontStyle: FontStyle.italic),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    "Model:  ${booking.model ?? ''}",
                    style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueGrey,
                        fontStyle: FontStyle.italic),
                  ),
                  SizedBox(height: 10),
                  _buildDetailRow('Booking Dates:',
                      '${booking.startDate?.toLocal().toString().split(' ')[0]} - ${booking.endDate?.toLocal().toString().split(' ')[0]}'),
                  _buildDetailRow('Total (Rs.):', booking.total ?? 'N/A'),
                  SizedBox(height: 10),
                  Text('Description:',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                          color: Colors.blueGrey)),
                  Text(booking.description ?? 'N/A'),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Visibility(
                        visible: Memory.getRole() == 'user' &&
                            booking.status == 'pending',
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.red),
                          ),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text(
                                    "Cancel Booking",
                                    style: TextStyle(color: Colors.red),
                                  ),
                                  content:
                                      Text("Are you sure you want to cancel?"),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          Get.close(1);
                                        },
                                        child: Text(
                                          "Cancel",
                                          style: TextStyle(color: Colors.red),
                                        )),
                                    TextButton(
                                        onPressed: () {
                                          Get.find<BookingsController>()
                                              .cancelBooking(
                                                  booking.bookingId!);
                                        },
                                        child: Text("Confirm"))
                                  ],
                                );
                              },
                            );
                          },
                          child: Text('Cancel', style: TextStyle(fontSize: 20)),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Visibility(
                        visible: Memory.getRole() == 'user' &&
                            booking.status == 'pending',
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Color(0xFF2E9E95)),
                          ),
                          onPressed: () {
                            Get.find<VehicleController>().makePayment(
                                int.parse(booking.bookingId!),
                                int.parse(booking.total!) * 100);
                          },
                          child: Text('Make Payment',
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white)),
                        ),
                      ),
                    ],
                  ),
                  Visibility(
                    visible: Memory.getRole() == 'admin',
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 20),
                        Text(
                          'Customer Details:',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF2E9E95),
                          ),
                        ),
                        _buildDetailRow('Name:', booking.fullName ?? 'N/A'),
                        _buildDetailRow('Email:', booking.email ?? 'N/A'),
                        _buildDetailRow('Contact:', booking.contact ?? 'N/A'),
                        _buildDetailRow('Address:', booking.address ?? 'N/A'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Visibility(
        visible: Memory.getRole() == 'user' && booking.status == 'Success',
        child: MyButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return RatingDialog(vehicleId: booking.vehicleId ?? '');
              },
            );
          },
          text: "Give Rating",
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
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey,
                fontStyle: FontStyle.italic),
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

class RatingDialog extends StatelessWidget {
  final String vehicleId;
  const RatingDialog({Key? key, required this.vehicleId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var bookingsController = Get.find<BookingsController>();
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Give Rating',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            RatingBar.builder(
              initialRating: 0,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: false,
              itemCount: 5,
              itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) => Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (rating) {
                bookingsController.selectedRating = rating;
              },
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () {
                bookingsController.giveRating(vehicleId);
                Get.back();
              },
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
