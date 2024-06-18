import 'package:flutter/material.dart';
import 'package:poc_qr/utils/app_theme.dart';

class BatchCodeForm extends StatefulWidget {
  final Function(String) onSubmit;
  const BatchCodeForm({super.key, required this.onSubmit});

  @override
  State<BatchCodeForm> createState() => _BatchCodeFormState();
}

class _BatchCodeFormState extends State<BatchCodeForm> {
  final TextEditingController batchCodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              key: const Key("batchcode"),
              controller: batchCodeController,
              textAlignVertical: TextAlignVertical.top,
              style: const TextStyle(
                color: Color(0xFF9193A1),
                fontSize: 14,
                fontWeight: FontWeight.w400,
                fontStyle: FontStyle.normal,
                height: 1.2142857, // 17/14
              ),
              decoration: const InputDecoration(
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color:
                            Colors.grey), // Remove the border when not focused
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Color(
                            0xFFDDE8F4)), // Remove the border when not focused
                  ),
                  fillColor: Colors.white,
                  hintText: "Batch Code",
                  contentPadding: EdgeInsets.all(10)),
            ),
          ),
          const SizedBox(width: 10),
          InkWell(
            onTap: () {
              if (batchCodeController.text.isNotEmpty) {
                widget.onSubmit.call(batchCodeController.text);
              }
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: AppTheme.nearlyDarkBlue,
              ),
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: const Text(
                "Submit",
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          )
        ],
      ),
    );
  }
}
