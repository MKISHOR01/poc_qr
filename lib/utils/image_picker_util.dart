import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

/// This camera util can be used to select files from gallery / capture image
/// using camera, this class make use of two plugins
/// permission_handler: ^11.1.0 - storage and camera permission
/// image_picker: ^1.0.4 - intent to launch gallery / camera app

class ImagePickerUtil {
  static Future<XFile?> pickImageFromGallery() async {
    final success = await _hasStoragePermission();
    if (Platform.isIOS) {
      if (!success) {
        await _requestStoragePermission();
        return null; // Retry after permission request
      }
    } else {
      if (success) {
        await _requestStoragePermission();
        return null; // Retry after permission request
      }
    }

    final ImagePicker picker = ImagePicker();
    try {
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);
      return image;
    } catch (error) {
      return null;
    }
  }

  static Future<XFile?> pickImageFromCamera() async {
    if (!await _hasCameraPermission()) {
      await _requestCameraPermission();
      return null; // Retry after permission request
    }

    final ImagePicker picker = ImagePicker();
    try {
      final XFile? image = await picker.pickImage(
          source: ImageSource.camera, requestFullMetadata: false);
      return image;
    } catch (error) {
      return null;
    }
  }

  static Future<bool> _hasCameraPermission() async {
    final status = await Permission.camera.status;
    return status.isGranted;
  }

  static Future<bool> _hasStoragePermission() async {
    if (Platform.isIOS) {
      final status = await Permission.photos.status;

      return status.isGranted;
    } else {
      final status = await Permission.storage.status;
      return status.isGranted;
    }
  }

  static Future<void> _requestCameraPermission() async {
    final status = await Permission.camera.request();
    if (status.isDenied) {
      // Storage permission denied!
      // Handle denied scenario
    } else if (status.isPermanentlyDenied) {
      // Handling permanently denied scenario
      // Open app settings to grant permission manually
      await openAppSettings();
    }
  }

  static Future<void> _requestStoragePermission() async {
    if (Platform.isIOS) {
      final status = await Permission.photos.request();

      if (status.isDenied) {
        // Storage permission denied!
        // Handle denied scenario
      } else if (status.isPermanentlyDenied) {
        // Handle permanently denied scenario
        // Open app settings to grant permission manually
        await openAppSettings();
      }
    } else {
      final status = await Permission.storage.request();
      if (status.isDenied) {
        // Storage permission denied!
        // Handle denied scenario
      } else if (status.isPermanentlyDenied) {
        // Handle permanently denied scenario
        // Open app settings to grant permission manually
        await openAppSettings();
      }
    }
  }
}
