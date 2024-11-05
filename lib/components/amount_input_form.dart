import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AmountInputForm extends StatelessWidget {
  final String title;
  final String buttonText;
  final Function(double) onSubmit;
  final TextEditingController amountController = TextEditingController();

  AmountInputForm({super.key, 
    required this.title,
    required this.buttonText,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Jumlah',
                prefixText: 'Rp ',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                double? amount = double.tryParse(amountController.text);
                if (amount != null) {
                  onSubmit(amount);
                  Get.back();
                } else {
                  Get.snackbar('Error', 'Masukkan jumlah yang valid');
                }
              },
              child: Text(buttonText),
            ),
          ],
        ),
      ),
    );
  }
}