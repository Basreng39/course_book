import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:course_book/categoriesCourse.dart';
import 'package:course_book/signatureCourse.dart';
import 'package:course_book/myprofil.dart';

// Model User
class User {
  final String name;
  final String profileImageUrl;

  User({required this.name, required this.profileImageUrl});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'],
      profileImageUrl: json['profile_image_url'],
    );
  }
}

// Fetch User Data from SharedPreferences
Future<User> fetchUser() async {
  final prefs = await SharedPreferences.getInstance();
  final name = prefs.getString('userName') ?? '';
  final profileImageUrl = prefs.getString('userProfileImageUrl') ?? '';

  return User(
    name: name,
    profileImageUrl: profileImageUrl,
  );
}

// Dashboard Widget
class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  late Future<User> futureUser;

  @override
  void initState() {
    super.initState();
    futureUser = fetchUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<User>(
        future: futureUser,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final user = snapshot.data!;
            return SingleChildScrollView(
              child: Column(
                children: [
                  // Hi User and profile image
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    decoration: BoxDecoration(
                      color: Color(0xAD40B59F),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(150),
                        bottomRight: Radius.circular(150),
                      ),
                    ),
                    child: Column(
                      children: [
                        SizedBox(height: 40), // Space at the top
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Hi, ${user.name}',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 26,
                                fontFamily: 'Quicksand',
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MyProfile()),
                                );
                              },
                              child: CircleAvatar(
                                backgroundImage:
                                    NetworkImage(user.profileImageUrl),
                                radius: 25,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10), // Space between text and line
                        Container(
                          width: double.infinity,
                          height: 2,
                          color: Color(0xFF36AB4C), // Line color
                        ),
                        SizedBox(height: 20), // Space below the line
                      ],
                    ),
                  ),

                  // Signature Classes
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Signature Classes',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontFamily: 'Quicksand',
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          SignatureCoursePage()),
                                );
                              },
                              child: Text(
                                'See All',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontFamily: 'Quicksand',
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              SignatureClassCard(
                                imageUrl: 'assets/drawart.png',
                                title: 'Drawing Art',
                                membership: '100 Membership',
                                onTap: () {
                                  // Add navigation if needed
                                },
                              ),
                              SizedBox(width: 20),
                              SignatureClassCard(
                                imageUrl: 'assets/codingAi.png',
                                title: 'Coding Full i',
                                membership: '121 Membership',
                                onTap: () {
                                  // Add navigation if needed
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Categories
                  SizedBox(height: 20),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        Text(
                          'Categories',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontFamily: 'Quicksand',
                            fontWeight: FontWeight.w700,
                            height: 1.1,
                            letterSpacing: 1.20,
                          ),
                        ),
                        SizedBox(height: 10),
                        GridView.count(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          children: [
                            CategoryCard(
                              color: Color(0xFF7E41FE),
                              title: 'Programming',
                              courses: '15 Courses',
                              imageUrl: 'assets/kategoriProg.png',
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => CategoriesCoursePage(categoryId: 1), // Ganti dengan ID kategori yang sesuai
                                  ),
                                );
                              },
                            ),
                            CategoryCard(
                              color: Color(0xFF53AD67),
                              title: 'Writing',
                              courses: '12 Courses',
                              imageUrl: 'assets/kategoriWrite.png',
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => CategoriesCoursePage(categoryId: 2), // Ganti dengan ID kategori yang sesuai
                                  ),
                                );
                              },
                            ),
                            CategoryCard(
                              color: Color(0xFFFFB532),
                              title: 'Drawing',
                              courses: '18 Courses',
                              imageUrl: 'assets/kategoriDraw.png',
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => CategoriesCoursePage(categoryId: 3), // Ganti dengan ID kategori yang sesuai
                                  ),
                                );
                              },
                            ),
                            CategoryCard(
                              color: Color(0xFF52C3FF),
                              title: 'Speaking',
                              courses: '25 Courses',
                              imageUrl: 'assets/kategoriSpeak.png',
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => CategoriesCoursePage(categoryId: 4), // Ganti dengan ID kategori yang sesuai
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Center(child: Text('No data found'));
          }
        },
      ),
    );
  }
}

// SignatureClassCard Widget
class SignatureClassCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String membership;
  final VoidCallback onTap;

  const SignatureClassCard({
    Key? key,
    required this.imageUrl,
    required this.title,
    required this.membership,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 250,
        height: 185,
        decoration: BoxDecoration(
          color: Color(0xFFD9D9D9),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 120, // Adjusted height to fit the rectangle
              margin: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0),
              decoration: BoxDecoration(
                color: Colors.transparent,
                image: DecorationImage(
                  image: AssetImage(imageUrl),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Text(
                title,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontFamily: 'Quicksand',
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Text(
                membership,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                  fontFamily: 'Quicksand',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// CategoryCard Widget
class CategoryCard extends StatelessWidget {
  final Color color;
  final String title;
  final String courses;
  final String imageUrl;
  final VoidCallback onTap;

  const CategoryCard({
    Key? key,
    required this.color,
    required this.title,
    required this.courses,
    required this.imageUrl,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
              child: Image.asset(
                imageUrl,
                width: double.infinity,
                height: 110, // Adjusted height to prevent overflow
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                overflow: TextOverflow.ellipsis, // Handle overflow
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                courses,
                style: TextStyle(
                  fontSize: 14,
                ),
                overflow: TextOverflow.ellipsis, // Handle overflow
              ),
            ),
          ],
        ),
      ),
    );
  }
}




void main() {
  runApp(MaterialApp(
    home: Dashboard(),
  ));
}
