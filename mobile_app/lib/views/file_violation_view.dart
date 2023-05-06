import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:typed_data';
import 'dart:convert';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:mobile_app/viewmodels/login_viewmodel.dart';
import 'package:mobile_app/repositories/file_violation_repository.dart';

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

  Future<File> compressAndConvertImage(File image) async {
    final result = await FlutterImageCompress.compressAndGetFile(
      image.absolute.path,
      image.absolute.path + '.jpg',
      quality: 70,
    );

    return result!;
  }

  Future<File> writeImageToTempDir(Uint8List imageData) async {
    final tempDir = await getTemporaryDirectory();
    final imageFile = File('${tempDir.path}/processed_image.png');
    // Decode the image data
    img.Image? decodedImage = img.decodeImage(imageData);

    if (decodedImage != null) {
      // Encode the image as PNG
      final encodedImage = img.encodePng(decodedImage);
      // Write the image to the file
      return imageFile.writeAsBytes(encodedImage);
    } else {
      throw Exception('Failed to decode image data');
    }
  }

  Future processImage() async {
    if (_image != null) {
      // Convert image file to base64
      String base64Image = base64Encode(await _image!.readAsBytes());

      // Send the base64 encoded image to the server
      final response = await http.post(
        Uri.parse('http://10.0.2.2:5000/detect_parking_violations'),
        body: {'image': base64Image},
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        final outputImageBase64 = responseData['output_image'];
        final violationsCount = responseData['violations_count'];

        // Decode the base64 encoded output image
        Uint8List outputImageData = base64Decode(outputImageBase64);
        final processedImage = await writeImageToTempDir(outputImageData);

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProcessedImagePage(
              imagePath: processedImage.path,
              numberOfViolatedCars: responseData['violations_count'],
              onCarPlatesSubmitted: (plates) {
                setState(() {
                  _violatedCarPlates.addAll(plates);
                });
              },
            ),
          ),
        );
      } else {
        print("Error processing image");
      }
    }
  }

  void showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
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

class ProcessedImagePage extends StatefulWidget {
  final String imagePath;
  final Function(List<String>) onCarPlatesSubmitted;
  final int numberOfViolatedCars;

  ProcessedImagePage({
    required this.imagePath,
    required this.onCarPlatesSubmitted,
    required this.numberOfViolatedCars,
  });

  @override
  _ProcessedImagePageState createState() => _ProcessedImagePageState();
}

class _ProcessedImagePageState extends State<ProcessedImagePage> {
  List<TextEditingController> _plateControllers = [];

  @override
  void initState() {
    super.initState();
    _plateControllers = List.generate(
      widget.numberOfViolatedCars,
      (index) => TextEditingController(),
    );
  }

  @override
  void dispose() {
    _plateControllers.forEach((controller) => controller.dispose());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Processed Image')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 400,
                child: widget.imagePath == null
                    ? Text('No processed image.')
                    : Image.file(File(widget.imagePath)),
              ),
              SizedBox(height: 16),
              Text(
                  'Enter the car plate number for each violated car: \n from left to right, top to bottom'),
              SizedBox(height: 8),
              Container(
                height: (widget.numberOfViolatedCars / 2 * 100)
                    .toDouble(), // Increase the item height to make the GridView larger
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio:4, // Increase the aspect ratio to make the items wider
                    crossAxisSpacing: 16, // Increase the cross-axis spacing
                    mainAxisSpacing: 16, // Increase the main-axis spacing
                  ),
                  itemCount: widget.numberOfViolatedCars,
                  itemBuilder: (context, index) {
                    return TextField(
                      controller: _plateControllers[index],
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Car Plate #',
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  List<String> plateNumbers = _plateControllers
                      .map((controller) => controller.text)
                      .where((text) => text.isNotEmpty)
                      .toList();

                  if (plateNumbers.isNotEmpty) {
                    widget.onCarPlatesSubmitted(plateNumbers);
                    try{
                      addViolations(plateNumbers);
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text('Done submitting'),
                            content: Text("submitting the vioaltions is done"),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text('OK'),
                              ),
                            ],
                          );
                        },
                      );
                      Navigator.pop(context);
                      Navigator.pop(context);
                    }
                    catch(e){
                      print(e);
                      showError(context, 'failed to add the cars');
                    }
                  }
                  else{
                    showError(context, "please fill all the plate#s ");
                  }
                },
                child: Text('Submit Car Plates'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
