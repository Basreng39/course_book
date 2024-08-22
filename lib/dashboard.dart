import 'package:flutter/material.dart';
import 'package:course_book/models/user_model.dart';
import 'package:course_book/services/user_service.dart'; // Pastikan UserService telah diganti menjadi AuthService
import 'package:course_book/signatureCourse.dart';
import 'package:course_book/services/course_services.dart'; // Pastikan ini sudah diimpor
import 'package:course_book/models/course.dart'; // Pastikan ini sudah diimpor
import 'package:course_book/signatureCourse_detail.dart';
import 'navbar.dart'; // Pastikan ini diimpor

class Dashboard extends StatefulWidget {
  final Function(int) onCategorySelected;

  const Dashboard({Key? key, required this.onCategorySelected})
      : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  late Future<User?> futureUser;

  @override
  void initState() {
    super.initState();
    futureUser = AuthService().getUserFromPreferences();
  }

  Future<List<Course>> _fetchTopThreeSignatureCourses() async {
    ApiService apiService =
        ApiService(baseUrl: 'http://192.168.100.151:8000/api');
        // ApiService(baseUrl: 'http://127.0.0.1:8000/api');
    List<Course> allCourses = await apiService.getCourses();

    List<Course> filteredCourses = allCourses.where((course) {
      double rating = double.tryParse(course.rating) ?? 0.0;
      return rating > 8.5;
    }).toList();

    filteredCourses.sort((a, b) => (double.tryParse(b.rating) ?? 0.0)
        .compareTo(double.tryParse(a.rating) ?? 0.0));

    return filteredCourses.take(3).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<User?>(
        future: futureUser,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData && snapshot.data != null) {
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
                        SizedBox(height: 40),
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
                                // Ubah halaman yang sedang ditampilkan di Navbar menjadi MyProfile
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Navbar(
                                        selectedIndex:
                                            4), // Indeks untuk halaman MyProfile
                                  ),
                                );
                              },
                              child: CircleAvatar(
                                radius: 25,
                                backgroundImage:
                                    user.image != null && user.image!.isNotEmpty
                                        ? NetworkImage(user.userProfileImageUrl)
                                        : null, // No image if null or empty
                                child: user.image == null || user.image!.isEmpty
                                    ? Icon(Icons.person,
                                        size:
                                            25) // Display human icon when no image
                                    : null, // If image is available, child is null so image is shown
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 10),
                        Container(
                          width: 300,
                          height: 3,
                          color: Color(0xFF36AB4C),
                        ),
                        SizedBox(height: 20),
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
                                    builder: (context) => SignatureCoursePage(),
                                  ),
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
                        FutureBuilder<List<Course>>(
                          future: _fetchTopThreeSignatureCourses(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(child: CircularProgressIndicator());
                            } else if (snapshot.hasError) {
                              return Center(
                                  child: Text('Failed to load courses'));
                            } else if (!snapshot.hasData ||
                                snapshot.data!.isEmpty) {
                              return Center(
                                  child: Text('No signature courses found'));
                            } else {
                              List<Course> courses = snapshot.data!;
                              return SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: courses.map((course) {
                                    return Padding(
                                      padding:
                                          const EdgeInsets.only(right: 20.0),
                                      child: SignatureClassCard(
                                        imageUrl: course.fullGambarUrl,
                                        title: course.nama,
                                        membership:
                                            '${course.jumlahPertemuan} Sections',
                                        rating: course.rating,
                                        onTap: () {
                                          SignatureCourseDetail
                                              .showCourseDetails(
                                            context,
                                            course.id, // Tambahkan ini
                                            course
                                                .instruktur.id, // Tambahkan ini
                                            course.nama,
                                            course.fullGambarUrl,
                                            course.instruktur.nama,
                                            course.instruktur.fullImageUrl,
                                            course.rating,
                                            '${course.jamPelajaran} hr',
                                            '\$${course.harga}',
                                            course.language.split(','),
                                            course.formattedStartCourse,
                                            '${course.jumlahPertemuan} Sections',
                                            course.deskripsi,
                                          );
                                        },
                                      ),
                                    );
                                  }).toList(),
                                ),
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ),

                  // Categories
                  SizedBox(height: 5),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        Align(
                          alignment:
                              Alignment.centerLeft, // Mengatur teks ke kiri
                          child: Text(
                            'Categories',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontFamily: 'Quicksand',
                              fontWeight: FontWeight.w700,
                              height: 1.1,
                              letterSpacing: 1.20,
                            ),
                          ),
                        ),
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
                              courses: '1 Courses',
                              imageUrl: 'assets/kategoriProg.png',
                              onTap: () {
                                widget.onCategorySelected(2);
                              },
                            ),
                            CategoryCard(
                              color: Color(0xFF53AD67),
                              title: 'Writing',
                              courses: '1 Courses',
                              imageUrl: 'assets/kategoriWrite.png',
                              onTap: () {
                                widget.onCategorySelected(3);
                              },
                            ),
                            CategoryCard(
                              color: Color(0xFFFFB532),
                              title: 'Drawing',
                              courses: '2 Courses',
                              imageUrl: 'assets/kategoriDraw.png',
                              onTap: () {
                                widget.onCategorySelected(1);
                              },
                            ),
                            CategoryCard(
                              color: Color(0xFF52C3FF),
                              title: 'Speaking',
                              courses: '2 Courses',
                              imageUrl: 'assets/kategoriSpeak.png',
                              onTap: () {
                                widget.onCategorySelected(4);
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
  final String rating;
  final VoidCallback onTap;

  const SignatureClassCard({
    Key? key,
    required this.imageUrl,
    required this.title,
    required this.membership,
    required this.rating,
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
          boxShadow: [
            BoxShadow(
              color: Color(0x3F000000),
              blurRadius: 4,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 120,
              margin: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0),
              decoration: BoxDecoration(
                color: Colors.transparent,
                image: DecorationImage(
                  image: NetworkImage(imageUrl),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            SizedBox(height: 5),
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    membership,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontFamily: 'Quicksand',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.amber, size: 14),
                      SizedBox(width: 5),
                      Text(
                        rating,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontFamily: 'Quicksand',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ],
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
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 10),
            Image.asset(
              imageUrl,
              height: 80,
            ),
            SizedBox(height: 10),
            Text(
              title,
              style: TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontFamily: 'Quicksand',
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 5),
            Text(
              courses,
              style: TextStyle(
                color: Colors.black,
                fontSize: 12,
                fontFamily: 'Quicksand',
                fontWeight: FontWeight.w400,
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
    home: Dashboard(
      onCategorySelected: (int categoryId) {
        // Implementasi untuk navigasi ketika kategori dipilih
      },
    ),
  ));
}
