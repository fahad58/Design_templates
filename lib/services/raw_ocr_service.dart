import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../scanning_service.dart';
import '../utils/document_scanner.dart';

/// Service for extracting raw OCR text from documents
/// This service provides direct access to OCR text without additional processing
/// Now includes functionality to send extracted text to address_extractor service
class RawOCRService {
  static const String _pythonServiceUrl = 'http://localhost:5000';
  
  static Future<String?> extractRawText({
    required BuildContext context,
    bool fromCamera = true,
    bool allowCropping = true,
  }) async {
    try {
      // Use the existing document scanner to get scan result
      ScanResult? scanResult;
      
      if (fromCamera) {
        scanResult = await DocumentScanner.scanFromCamera();
      } else {
        scanResult = await DocumentScanner.scanFromGallery();
      }
      
      if (scanResult == null) {
        return null;
      }
      
      // Return the raw extracted text
      return scanResult.extractedText ?? '';
      
    } catch (e) {
      debugPrint('Error extracting raw text: $e');
      return null;
    }
  }
  
  /// Extract text and send to address extractor service
  static Future<Map<String, dynamic>?> extractAndProcessText({
    required BuildContext context,
    bool fromCamera = true,
    bool allowCropping = true,
  }) async {
    try {
      // First, extract the raw text
      final rawText = await extractRawText(
        context: context,
        fromCamera: fromCamera,
        allowCropping: allowCropping,
      );
      
      if (rawText == null || rawText.isEmpty) {
        debugPrint('No text extracted from document');
        return null;
      }
      
      // Send the final string to address_extractor
      return await _sendToAddressExtractor(rawText);
      
    } catch (e) {
      debugPrint('Error in extractAndProcessText: $e');
      return null;
    }
  }
  
  /// Send extracted text to address extractor service
  static Future<Map<String, dynamic>?> _sendToAddressExtractor(String text) async {
    try {
      final response = await http.post(
        Uri.parse('$_pythonServiceUrl/extract-address'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'text': text}),
      );
      
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        if (jsonResponse['success'] == true) {
          return jsonResponse['data'];
        } else {
          debugPrint('Address extractor error: ${jsonResponse['error']}');
          return null;
        }
      } else {
        debugPrint('HTTP error: ${response.statusCode} - ${response.body}');
        return null;
      }
    } catch (e) {
      debugPrint('Error connecting to address extractor: $e');
      return null;
    }
  }
  
  /// Extract text from multiple images and send combined text to address extractor
  static Future<Map<String, dynamic>?> extractAndProcessCombinedText({
    required BuildContext context,
    bool fromCamera = true,
  }) async {
    try {
      // Extract combined text from multiple images
      final combinedText = await extractCombinedTextFromMultipleImages(
        context: context,
        fromCamera: fromCamera,
      );
      
      if (combinedText.isEmpty) {
        debugPrint('No text extracted from documents');
        return null;
      }
      
      // Send the combined final string to address_extractor
      return await _sendToAddressExtractor(combinedText);
      
    } catch (e) {
      debugPrint('Error in extractAndProcessCombinedText: $e');
      return null;
    }
  }
  
  /// Extract text from multiple images and combine into single string
  static Future<String> extractCombinedTextFromMultipleImages({
    required BuildContext context,
    bool fromCamera = true,
  }) async {
    try {
      List<String> allExtractedTexts = [];
      
      // Allow user to add multiple images
      bool addMore = true;
      
      while (addMore) {
        final text = await extractRawText(
          context: context,
          fromCamera: fromCamera,
        );
        
        if (text != null && text.isNotEmpty) {
          allExtractedTexts.add(text);
        }
        
        // Ask user if they want to add another image
        addMore = await _showAddAnotherDialog(context);
      }
      
      // Combine all texts into single string
      return allExtractedTexts.join('\n\n');
      
    } catch (e) {
      debugPrint('Error extracting combined text: $e');
      return '';
    }
  }
  
  static Future<bool> _showAddAnotherDialog(BuildContext context) async {
    return await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add Another Image?'),
          content: const Text('Would you like to scan another document?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('No, Finish'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('Yes, Add More'),
            ),
          ],
        );
      },
    ) ?? false;
  }
}
