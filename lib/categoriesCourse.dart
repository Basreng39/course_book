import 'package:flutter/material.dart';
import 'package:course_book/services/course_services.dart'; // Ganti dengan path yang sesuai
import 'package:course_book/models/course.dart'; // Ganti dengan path yang sesuai
import 'dashboard.dart';
import 'categoriesCourse_detail.dart'; 

class CategoriesCoursePage extends StatefulWidget {
  final int categoryId; 

  const CategoriesCoursePage({Key? key, required this.categoryId}) : super(key: key);

  @override
  _CategoriesCoursePageState createState() => _CategoriesCoursePageState();
}

class _CategoriesCoursePageState extends State<CategoriesCoursePage> {
  String _sortOption = 'Now'; // Default sorting option

  late Future<List<Course>> _coursesFuture;

  @override
  void initState() {
    super.initState();
    _coursesFuture = CourseService().fetchCoursesByCategory(widget.categoryId);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Dashboard()),
        );
        return false; // Prevent default back navigation
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Categories Courses'),
        ),
        body: FutureBuilder<List<Course>>(
          future: _coursesFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text('No courses found'));
            } else {
              List<Course> sortedCourses = _sortCourses(snapshot.data!);

              return SingleChildScrollView(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Course By Categories',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 15),

                    // Filter bar
                    Container(
                      width: 317,
                      height: 29,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildFilterButton('Refine'),
                          _buildFilterButton('Now'),
                          _buildFilterButton('Latest'),
                        ],
                      ),
                    ),
                    SizedBox(height: 15),

                    // List of Category Courses
                    ...sortedCourses.map((course) => CategoryCard(
                      imageUrl: course.imageUrl,
                      title: course.title,
                      instructorName: course.instructorName,
                      instructorImage: course.instructorImage,
                      rating: course.rating,
                      duration: course.duration,
                      sections: course.sections,
                      startDate: course.startDate,
                      price: course.price,
                      languageIcon: course.languageIcon,
                    )).toList(),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }

  Widget _buildFilterButton(String title) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _sortOption = title;
        });
      },
      child: Container(
        width: 79,
        height: 29,
        decoration: BoxDecoration(
          color: Color(0xFFAEE0D7),
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Color(0x3F000000),
              blurRadius: 4,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              color: Colors.black,
              fontSize: 14,
              fontFamily: 'Quicksand',
              fontWeight: FontWeight.w600,
              letterSpacing: 1.20,
            ),
          ),
        ),
      ),
    );
  }

  List<Course> _sortCourses(List<Course> courses) {
    List<Course> sortedCourses = List.from(courses);

    switch (_sortOption) {
      case 'Now':
        // Implement sorting logic for 'Now' if needed
        break;
      case 'Latest':
        // Implement sorting logic for 'Latest'
        sortedCourses.sort((a, b) => b.startDate.compareTo(a.startDate));
        break;
      default:
        // Default sorting or 'Refine' logic
        break;
    }

    return sortedCourses;
  }
}

class CategoryCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String instructorName;
  final String instructorImage;
  final String rating;
  final String duration;
  final String sections;
  final String startDate;
  final String price;
  final String languageIcon;

  const CategoryCard({
    Key? key,
    required this.imageUrl,
    required this.title,
    required this.instructorName,
    required this.instructorImage,
    required this.rating,
    required this.duration,
    required this.sections,
    required this.startDate,
    required this.price,
    required this.languageIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        CategoriescourseDetail.showCourseDetails(
          context,
          title,
          instructorName,
          instructorImage,
          rating,
          duration,
          price,
          ['English', 'Arab'],
          startDate,
          sections,
          '"Basic Drawing Techniques" covers foundational skills essential for creating compelling artwork, including line work, shading, and perspective. This course is ideal for beginners aiming to develop their drawing abilities and artistic confidence.', // Ganti dengan deskripsi kursus yang sesuai
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 4,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Center(
                    child: Container(
                      width: 334,
                      height: 182,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
                        image: DecorationImage(
                          image: NetworkImage(imageUrl),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  right: 20,
                  bottom: -15,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0x3F000000),
                          blurRadius: 4,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Text(
                      price,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 20,
                  bottom: -25,
                  child: Container(
                    width: 115,
                    height: 42,
                    child: Stack(
                      children: [
                        Positioned(
                          left: 0,
                          top: 0,
                          child: Container(
                            width: 115,
                            height: 42,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0x3F000000),
                                  blurRadius: 4,
                                  offset: Offset(0, 4),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          left: 77,
                          top: 4,
                          child: ClipOval(
                            child: Image.network(
                              instructorImage,
                              width: 33,
                              height: 33,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Positioned(
                          left: 13,
                          top: 12,
                          child: Text(
                            instructorName,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 30.0, 17.0, 4.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.amber, size: 20),
                      Text(
                        rating,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Row(
                children: [
                  Image.network(
                    languageIcon,
                    width: 22,
                    height: 22,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(width: 5),
                  Text(
                    duration,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, bottom: 10.0),
              child: Text(
                '$sections sections',
                style: TextStyle(
                  fontSize: 14,
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
