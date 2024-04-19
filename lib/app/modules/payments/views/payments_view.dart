import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rental/app/models/payments.dart';
import 'package:rental/app/routes/app_pages.dart';
import 'package:rental/utils/memory.dart';
import '../controllers/payments_controller.dart';

class PaymentsView extends GetView<PaymentsController> {
  const PaymentsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(PaymentsController());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payments'),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await controller.getPayments();
        },
        child: GetBuilder<PaymentsController>(
          builder: (controller) {
            if (controller.paymentsResponse == null) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView.builder(
              itemCount: controller.paymentsResponse?.payments?.length ?? 0,
              itemBuilder: (context, index) {
                return PaymentCard(
                  payment: controller.paymentsResponse!.payments![index],
                  isLastItem: index ==
                      controller.paymentsResponse!.payments!.length - 1,
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class PaymentCard extends StatelessWidget {
  final Payment payment;
  final bool isLastItem;
  const PaymentCard({Key? key, required this.payment, required this.isLastItem})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var amount = int.tryParse(payment.amount ?? '0');
    var amountInRS = amount != null ? amount / 100 : 0;

    // Format the date and time
    var dateTime = (payment.createdAt!);
    var formattedDateTime =
        '${dateTime.year}-${dateTime.month}-${dateTime.day}';

    var startDateTime = (payment.startDate!);
    var formattedStartDateTime =
        '${startDateTime.year}-${startDateTime.month}-${startDateTime.day}';

    var endDateTime = (payment.endDate!);
    var formattedEndDateTime =
        '${endDateTime.year}-${endDateTime.month}-${endDateTime.day}';
    return Card(
      elevation: 3,
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: GestureDetector(
          onTap: () {
            Get.toNamed(Routes.PAYMENT_DETAIL, arguments: payment);
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Amount: Rs. $amountInRS",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  Text(
                    "Paid Date: $formattedDateTime",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  Spacer(), // Add space to separate date and time
                ],
              ),
              SizedBox(height: 8),
              Visibility(
                visible: Memory.getRole() == 'user',
                child: Text(
                  "Title: ${payment.title ?? 'N/A'}",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
              Visibility(
                visible: Memory.getRole() == 'admin',
                child: Text(
                  "Name: ${payment.fullName ?? 'N/A'}",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
              SizedBox(height: 8),
              Text(
                "From:  ${formattedStartDateTime}      To:  ${formattedEndDateTime}",
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10),
                  Text(
                    "Payment Mode: ${payment.mode ?? 'N/A'}",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2E9E95)),
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
