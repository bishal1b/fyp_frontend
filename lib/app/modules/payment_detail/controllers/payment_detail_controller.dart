import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rental/app/models/payments.dart';
import 'package:rental/utils/constant.dart';
import 'package:http/http.dart' as http;
import 'package:rental/utils/memory.dart';

class PaymentDetailController extends GetxController {
  PaymentResponse? paymentsResponse;
  RxBool downloading = false.obs;

  @override
  void onInit() {
    super.onInit();
    getPayments();
    // getPdf();
  }

  Future<void> getPayments() async {
    try {
      var url = Uri.http(ipAddress, 'rental/getPayment');

      var response = await http.post(url, body: {'token': Memory.getToken()});
      var result = paymentResponseFromJson(response.body);

      if (result.success!) {
        paymentsResponse = result;
        update();
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to get payments',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  // Future<void> getPdf() async {
  //   try {
  //     // Create a PDF document
  //     final pw.Document pdf = pw.Document();

  //     // Add a page to the document
  //     pdf.addPage(
  //       pw.Page(
  //         pageFormat: PdfPageFormat.a4,
  //         build: (context) {
  //           return pw.Center(
  //             child: pw.Image(pw.MemoryImage(Uint8List(0)), fit: pw.BoxFit.contain), // Initialize with an empty image
  //           );
  //         },
  //       ),
  //     );

  //     // Get the directory for saving the PDF file
  //     final directory = await getApplicationDocumentsDirectory();
  //     final path = directory.path;

  //     // Write the PDF to a file
  //     final File file = File('$path/invoice.pdf');
  //     await file.writeAsBytes(await pdf.save());

  //     // Open the PDF file
  //     OpenFile.open('$path/invoice.pdf');
  //   } catch (e) {
  //     // Handle any errors that occur during PDF generation or opening
  //     print('Error: $e');
  //     // You can show an error message to the user if needed
  //   }
  // }
}
