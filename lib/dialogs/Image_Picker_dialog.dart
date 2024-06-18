// ignore_for_file: file_names

import 'package:flutter/material.dart';

Future showImagePickerDialog(
  BuildContext context, {
  VoidCallback? closeClick,
  bool barrierDismissible = true,
}) {
  return showDialog(
    context: context,
    barrierDismissible: barrierDismissible,
    builder: (context) {
      return ImagePickerDialog(
        onCloseClick: closeClick,
      );
    },
  );
}

class ImagePickerDialog extends StatelessWidget {
  final VoidCallback? onCloseClick;

  const ImagePickerDialog({
    super.key,
    this.onCloseClick,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
        surfaceTintColor: const Color(0x00000000),
        backgroundColor: const Color(0x00000000),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        insetPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 24,
        ),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                decoration: BoxDecoration(
                    color: const Color(0xE6FFFFFF),
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context, MediaSelection.gallery);
                      },
                      child: const SizedBox(
                        height: 61,
                        child: Center(
                          child: Text("Photo Gallery",
                              style: TextStyle(color: Color(0xFF007AFF))),
                        ),
                      ),
                    ),
                    Container(
                      height: 1,
                      color: const Color(0xFFD8D8D8),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context, MediaSelection.camera);
                      },
                      child: const SizedBox(
                        height: 61,
                        child: Center(
                          child: Text(
                            "Camera",
                            style: TextStyle(color: Color(0xFF007AFF)),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xE6FFFFFF),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const SizedBox(
                    height: 61,
                    child: Center(
                      child: Text("Cancel",
                          style: TextStyle(color: Color(0xFF007AFF))),
                    ),
                  ),
                ),
              )
            ],
          ),
        ));
  }
}

enum MediaSelection { gallery, camera }
