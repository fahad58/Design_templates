import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pdf/widgets.dart' as pw;
//import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image/image.dart' as img;
import 'package:path_provider/path_provider.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'dart:io';
import 'dart:typed_data';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PDF Scanner with OCR',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  File? _scannedImage;
  String _extractedText = '';
  Uint8List? _pdfBytes;
  final List<File> _scannedPages = [];
  bool _isProcessing = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PDF Scanner with OCR'),
        actions: [
          if (_scannedPages.isNotEmpty)
            IconButton(
              icon: Icon(Icons.picture_as_pdf),
              onPressed: _generatePDF,
              tooltip: 'Generate PDF',
            ),
          IconButton(
            icon: Icon(Icons.insert_drive_file),
            onPressed: _loadExistingPDF,
            tooltip: 'Load PDF',
          ),
        ],
      ),
      body: _buildBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: _showScanOptions,
        child: Icon(Icons.camera_alt),
      ),
    );
  }

  Widget _buildBody() {
    if (_isProcessing) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text('Processing document...'),
          ],
        ),
      );
    }

    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (_scannedImage != null) _buildImagePreview(),
          if (_extractedText.isNotEmpty) _buildExtractedText(),
          if (_pdfBytes != null) _buildPDFPreview(),
          if (_scannedPages.isNotEmpty) _buildScannedPagesList(),
        ],
      ),
    );
  }

  Widget _buildImagePreview() {
    return Card(
      elevation: 4,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8),
            child: Text('Scanned Document', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          Image.file(_scannedImage!),
          OverflowBar(
            children: [
              TextButton(
                onPressed: _extractTextFromImage,
                child: Text('Extract Text'),
              ),
              TextButton(
                child: Text('Add to PDF'),
                onPressed: () {
                  setState(() {
                    _scannedPages.add(_scannedImage!);
                    _scannedImage = null;
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildExtractedText() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Extracted Text', style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text(_extractedText),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _editExtractedText,
              child: Text('Edit Extracted Text'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPDFPreview() {
    return Card(
      elevation: 4,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8),
            child: Text('PDF Preview', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          SizedBox(
            height: 300,
            child: PdfPreview(
              build: (format) => _pdfBytes!,
            ),
          ),
          OverflowBar(
            children: [
              TextButton(
                onPressed: _savePDF,
                child: Text('Save PDF'),
              ),
              TextButton(
                onPressed: _sharePDF,
                child: Text('Share PDF'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildScannedPagesList() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Scanned Pages (${_scannedPages.length})', style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            SizedBox(
              height: 120,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _scannedPages.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.all(4),
                    child: GestureDetector(
                      onTap: () => _viewPage(index),
                      onLongPress: () => _removePage(index),
                      child: Image.file(
                        _scannedPages[index],
                        height: 100,
                        width: 70,
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showScanOptions() async {
    final option = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Scan Options'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: Text('Camera'),
              leading: Icon(Icons.camera_alt),
              onTap: () => Navigator.pop(context, 'camera'),
            ),
            ListTile(
              title: Text('Gallery'),
              leading: Icon(Icons.photo_library),
              onTap: () => Navigator.pop(context, 'gallery'),
            ),
          ],
        ),
      ),
    );

    if (option == 'camera') {
      await _scanDocument(ImageSource.camera);
    } else if (option == 'gallery') {
      await _scanDocument(ImageSource.gallery);
    }
  }

  Future<void> _scanDocument(ImageSource source) async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? pickedFile = await picker.pickImage(source: source);

      if (pickedFile != null) {
        setState(() {
          _scannedImage = File(pickedFile.path);
          _extractedText = '';
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to capture image: $e')),
      );
    }
  }

  Future<void> _extractTextFromImage() async {
    if (_scannedImage == null) return;

    setState(() {
      _isProcessing = true;
    });

    try {
      final FirebaseVisionImage visionImage = FirebaseVisionImage.fromFile(_scannedImage!);
      final TextRecognizer textRecognizer = FirebaseVision.instance.textRecognizer();
      final VisionText visionText = await textRecognizer.processImage(visionImage);

      String text = '';
      for (TextBlock block in visionText.blocks) {
        for (TextLine line in block.lines) {
           text += (line.text ?? '') + '\n';
        }
        text += '\n';
      }

      setState(() {
        _extractedText = text;
        _isProcessing = false;
      });
    } catch (e) {
      setState(() {
        _isProcessing = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to extract text: $e')),
      );
    }
  }

  Future<void> _editExtractedText() async {
    final editedText = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Edit Text'),
        content: TextFormField(
          initialValue: _extractedText,
          maxLines: 10,
          onChanged: (value) {
            _extractedText = value;
          },
        ),
        actions: [
          TextButton(
            child: Text('Cancel'),
            onPressed: () => Navigator.pop(context),
          ),
          TextButton(
            child: Text('Save'),
            onPressed: () => Navigator.pop(context, _extractedText),
          ),
        ],
      ),
    );

    if (editedText != null) {
      setState(() {
        _extractedText = editedText;
      });
    }
  }

  Future<void> _generatePDF() async {
    if (_scannedPages.isEmpty) return;

    setState(() {
      _isProcessing = true;
    });

    try {
      final pdf = pw.Document();

      for (final page in _scannedPages) {
        final imageData = await page.readAsBytes();
        final image = img.decodeImage(imageData);

        if (image != null) {
          pdf.addPage(
            pw.Page(
              build: (pw.Context context) {
                return pw.Center(
                  child: pw.Image(
                    pw.MemoryImage(imageData),
                    fit: pw.BoxFit.contain,
                  ),
                );
              },
            ),
          );
        }
      }

      if (_extractedText.isNotEmpty) {
        pdf.addPage(
          pw.Page(
            build: (pw.Context context) {
              return pw.Padding(
                padding: pw.EdgeInsets.all(20),
                child: pw.Text(_extractedText),
              );
            },
          ),
        );
      }

      final bytes = await pdf.save();

      setState(() {
        _pdfBytes = bytes;
        _isProcessing = false;
      });
    } catch (e) {
      setState(() {
        _isProcessing = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to generate PDF: $e')),
      );
    }
  }

  Future<void> _savePDF() async {
    if (_pdfBytes == null) return;

    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/scanned_document_${DateTime.now().millisecondsSinceEpoch}.pdf');
      await file.writeAsBytes(_pdfBytes!);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('PDF saved to ${file.path}')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to save PDF: $e')),
      );
    }
  }

  Future<void> _sharePDF() async {
    if (_pdfBytes == null) return;

    // In a real app, you would use the share plugin here
    // For example: await Share.shareFiles([file.path]);
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Sharing functionality would be implemented here')),
    );
  }

  Future<void> _loadExistingPDF() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
      );

      if (result != null && result.files.isNotEmpty) {
        final file = File(result.files.single.path!);
        final bytes = await file.readAsBytes();

        setState(() {
          _pdfBytes = bytes;
          _extractedText = '';
          _scannedImage = null;
          _scannedPages.clear();
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load PDF: $e')),
      );
    }
  }

  void _viewPage(int index) {
    setState(() {
      _scannedImage = _scannedPages[index];
    });
  }

  void _removePage(int index) {
    setState(() {
      _scannedPages.removeAt(index);
    });
  }
}
...............................
  depencies used in the project
upertino_icons: ^1.0.8
  mobile_scanner: ^7.0.1
  image_picker: ^0.8.4+4
  printing: ^5.10.1
  file_picker: ^6.1.1
  firebase_ml_vision: ^0.12.0+3
  path_provider: ^2.0.11
  image: ^4.1.0
  pdf: ^3.11.2
  google_mlkit_text_recognition: ^0.11.0
  firebase_core: ^2.30.0
  url_launcher:
  intl: ^0.18.1
$$$$$$$$$$$$$$$$$$$
In android/app/src/main/AndroidManifest.xml, add these permissions:

<uses-permission android:name="android.permission.CAMERA"/>
<uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE"/>
<uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE"/>
&&&&&&&&&&&&&&&&&&&&
In ios/Runner/Info.plist, add these keys:

<key>NSCameraUsageDescription</key>
<string>Need camera access to scan documents</string>
<key>NSPhotoLibraryUsageDescription</key>
<string>Need photo library access to select images</string>
<key>NSMicrophoneUsageDescription</key>
<string>Need microphone access for recording</string>
