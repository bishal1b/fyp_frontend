import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:rental/app/components/mybutton.dart';
import 'package:rental/app/models/payments.dart';
import 'package:rental/app/modules/payment_detail/controllers/payment_detail_controller.dart';
import 'package:rental/utils/constant.dart';
import 'package:rental/utils/memory.dart';

class PaymentDetailView extends StatelessWidget {
  final Payment payment = Get.arguments;

  PaymentDetailView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(PaymentDetailController());
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment Details'),
        centerTitle: true,
      ),
      body: GetBuilder<PaymentDetailController>(
        builder: (controller) => SingleChildScrollView(
          child: Container(
            color: Colors.white,
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    'Invoice',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2E9E95),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildInvoiceItem(
                            'Payment ID: ', payment.paymentId ?? 'N/A'),
                        _buildInvoiceItem(
                            'Booking ID: ', payment.bookingId ?? 'N/A'),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildInvoiceItem('Date: ',
                            DateFormat.yMMMd().format(payment.createdAt!)),
                        _buildInvoiceItem('Mode: ', payment.mode),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Center(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.network(
                        getImageUrl(
                          payment.imageUrl ?? '',
                        ),
                        height: 120,
                        width: 200,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'Vehicle Details',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2E9E95),
                  ),
                ),
                _buildInvoiceItem('Title:', payment.title),
                _buildInvoiceItem('Model no.:', payment.noOfSeats),
                _buildInvoiceItem('Start Date:',
                    DateFormat.yMMMd().format(payment.startDate!)),
                _buildInvoiceItem(
                    'End Date:', DateFormat.yMMMd().format(payment.endDate!)),
                Text(
                  'Description:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.blueGrey,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                SizedBox(width: 350, child: Text(payment.description!)),
                SizedBox(height: 20),
                Container(
                  decoration: BoxDecoration(),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Text(
                          'Total Amount: ',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blueGrey,
                              fontSize: 20),
                        ),
                        Spacer(),
                        Text(
                          'Rs. ${payment.total}',
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.green,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                ),
                Visibility(
                  visible: Memory.getRole() == 'admin',
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildInvoiceItem('Paid By: ', payment.fullName),
                      _buildInvoiceItem('Contact: ', payment.contact),
                      _buildInvoiceItem('Address: ', payment.address),
                      _buildInvoiceItem('Email: ', payment.email),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      // bottomNavigationBar: Visibility(
      //     visible: Memory.getRole() == 'user',
      //     child: MyButton(
      //         text: 'Download Invoice',
      //         onPressed: () {
      //           PaymentDetailController controller =
      //               Get.find<PaymentDetailController>();
      //           controller.getPdf();
      //         })),
    );
  }

  Widget _buildInvoiceItem(String title, String? value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.blueGrey,
            ),
          ),
          Text(
            value ?? 'N/A',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
