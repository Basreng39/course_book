import 'package:course_book/login.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  Future<void> register() async {
    final url = Uri.parse('http://localhost:8000/api/auth/register');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'name': _nameController.text,
        'email': _emailController.text,
        'alamat': _addressController.text,
        'no_hp': _numberController.text,
        'password': _passwordController.text,
        'confirmPassword': _confirmPasswordController.text,
      }),
    );

    if (response.statusCode == 200) {
      await _showDialog('Success', 'Registration successful!');
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    } else {
      await _showDialog('Failed', 'Registration failed: ${response.body}');
    }
  }

  Future<void> _showDialog(String title, String message) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
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
  }


  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: screenHeight * 0.1), // Adjust top padding
                Text(
                  'Create an account',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 32,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 20),
                _buildTextField(
                  'Please Enter Your Name',
                  Icons.person,
                  controller: _nameController,
                ),
                SizedBox(height: 20),
                _buildTextField(
                  'Please Enter Your Email',
                  Icons.email,
                  controller: _emailController,
                ),
                SizedBox(height: 20),
                _buildTextField(
                  'Please Enter Your Address',
                  Icons.location_on,
                  controller: _addressController,
                ),
                SizedBox(height: 20),
                _buildTextField(
                  'Please Enter Your Number',
                  Icons.phone,
                  controller: _numberController,
                ),
                SizedBox(height: 20),
                _buildPasswordField(
                  'Please Enter Your Password',
                  controller: _passwordController,
                ),
                SizedBox(height: 20),
                _buildPasswordField(
                  'Confirm Your Password',
                  controller: _confirmPasswordController,
                ),
                SizedBox(height: 40),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      register();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF40B59F),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    minimumSize: Size(150, 40), // Adjust this size if needed
                  ),
                  child: Text(
                    'Sign Up',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontFamily: 'Quicksand',
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.20,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Already Have an account? ',
                      style: TextStyle(
                        color: Color(0xFF979797),
                        fontSize: 13,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LoginPage()),
                        );
                      },
                      child: Text(
                        'Sign In',
                        style: TextStyle(
                          color: Color(0xFF40B59F),
                          fontSize: 13,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 10,
                      height: 10,
                      decoration: ShapeDecoration(
                        color: Color(0xFF352555),
                        shape: OvalBorder(),
                      ),
                    ),
                    const SizedBox(width: 5),
                    Container(
                      width: 10,
                      height: 10,
                      decoration: ShapeDecoration(
                        color: Color(0xFF352555),
                        shape: OvalBorder(),
                      ),
                    ),
                    const SizedBox(width: 5),
                    Container(
                      width: 25,
                      height: 10,
                      decoration: ShapeDecoration(
                        color: Color(0xFF40B59F),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String hintText, IconData icon, {required TextEditingController controller}) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          color: Colors.black.withOpacity(0.55),
          fontSize: 13,
          fontFamily: 'Inter',
          fontWeight: FontWeight.w400,
        ),
        prefixIcon: Icon(icon, color: Colors.black.withOpacity(0.55)),
        fillColor: Color(0x1CD9D9D9),
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: Color(0x1CD9D9D9)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: Color(0xFF40B59F)),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your $hintText';
        }
        return null;
      },
    );
  }

  Widget _buildPasswordField(String hintText, {required TextEditingController controller}) {
    return TextFormField(
      controller: controller,
      obscureText: true,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          color: Colors.black.withOpacity(0.55),
          fontSize: 13,
          fontFamily: 'Inter',
          fontWeight: FontWeight.w400,
        ),
        prefixIcon: Icon(Icons.lock, color: Colors.black.withOpacity(0.55)),
        fillColor: Color(0x1CD9D9D9),
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: Color(0x1CD9D9D9)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: Color(0xFF40B59F)),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your $hintText';
        }
        return null;
      },
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: SignUp(),
  ));
}
