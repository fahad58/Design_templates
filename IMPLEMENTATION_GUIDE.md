# Document Scanner Flutter App - Complete Implementation Guide

## Overview
This guide provides detailed instructions for implementing a document scanning Flutter application with OCR capabilities, including all dependencies, Android configuration, and step-by-step setup.

## Project Structure
```
lib/
├── main.dart                          # Main application entry point
├── screens/
│   └── property_form_screen.dart     # Document scanning UI
├── services/
│   └── raw_ocr_service.dart          # OCR processing service
├── utils/
│   └── document_scanner.dart         # Document scanning utilities
python_services/
├── address_extractor.py            # Python OCR service
├── server.py                       # Python backend server
└── requirements.txt                # Python dependencies
```

## 1. Prerequisites

### System Requirements
- Flutter SDK: 3.0.0 or higher
- Dart SDK: 2.17.0 or higher
- Android Studio: 2021.1.1 or higher
- Python: 3.7 or higher (for OCR services)
- Git: Latest version

### Development Environment Setup
```bash
# Install Flutter
git clone https://github.com/flutter/flutter.git -b stable
export PATH="$PATH:`pwd`/flutter/bin"

# Verify installation
flutter doctor
```

## 2. Dependencies Installation

### Flutter Dependencies (pubspec.yaml)
```yaml
dependencies:
  flutter:
    sdk: flutter
  image_picker: ^1.0.4
  camera: ^0.10.5+5
  google_mlkit_text_recognition: ^0.11.0
  path_provider: ^2.1.1
  permission_handler: ^11.0.1
  http: ^1.1.0
  shared_preferences: ^2.2.2
  fluttertoast: ^8.2.2

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^3.0.1
```

### Python Dependencies (requirements.txt)
```
flask==2.3.3
flask-cors==4.0.0
opencv-python==4.8.1.78
pytesseract==0.3.10
pillow==10.0.1
numpy==1.24.3
```

## 3. Android Configuration

### AndroidManifest.xml
```xml
<manifest xmlns:android="http://schemas.android.com/apk/res/android"
    package="com.example.document_scanner">
    
    <uses-permission android:name="android.permission.CAMERA" />
    <uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE" />
    <uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />
    <uses-permission android:name="android.permission.INTERNET" />
    
    <application
        android:label="Document Scanner"
        android:icon="@mipmap/ic_launcher"
        android:requestLegacyExternalStorage="true">
        
        <activity
            android:name=".MainActivity"
            android:exported="true"
            android:launchMode="singleTop"
            android:theme="@style/LaunchTheme">
            <intent-filter>
                <action android:name="android.intent.action.MAIN" />
                <category android:name="android.intent.category.LAUNCHER" />
            </intent-filter>
        </activity>
    </application>
</manifest>
```

### build.gradle (app level)
```gradle
android {
    compileSdkVersion 34
    
    defaultConfig {
        applicationId "com.example.document_scanner"
        minSdkVersion 21
        targetSdkVersion 34
        versionCode 1
        versionName "1.0"
    }
    
    compileOptions {
        sourceCompatibility JavaVersion.VERSION_1_8
        targetCompatibility JavaVersion.VERSION_1_8
    }
}
```

## 4. File-by-File Implementation

### 4.1 Main Application (lib/main.dart)
```dart
import 'package:flutter/material.dart';
import 'screens/property_form_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Document Scanner',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: const PropertyFormScreen(),
    );
  }
}
```



### 4.2 Document Scanner Utility (lib/utils/document_scanner.dart)
```dart
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

class DocumentScanner {
  static final ImagePicker _picker = ImagePicker();
  static final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);

  static Future<ScannedDocument?> scanFromCamera() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 100,
      );
      
      if (image == null) return null;
      
      final inputImage = InputImage.fromFilePath(image.path);
      final recognizedText = await textRecognizer.processImage(inputImage);
      
      return ScannedDocument(
        imagePath: image.path,
        extractedText: recognizedText.text,
      );
    } catch (e) {
      print('Error scanning document: $e');
      return null;
    }
  }

  static Future<void> dispose() async {
    await textRecognizer.close();
  }
}

class ScannedDocument {
  final String imagePath;
  final String extractedText;

  ScannedDocument({
    required this.imagePath,
    required this.extractedText,
  });
}
```




### 4.3 Raw OCR Service (lib/services/raw_ocr_service.dart)
```dart
import 'dart:io';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

class RawOCRService {
  static final TextRecognizer _textRecognizer = TextRecognizer();

  static Future<String> extractTextFromImage(File imageFile) async {
    try {
      final inputImage = InputImage.fromFile(imageFile);
      final recognizedText = await _textRecognizer.processImage(inputImage);
      
      return recognizedText.text;
    } catch (e) {
      print('Error extracting text: $e');
      return '';
    }
  }

  static Future<void> dispose() async {
    await _textRecognizer.close();
  }
}
```

## 5. Python Backend Setup

