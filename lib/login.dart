// lib/pages/login_page.dart
import 'package:flutter/material.dart';
import 'package:course_book/register.dart';
import 'package:course_book/navbar.dart';
import 'package:course_book/services/user_service.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final AuthService _authService = AuthService();

  Future<void> loginUser() async {
    try {
      await _authService.loginUser(
        emailController.text,
        passwordController.text,
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => Navbar(),
        ),
      );
    } catch (e) {
      showSnackBar(context, 'Error: $e');
    }
  }

  void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      Container(
                        width: double.infinity,
                        height: constraints.maxWidth < 600 ? 450 : 600,
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.9,
                          height: constraints.maxWidth < 600 ? 380 : 500,
                          decoration: ShapeDecoration(
                            color: Colors.grey[100],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(150),
                                bottomRight: Radius.circular(150),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(height: 130),
                          Image.asset(
                            'assets/imglog.png',
                            width: MediaQuery.of(context).size.width * 1,
                            height: constraints.maxWidth < 600 ? 200 : 300,
                            fit: BoxFit.cover,
                          ),
                          SizedBox(height: 20),
                          Text(
                            'D’Course',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFF40B59F),
                              fontSize: constraints.maxWidth < 600 ? 39 : 48,
                              fontFamily: 'Quicksand',
                              fontWeight: FontWeight.w700,
                              letterSpacing: 1.20,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 80),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        _buildTextField(
                          label: 'Email',
                          icon: Icons.email,
                          controller: emailController,
                        ),
                        SizedBox(height: 20),
                        _buildTextField(
                          label: 'Password',
                          icon: Icons.lock,
                          controller: passwordController,
                          obscureText: true,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 50),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        loginUser();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF40B59F),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      minimumSize: Size(150, 40),
                    ),
                    child: Text(
                      'Sign In',
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
                        'Not Registered yet? ',
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
                            MaterialPageRoute(builder: (context) => SignUp()),
                          );
                        },
                        child: Text(
                          'Create an Account',
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
                  SizedBox(height: 10),
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
                        width: 25,
                        height: 10,
                        decoration: ShapeDecoration(
                          color: Color(0xFF40B59F),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
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
                    ],
                  ),
                  SizedBox(height: 20),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required IconData icon,
    bool obscureText = false,
    required TextEditingController controller,
  }) {
    return Container(
      width: 350,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          filled: true,
          fillColor: Color(0xFFEDEDED),
          hintText: label,
                hintStyle: TextStyle(
               color: Color(0xFF979797),
               fontSize: 14,
               fontFamily: 'Quicksand',
               fontWeight: FontWeight.w400,
             ),
             contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
             border: OutlineInputBorder(
               borderRadius: BorderRadius.circular(15),
               borderSide: BorderSide.none,
             ),
             prefixIcon: Icon(icon, color: Color(0xFF40B59F)),
           ),
           validator: (value) {
             if (value == null || value.isEmpty) {
               return 'Please enter your $label';
             }
             return null;
           },
         ),
       );
     }
   }
   
   void main() {
     runApp(MaterialApp(
       home: LoginPage(),
     ));
   }