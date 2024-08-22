import 'package:course_book/login.dart';
import 'package:flutter/material.dart';
// import 'login_page.dart'; // Ensure you import the LoginPage

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Add some padding around the screen
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 110), // Space above the Welcome to and D’Course text

            // Top Text
            Text(
              'Welcome to',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFF634F4F),
                fontSize: 39,
                fontFamily: 'Quicksand',
                fontWeight: FontWeight.w700,
                letterSpacing: 1.20,
              ),
            ),
            Text(
              'D’Course',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFF40B59F),
                fontSize: 39,
                fontFamily: 'Quicksand',
                fontWeight: FontWeight.w700,
                letterSpacing: 1.20,
              ),
            ),
            SizedBox(height: 20), // Space between text and image

            // Image
            Image.asset(
              'assets/imgwell.png', // Update the path if needed
              width: double.infinity,
              height: 233,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 20), // Space between image and descriptive text

            // Descriptive Text
            Text(
              'Discover Your Brilliance:',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFF40B59F),
                fontSize: 22,
                fontFamily: 'Quicksand',
                fontWeight: FontWeight.w700,
                letterSpacing: 1.20,
              ),
            ),
            Text(
              'Learn, Create, and Thrive!',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFF40B59F),
                fontSize: 20,
                fontFamily: 'Quicksand',
                fontWeight: FontWeight.w700,
                letterSpacing: 1.20,
              ),
            ),
            SizedBox(height: 20), // Space between descriptive text and button

            Text(
              'Take the course, make yourself \nextraordinary, level up and go to \ninfinity.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFF644F4F),
                fontSize: 14,
                fontFamily: 'Quicksand',
                fontWeight: FontWeight.w500,
                letterSpacing: 1.20,
              ),
            ),
            Spacer(), // Pushes the button to the bottom

            // Button
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()), 
                );
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Color(0xFF40B59F), backgroundColor: Colors.white,
                side: BorderSide(width: 1, color: Color(0xFF40B59F)),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                minimumSize: Size(157, 32), // Button size
              ),
              child: Text(
                'Let’s Go',
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: 'Quicksand',
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.20,
                ),
              ),
            ),
            SizedBox(height: 20), // Padding between button and circles

            // Circles
            Container(
              width: 55,
              height: 10,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
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
            ),
            SizedBox(height: 20), // Padding at the bottom
          ],
        ),
      ),
    );
  }
}


