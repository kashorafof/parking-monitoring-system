import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:typed_data';


class ImageUploadPage extends StatefulWidget {
  @override
  _ImageUploadPageState createState() => _ImageUploadPageState();
}

class _ImageUploadPageState extends State<ImageUploadPage> {
  File? _image;
  List<String> _violatedCarPlates = [];

  // Function to pick an image from gallery
  Future pickImageFromGallery() async {
    final pickedImage =
        await ImagePicker().getImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
    }
  }

  // Function to process the image using the API
  Future processImage() async {
    if (_image != null) {
      final request = http.MultipartRequest(
        'POST',
          Uri.parse('http://10.0.2.2:5000/detect_parking_violations'),
      );
      request.files
          .add(await http.MultipartFile.fromPath('image', _image?.path ?? ''));

      final response = await request.send();
      final responseData = await response.stream.toBytes();
      final processedImage = await writeImageToTempDir(responseData);

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProcessedImagePage(
            imagePath: processedImage.path,
            onCarPlateSubmitted: (plate) {
              setState(() {
                _violatedCarPlates.add(plate);
              });
            },
          ),
        ),
      );
    }
  }

  // Function to write the processed image to a temporary directory
  Future<File> writeImageToTempDir(Uint8List imageData) async {
    final tempDir = await getTemporaryDirectory();
    final imageFile = File('${tempDir.path}/processed_image.jpg');
    return imageFile.writeAsBytes(imageData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Parking Violation Detector')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _image == null ? Text('No image selected.') : Image.file(_image!),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: pickImageFromGallery,
            child: Text('Select Image'),
          ),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: processImage,
            child: Text('Process Image'),
          ),
          SizedBox(height: 32),
          Text('Violated Car Plates:'),
          ..._violatedCarPlates.map((plate) => Text(plate)).toList(),
        ],
      ),
    );
  }
}

class ProcessedImagePage extends StatelessWidget {
  final String imagePath;
  final Function(String) onCarPlateSubmitted;

  ProcessedImagePage({required this.imagePath, required this.onCarPlateSubmitted});

  @override
  Widget build(BuildContext context) {
    TextEditingController _plateController = TextEditingController();
    return Scaffold(
      appBar: AppBar(title: Text('Processed Image')),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            imagePath == null
                ? Text('No processed image.')
                : Image.file(File(imagePath)),
            SizedBox(height: 16),
            Text('Enter the car plate number for each violated car:'),
            SizedBox(height: 8),
            TextField(
              controller: _plateController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Car Plate Number',
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                if (_plateController.text.isNotEmpty) {
                  onCarPlateSubmitted(_plateController.text);
                  Navigator.pop(context);
                }
              },
              child: Text('Submit Car Plate'),
            ),
          ],
        ),
      ),
    );
  }
}
