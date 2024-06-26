// upload_image_screen.dart
// upload_image_screen.dart
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:holbegram/methods/auth_methods.dart';

class AddPicture extends StatefulWidget {
  final String email;
  final String password;
  final String username;

  AddPicture({
    Key? key,
    required this.email,
    required this.password,
    required this.username,
  }) : super(key: key);

  @override
  State<AddPicture> createState() => _AddPictureState();
}

class _AddPictureState extends State<AddPicture> {
  Uint8List? _image;

  // Method to select an image from the gallery
  void selectImageFromGallery() async {
    Uint8List? selectedImage = await _pickImage(ImageSource.gallery);
    setState(() {
      _image = selectedImage;
    });
  }

  // Method to select an image from the camera
  void selectImageFromCamera() async {
    Uint8List? selectedImage = await _pickImage(ImageSource.camera);
    setState(() {
      _image = selectedImage;
    });
  }

  // Helper method to pick an image from the specified source
  Future<Uint8List?> _pickImage(ImageSource source) async {
    final ImagePicker _picker = ImagePicker();
    XFile? file = await _picker.pickImage(source: source);

    if (file != null) {
      return await file.readAsBytes();
    }
    return null;
  }

  // Method to handle sign up
  void signUpUser() async {
    if (_image == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select an image')),
      );
      return;
    }

    String res = await AuthMethods().signUpUser(
      email: widget.email,
      password: widget.password,
      username: widget.username,
      file: _image!,
    );

    if (res == 'success') {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Sign Up Success')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(res)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text('Add Picture for ${widget.username}'), // Use the username here
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _image != null
                ? Image.memory(_image!)
                : const Placeholder(
                    fallbackHeight: 200.0, fallbackWidth: 200.0),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: selectImageFromGallery,
              child: const Text('Select from Gallery'),
            ),
            ElevatedButton(
              onPressed: selectImageFromCamera,
              child: const Text('Select from Camera'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: signUpUser,
              child: const Text('Next'),
            ),
          ],
        ),
      ),
    );
  }
}
