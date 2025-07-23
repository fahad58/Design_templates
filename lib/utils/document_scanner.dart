import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import '../scanning_service.dart';

class DocumentScanner {
  static Future<ScanResult?> scanFromCamera() async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: ImageSource.camera);
      
      if (image == null) return null;
      
      final textRecognizer = TextRecognizer();
      final inputImage = InputImage.fromFilePath(image.path);
      final RecognizedText recognizedText = await textRecognizer.processImage(inputImage);
      
      return ScanResult(
        extractedText: recognizedText.text,
        imageFile: File(image.path),
      );
    } catch (e) {
      return null;
    }
  }

  static Future<ScanResult?> scanFromGallery() async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);
      
      if (image == null) return null;
      
      final textRecognizer = TextRecognizer();
      final inputImage = InputImage.fromFilePath(image.path);
      final RecognizedText recognizedText = await textRecognizer.processImage(inputImage);
      
      return ScanResult(
        extractedText: recognizedText.text,
        imageFile: File(image.path),
      );
    } catch (e) {
      return null;
    }
  }
}
