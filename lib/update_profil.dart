import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class UpdateProfilePage extends StatefulWidget {
  @override
  _UpdateProfilePageState createState() => _UpdateProfilePageState();
}

class _UpdateProfilePageState extends State<UpdateProfilePage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _addressController;
  late TextEditingController _phoneNumberController;
  late String _userProfileImageUrl = '';
  File? _imageFile;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _addressController = TextEditingController();
    _phoneNumberController = TextEditingController();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _nameController.text = prefs.getString('userName') ?? '';
      _emailController.text = prefs.getString('email') ?? '';
      _addressController.text = prefs.getString('alamat') ?? '';
      _phoneNumberController.text = prefs.getString('no_hp') ?? '';
      // _userProfileImageUrl = prefs.getString('userProfileImageUrl') ?? '';
      // _userProfileImageUrl = 'http://127.0.0.1:8000/user/eraw.jpg';
      _userProfileImageUrl = 'http://192.168.100.151:8000/user/eraw.jpg';
    });
  }

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  Future<void> _updateProfile() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? userId = prefs.getInt('id')?.toString();

      if (userId == null) {
        showSnackBar(context, 'User ID tidak ditemukan.');
        return;
      }

      try {
        final response = await http.put(
          Uri.parse('http://192.168.100.151:8000/api/updateuser/$userId'),
          // Uri.parse('http://127.0.0.1:8000/api/updateuser/$userId'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode({
            'name': _nameController.text,
            'email': _emailController.text,
            'alamat': _addressController.text,
            'no_hp': _phoneNumberController.text,
            // Add other fields if needed, like image URL
          }),
        );

        if (response.statusCode == 200) {
          final jsonResponse = jsonDecode(response.body);

          await prefs.setString('userName', jsonResponse['user']['name']);
          await prefs.setString('email', jsonResponse['user']['email']);
          await prefs.setString('alamat', jsonResponse['user']['alamat']);
          await prefs.setString('no_hp', jsonResponse['user']['no_hp']);
          await prefs.setString(
              'userProfileImageUrl', jsonResponse['user']['image'] ?? '');

          showSnackBar(context, 'Profil berhasil diperbarui.');

          setState(() {
            _userProfileImageUrl = jsonResponse['user']['image'] ?? '';
          });

          Navigator.pop(context);
        } else {
          final jsonResponse = jsonDecode(response.body);
          final errorMessage = jsonResponse['message'];
          showSnackBar(context, errorMessage);
        }
      } catch (e) {
        showSnackBar(context, 'Kesalahan: $e');
      }
    }
  }

  void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Color(0xAD40B59F),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Profile'),
        backgroundColor: Color(0xAD40B59F),
        elevation: 0,
      ),
      body: Stack(
        children: [
          Positioned(
            top: -30,
            left: 0,
            right: 0,
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 80),
              decoration: BoxDecoration(
                color: Color(0xAD40B59F),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(140),
                  bottomRight: Radius.circular(140),
                ),
              ),
              child: Container(),
            ),
          ),
          Positioned(
            top: 45,
            left: MediaQuery.of(context).size.width / 2 - 80,
            child: Stack(
              children: [
                CircleAvatar(
                  radius: 80,
                  backgroundColor: Colors.transparent,
                  child: ClipOval(
                    child: _imageFile != null
                        ? Image.file(
                            _imageFile!,
                            width: 160,
                            height: 160,
                            fit: BoxFit.cover,
                          )
                        : _userProfileImageUrl.isNotEmpty
                            ? Image.network(
                                _userProfileImageUrl,
                                width: 160,
                                height: 160,
                                fit: BoxFit.cover,
                                errorBuilder:
                                    (context, error, stackTrace) {
                                  return Icon(
                                    Icons.person,
                                    size: 80,
                                    color: Colors.grey,
                                  );
                                },
                              )
                            : Icon(
                                Icons.person,
                                size: 80,
                                color: Colors.grey,
                              ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: GestureDetector(
                    onTap: _pickImage,
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 25,
                      child: Icon(
                        Icons.camera_alt,
                        color: Color(0xAD40B59F),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 210,
            left: 16,
            right: 16,
            bottom: -10,
            child: SingleChildScrollView(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom + 16),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildTextField('Nama', Icons.person, _nameController),
                    _buildTextField('Email', Icons.email, _emailController),
                    _buildTextField(
                        'Alamat', Icons.location_on, _addressController),
                    _buildTextField(
                        'Nomor Telepon', Icons.phone, _phoneNumberController),
                    SizedBox(height: 20),
                    Align(
                      alignment: Alignment.centerRight,
                      child: ElevatedButton(
                        onPressed: _updateProfile,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xAD40B59F),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                          padding:
                              EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                          elevation:
                              8, // Menambahkan shadow pada tombol dengan elevasi
                          shadowColor: Colors.black
                              .withOpacity(0.3), // Menentukan warna bayangan
                        ),
                        child: Text(
                          'Update',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(
      String labelText, IconData icon, TextEditingController controller,
      {bool obscureText = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: Color(0xAD40B59F)),
          labelText: labelText,
          labelStyle: TextStyle(
            color: Colors.black,
            fontSize: 14,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w500,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Color(0xAD40B59F)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Color(0xAD40B59F)),
          ),
        ),
        obscureText: obscureText,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Silakan masukkan $labelText';
          }
          return null;
        },
      ),
    );
  }
}
