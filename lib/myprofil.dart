import 'package:flutter/material.dart';
import 'package:course_book/login.dart';
import 'package:course_book/update_profil.dart';
import 'package:course_book/services/user_service.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({Key? key}) : super(key: key);

  @override
  _MyProfileState createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  final AuthService _authService = AuthService();

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

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loadUserProfile(); // Memastikan data dimuat ulang ketika halaman aktif
  }

  Future<void> _loadUserProfile() async {
    final user = await _authService.getUserFromPreferences();
    if (user != null) {
      setState(() {
        _username = user.name;
        _email = user.email;
        _address = user.address ?? '';
        _phoneNumber = user.phoneNumber ?? '';
        _userProfileImageUrl = user.userProfileImageUrl;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
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
          _buildBackgroundContainer(),
          _buildProfileImage(),
          _buildUpdateButton(context),
          _buildProfileDetails(),
        ],
      ),
    );
  }

  Positioned _buildBackgroundContainer() {
    return Positioned(
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
    );
  }

  Positioned _buildProfileImage() {
    return Positioned(
      top: 45,
      left: MediaQuery.of(context).size.width / 2 - 80,
      child: CircleAvatar(
        radius: 80,
        backgroundColor: Colors.transparent,
        child: ClipOval(
          child: _userProfileImageUrl.isNotEmpty
              ? Image.network(
                  _userProfileImageUrl,
                  width: 160,
                  height: 160,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Icon(
                      Icons.person, // Default icon if network image fails
                      size: 80,
                      color: Colors.grey,
                    );
                  },
                )
              : Icon(
                  Icons.person, // Default icon when no image is available
                  size: 80,
                  color: Colors.grey,
                ),
        ),
      ),
    );
  }

  Positioned _buildUpdateButton(BuildContext context) {
    return Positioned(
      top: 210,
      left: MediaQuery.of(context).size.width / 2 - 75,
      child: ElevatedButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => UpdateProfilePage()),
          );
          _loadUserProfile(); // Memuat ulang data profil setelah pembaruan
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xAD40B59F),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          elevation: 8, // Menambahkan shadow pada tombol dengan elevasi
          shadowColor:
              Colors.black.withOpacity(0.3), // Menentukan warna bayangan
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
    );
  }

  Positioned _buildProfileDetails() {
    return Positioned(
      top: 260,
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
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                await _authService
                    .clearUserData(); // Use AuthService to clear data
                Navigator.of(context).pop();
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
