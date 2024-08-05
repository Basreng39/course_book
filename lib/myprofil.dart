import 'package:flutter/material.dart';
import 'package:course_book/login.dart';
import 'package:course_book/update_profil.dart'; // Import file update_profile.dart
import 'package:shared_preferences/shared_preferences.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({Key? key}) : super(key: key);

  @override
  _MyProfileState createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  String _username = '';
  String _email = '';
  String _address = '';
  String _phoneNumber = '';
  String _userProfileImageUrl = '';

  @override
  void initState() {
    super.initState();
    _loadUserProfile();
  }

  Future<void> _loadUserProfile() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _username = prefs.getString('userName') ?? '';
      _email = prefs.getString('email') ?? '';
      _address = prefs.getString('alamat') ?? '';
      _phoneNumber = prefs.getString('no_hp') ?? '';
      _userProfileImageUrl = prefs.getString('userProfileImageUrl') ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Profile'),
        backgroundColor: Color(0xAD40B59F),
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              _showLogoutDialog(context);
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          // Background Container
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
              child: Container(), // Empty child to ensure the decoration is visible
            ),
          ),
          // Profile Image
          Positioned(
            top: 45, // Adjust the top position as needed
            left: MediaQuery.of(context).size.width / 2 - 80, // Center horizontally
            child: CircleAvatar(
              radius: 80,
              backgroundColor: Colors.transparent,
              child: ClipOval(
                child: Image.network(
                  _userProfileImageUrl.isNotEmpty ? _userProfileImageUrl : "",
                  width: 160,
                  height: 160,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          // Update Button
          Positioned(
            top: 210, // Adjust this based on your design
            left: MediaQuery.of(context).size.width / 2 - 75, // Center horizontally
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UpdateProfilePage()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xAD40B59F), // Button color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50), // Button border radius
                ),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5), // Button padding
              ),
              child: Text(
                'Update Profile',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          // Profile Details
          Positioned(
            top: 260, // Adjust based on your design
            left: 16,
            right: 16,
            child: Column(
              children: [
                SizedBox(height: 20),
                _buildProfileInfo(Icons.person, 'Name ', _username),
                _buildProfileInfo(Icons.email, 'Email', _email),
                _buildProfileInfo(Icons.location_on, 'Address', _address),
                _buildProfileInfo(Icons.phone, 'Phone Number', _phoneNumber),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileInfo(IconData icon, String title, String value) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Color(0xAD40B59F),
        child: Icon(icon, color: Colors.white),
      ),
      title: Text(
        title,
        style: TextStyle(
          color: Colors.black,
          fontSize: 14,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: Text(
        value,
        style: TextStyle(
          color: Colors.black,
          fontSize: 14,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Logout'),
          content: Text('Are you sure you want to logout?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                final prefs = await SharedPreferences.getInstance();
                await prefs.clear(); // Clear all data in SharedPreferences
                Navigator.of(context).pop(); // Close the dialog
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
              child: Text('Logout'),
            ),
          ],
        );
      },
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: MyProfile(),
  ));
}
