import 'package:flutter/material.dart';
import 'package:manageit_school/models/payment.dart';
import 'package:manageit_school/services/payment_service.dart';

class PaymentDetails extends StatelessWidget {
  static const routeName = 'PaymentDetails';
  final int id;
  const PaymentDetails({
    super.key,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Payment>>(
      future: PaymentService().getPaymentDetailsByID(id),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Payment Details'),
            ),
            body: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Payment Details'),
            ),
            body: const Center(
              child: Text('Error loading payments'),
            ),
          );
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Payment Details'),
            ),
            body: const Center(
              child: Text('No payments available'),
            ),
          );
        } else {
          List<Payment> payments = snapshot.data!;
          return Scaffold(
            appBar: AppBar(
              title: const Text('Payment Details'),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (var payment in payments)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Summary Type: ${payment.summaryType}'),
                          Text('Fee Year: ${payment.feeYear}'),
                          Text('Due Date: ${payment.dueDate}'),
                          // Add more details as needed
                          const Divider(), // Divider between payments
                        ],
                      ),
                  ],
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
