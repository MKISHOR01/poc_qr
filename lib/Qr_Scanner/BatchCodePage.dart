import 'package:flutter/material.dart';
import 'package:poc_qr/Qr_Scanner/batch_code_form.dart';
import 'package:poc_qr/Qr_Scanner/qr_result.dart';

class BatchCodePageView extends StatefulWidget {
  const BatchCodePageView({super.key});

  @override
  State<BatchCodePageView> createState() => _BatchCodePageViewState();
}

class _BatchCodePageViewState extends State<BatchCodePageView> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Enter the batch code',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          SizedBox(height: 10),
          BatchCodeForm(
            onSubmit: (value) {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => QRResult(
                          closeScanner: () {},
                          batchCode: value,
                          image: "",
                          type: "batchCode",
                        )),
              );
            },
          ),
        ],
      ),
    );
  }
}
