import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:rental/app/models/bookings.dart';
import 'package:rental/app/routes/app_pages.dart';
import 'package:rental/utils/constant.dart';

import '../controllers/bookings_controller.dart';

class BookingsView extends GetView<BookingsController> {
  const BookingsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Get.put(BookingsController());
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 234, 240, 235),
      appBar: AppBar(
        backgroundColor: Color(0xFF2E9E95),
        title: const Text('Bookings'),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await controller.getBookings();
        },
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: GetBuilder<BookingsController>(
              builder: (controller) {
                if (controller.bookingsResponse == null) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                var pendingBookings = controller.bookingsResponse?.bookings
                        ?.where((bookings) => bookings.status == 'pending')
                        .toList() ??
                    [];
                var successBookings = controller.bookingsResponse?.bookings
                        ?.where((user) => user.status == 'Success')
                        .toList() ??
                    [];
                return DefaultTabController(
                  length: 2,
                  child: Column(
                    children: [
                      TabBar(
                        indicatorColor: Color(0xFF2E9E95),
                        labelStyle: const TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                        ),
                        tabs: [
                          Tab(
                            text: 'Pendings',
                          ),
                          Tab(
                            text: 'Success',
                          ),
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height -
                            kToolbarHeight -
                            kBottomNavigationBarHeight -
                            140, // Adjust the height according to your needs
                        child: TabBarView(
                          children: [
                            ListView.builder(
                              shrinkWrap: true,
                              physics: BouncingScrollPhysics(),
                              itemCount: pendingBookings.length,
                              itemBuilder: (context, index) => BookingCard(
                                booking: pendingBookings[index],
                              ),
                            ),
                            ListView.builder(
                              physics: BouncingScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: successBookings.length,
                              itemBuilder: (context, index) => BookingCard(
                                booking: successBookings[index],
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
      ),
    );
  }
}

class BookingCard extends StatelessWidget {
  final Booking booking;

  const BookingCard({Key? key, required this.booking}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(Routes.BOOKING_DETAIL, arguments: booking);
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Image Container
                  Hero(
                    tag:
                        'booking_image_${booking.bookingId}', // Unique tag for each image
                    child: Container(
                      width: 140, // Adjusted width for the image
                      height: 140, // Adjusted height for the image
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                          image:
                              NetworkImage(getImageUrl(booking.imageUrl ?? '')),
                          fit: BoxFit
                              .fill, // Ensure the image covers the entire container
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 15),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          booking.title ?? 'N/A',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          booking.status ?? 'N/A',
                          style: TextStyle(
                            fontSize: 18,
                            color: booking.status == 'Pending'
                                ? Colors.orange
                                : booking.status == 'Success'
                                    ? Colors.green
                                    : Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Booking Dates:',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.blueGrey,
                          ),
                        ),
                        Text(
                          '${booking.startDate?.toLocal().toString().split(' ')[0]} - ${booking.endDate?.toLocal().toString().split(' ')[0]}',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Text(
                              'Total (Rs.): ${booking.total}',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.blueGrey,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
