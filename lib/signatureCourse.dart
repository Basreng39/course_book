import 'package:flutter/material.dart';
import 'package:course_book/models/course.dart';
import 'package:course_book/services/course_services.dart';
import 'signatureCourse_detail.dart';
import 'navbar.dart';

class SignatureCoursePage extends StatefulWidget {
  @override
  _SignatureCoursePageState createState() => _SignatureCoursePageState();
}

class _SignatureCoursePageState extends State<SignatureCoursePage> {
  late Future<List<Course>> _signatureCourses;

  @override
  void initState() {
    super.initState();
    _signatureCourses = _fetchSignatureCourses();
  }

  Future<List<Course>> _fetchSignatureCourses() async {
    ApiService apiService =
        ApiService(baseUrl: 'http://192.168.100.151:8000/api');
        // ApiService(baseUrl: 'http://127.0.0.1:8000/api');
    List<Course> allCourses = await apiService.getCourses();

    List<Course> filteredCourses = allCourses.where((course) {
      double rating = double.tryParse(course.rating) ?? 0.0;
      return rating > 8.5;
    }).toList();

    // Sort the filtered courses by rating in descending order
    filteredCourses.sort((a, b) => (double.tryParse(b.rating) ?? 0.0)
        .compareTo(double.tryParse(a.rating) ?? 0.0));

    return filteredCourses;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Signature Courses'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    Navbar(), // Kembali ke Navbar yang berisi Dashboard
              ),
            );
          },
        ),
      ),
      body: FutureBuilder<List<Course>>(
        future: _signatureCourses,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Failed to load courses'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
                child: Text('No courses with rating above 8.5 found'));
          } else {
            List<Course> courses = snapshot.data!;
            return SingleChildScrollView(
              padding: EdgeInsets.all(16),
              child: Column(
                children: courses.map((course) {
                  return Column(
                    children: [
                      CourseCard(
                        imageUrl: course.fullGambarUrl,
                        title: course.nama,
                        instructorName: course.instruktur.nama,
                        instructorImage: course.instruktur.fullImageUrl,
                        rating: course.rating,
                        duration: '${course.jamPelajaran} hours',
                        price: '\$${course.harga}',
                        languages: [course.language],
                        startDate: course.formattedStartCourse,
                        meetings: '${course.jumlahPertemuan} Sections',
                        description: course.deskripsi,
                        onTap: () => SignatureCourseDetail.showCourseDetails(
                          context,
                          course.id, // Pastikan ID course diteruskan
                          course.instruktur.id, // Pastikan ID instruktur diteruskan
                          course.nama,
                          course.fullGambarUrl,
                          course.instruktur.nama,
                          course.instruktur.fullImageUrl,
                          course.rating,
                          '${course.jamPelajaran} hours',
                          '\$${course.harga}',
                          [course.language],
                          course.formattedStartCourse,
                          '${course.jumlahPertemuan} Sections',
                          course.deskripsi,
                        ),
                      ),
                      SizedBox(
                          height:
                              10), // Tambahkan SizedBox untuk menambah jarak antar Card
                    ],
                  );
                }).toList(),
              ),
            );
          }
        },
      ),
    );
  }
}

class CourseCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String instructorName;
  final String instructorImage;
  final String rating;
  final String duration;
  final String price;
  final List<String> languages;
  final String startDate;
  final String meetings;
  final String description;
  final VoidCallback onTap;

  const CourseCard({
    Key? key,
    required this.imageUrl,
    required this.title,
    required this.instructorName,
    required this.instructorImage,
    required this.rating,
    required this.duration,
    required this.price,
    required this.languages,
    required this.startDate,
    required this.meetings,
    required this.description,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              clipBehavior: Clip.hardEdge,
              child: Image.network(
                imageUrl,
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage(instructorImage),
                          radius: 16,
                        ),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            instructorName,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[700],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(Icons.star, color: Colors.amber, size: 20),
                        SizedBox(width: 4),
                        Text(
                          rating,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                        SizedBox(width: 12),
                        Icon(Icons.access_time, color: Colors.grey, size: 20),
                        SizedBox(width: 4),
                        Text(
                          duration,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                        SizedBox(width: 12),
                        Icon(Icons.attach_money, color: Colors.grey, size: 20),
                        SizedBox(width: 4),
                        Text(
                          price,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
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
    home: SignatureCoursePage(),
  ));
}