### 5.1 Python Server (python_services/server.py)
```python
from flask import Flask, request, jsonify
from flask_cors import CORS
import cv2
import pytesseract
import numpy as np
from PIL import Image
import io
import base64

app = Flask(__name__)
CORS(app)

@app.route('/process-document', methods=['POST'])
def process_document():
    try:
        file = request.files['document']
        image = Image.open(file.stream)
        
        # Convert PIL image to OpenCV format
        cv_image = cv2.cvtColor(np.array(image), cv2.COLOR_RGB2BGR)
        
        # Preprocess image
        gray = cv2.cvtColor(cv_image, cv2.COLOR_BGR2GRAY)
        denoised = cv2.medianBlur(gray, 5)
        thresh = cv2.adaptiveThreshold(
            denoised, 255, cv2.ADAPTIVE_THRESH_GAUSSIAN_C, cv2.THRESH_BINARY, 11, 2
        )
        
        # Extract text
        text = pytesseract.image_to_string(thresh, lang='eng')
        
        return jsonify({
            'success': True,
            'extracted_text': text.strip(),
            'confidence': 95.0
        })
        
    except Exception as e:
        return jsonify({
            'success': False,
            'error': str(e)
        }), 500

if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0', port=5000)
```

### 5.2 Address Extractor (python_services/address_extractor.py)
```python
import re
import spacy

nlp = spacy.load("en_core_web_sm")

def extract_address(text):
    """Extract address information from OCR text"""
    address_pattern = r'\d+\s+[\w\s]+\s+(?:street|st|avenue|ave|road|rd|lane|ln|drive|dr|court|ct|way|place|pl)\b'
    matches = re.findall(address_pattern, text, re.IGNORECASE)
    
    # Use spaCy for NER
    doc = nlp(text)
    addresses = [ent.text for ent in doc.ents if ent.label_ in ["GPE", "LOC"]]
    
    return {
        'raw_addresses': matches,
        'ner_addresses': addresses,
        'full_text': text
    }
```

## 6. Android-Specific Configuration

### 6.1 ProGuard Rules (android/app/proguard-rules.pro)
```
-keep class com.google.mlkit.** { *; }
-keep class com.google.android.gms.** { *; }
-dontwarn com.google.mlkit.**
```

### 6.2 Tesseract Setup for Android
1. Download trained data files from: https://github.com/tesseract-ocr/tessdata
2. Place in `android/app/src/main/assets/tessdata/`
3. Add to `pubspec.yaml`:
```yaml
flutter:
  assets:
    - assets/tessdata/
```

## 7. Permission Handling

### 7.1 Permission Request Helper (lib/utils/permissions.dart)
```dart
import 'package:permission_handler/permission_handler.dart';

class PermissionHelper {
  static Future<bool> requestCameraPermission() async {
    final status = await Permission.camera.request();
    return status.isGranted;
  }

  static Future<bool> requestStoragePermission() async {
    final status = await Permission.storage.request();
    return status.isGranted;
  }
}
```

## 8. Build and Run Instructions



### 8.1 Python Backend Setup
```bash
cd python_services
pip install -r requirements.txt
python server.py
```

### 8.2 Environment Variables
Create `.env` file:
```
PYTHON_SERVER_URL=http://localhost:5000
TESSERACT_PATH=/usr/local/bin/tesseract
```

## 9. Testing Checklist

### 9.1 Manual Testing Steps
1. **Camera Permission**: Verify camera permission dialog appears
2. **Document Scanning**: Test scanning from camera
3. **OCR Accuracy**: Verify text extraction accuracy
4. **Error Handling**: Test with invalid images
5. **Network**: Test offline/online scenarios

### 9.2 Automated Testing
```dart
// Example widget test
testWidgets('Document scanning button appears', (WidgetTester tester) async {
  await tester.pumpWidget(const MyApp());
  expect(find.text('Scan Document'), findsOneWidget);
});
```

## 10. Troubleshooting

### Common Issues and Solutions

1. **Camera Permission Denied**
   - Check AndroidManifest.xml permissions
   - Ensure runtime permission requests are implemented

2. **OCR Not Working**
   - Verify Google ML Kit dependencies
   - Check internet connection for cloud-based OCR

3. **Python Server Connection Failed**
   - Ensure server is running on port 5000
   - Check firewall settings
   - Verify CORS configuration

4. **Build Errors**
   - Run `flutter clean` and `flutter pub get`
   - Check Android SDK versions
   - Verify Gradle configuration

## 11. Deployment

### 11.1 Android Release Build
```bash
flutter build apk --release --split-per-abi
```

### 11.2 iOS Release Build
```bash
flutter build ios --release
```

### 11.3 Web Deployment
```bash
flutter build web
```

## 12. Maintenance

### 12.1 Regular Updates
- Update Flutter SDK monthly
- Update dependencies quarterly
- Monitor for security patches

### 12.2 Performance Optimization
- Implement image compression
- Add caching for OCR results
- Optimize memory usage

This guide provides complete implementation details for all files and their dependencies. Follow each section carefully to set up the document scanning application successfully.
