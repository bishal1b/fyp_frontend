import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rental/app/models/payments.dart';
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
              itemBuilder: (context, index) => PaymentCard(
                payment: controller.paymentsResponse!.payments![index],
              ),
            );
          },
        ),
      ),
    );
  }
}

class PaymentCard extends StatelessWidget {
  final Payment payment;
  const PaymentCard({Key? key, required this.payment}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var amount = int.tryParse(payment.amount ?? '0');
    var amountInRS = amount != null ? amount / 100 : 0;

    return Card(
      child: ListTile(
        title: Text(
          "Rs. $amountInRS",
          style: TextStyle(
            fontSize: 20,
            color: Colors.green,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
                "Date: ${DateTime.parse(payment.createdAt!).year}-${DateTime.parse(payment.createdAt!).month}-${DateTime.parse(payment.createdAt!).day}"),
            Text("Name: ${payment.fullName ?? 'N/A'}"),
            Text("Email: ${payment.email ?? 'N/A'}"),
          ],
        ),
      ),
    );
  }
}
