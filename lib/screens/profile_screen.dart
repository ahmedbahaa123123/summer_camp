import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:summer_camp/logic/auth_methos.dart';

class ProfileScreen extends StatefulWidget {
  final String username;
  final String email;
  final int age;
  final String? profileImage; // Add profileImage parameter

  const ProfileScreen({
    super.key,
    required this.username,
    required this.email,
    required this.age,
    this.profileImage, // Initialize profileImage
  });

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  File? _image;

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _image = File(image.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final AuthMethods _authMethods = AuthMethods();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await _authMethods.signOut();
              Navigator.of(context).pushReplacementNamed('/');
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onTap: _pickImage,
                  child: CircleAvatar(
                    radius: 75, // Adjust the radius as needed
                    backgroundColor: Colors.grey.shade200,
                    backgroundImage: _image != null
                        ? FileImage(_image!)
                        : widget.profileImage != null
                            ? NetworkImage(widget.profileImage!)
                            : null,
                    child: _image == null && widget.profileImage == null
                        ? const Icon(
                            Icons.camera_alt,
                            color: Colors.grey,
                            size: 50,
                          )
                        : null,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  widget.username,
                  style: const TextStyle(
                      fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  widget.email,
                  style: const TextStyle(fontSize: 16, color: Colors.grey),
                ),
                Text(
                  widget.age.toString(),
                  style: const TextStyle(
                      fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
