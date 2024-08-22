import 'package:flutter/material.dart';
import 'services/course_services.dart';
import 'models/course.dart';
import 'categoriesCourse_detail.dart';
import 'dashboard.dart';

void main() {
  runApp(MaterialApp(
    home: CategoriesCoursePage(categoryId: null), // Tampilkan semua kursus
  ));
}

class CategoriesCoursePage extends StatefulWidget {
  final int? categoryId;

  const CategoriesCoursePage({Key? key, this.categoryId}) : super(key: key);

  @override
  _CategoriesCoursePageState createState() => _CategoriesCoursePageState();
}

class _CategoriesCoursePageState extends State<CategoriesCoursePage> {
  String _sortOption = 'Now';
  late ApiService apiService;
  late Future<List<Course>> futureCourses;

  final Map<int, String> categoryNames = {
    1: 'Drawing',
    2: 'Programming',
    3: 'Writing',
    4: 'Speaking',
  };

  @override
  void initState() {
    super.initState();
    apiService = ApiService(baseUrl: 'http://192.168.100.151:8000/api');
    // apiService = ApiService(baseUrl: 'http://127.0.0.1:8000/api');
    futureCourses = apiService.getCourses(); // Ambil semua kursus
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => Dashboard(
                    onCategorySelected: (int categoryId) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CategoriesCoursePage(
                            categoryId: categoryId,
                          ),
                        ),
                      );
                    },
                  )),
        );
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text('Courses'), // Title set to "Courses" permanently
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Move the Text widget above the Row
              Text(
                widget.categoryId != null
                    ? 'Courses by ${categoryNames[widget.categoryId]}'
                    : 'Courses',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildFilterButton('Refine'),
                  _buildFilterButton('Now'),
                  _buildFilterButton('Latest'),
                ],
              ),
              SizedBox(height: 15),
              FutureBuilder<List<Course>>(
                future: futureCourses,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Failed to load courses'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text('No courses available'));
                  } else {
                    List<Course> courses = _sortCourses(snapshot.data!);

                    if (widget.categoryId != null) {
                      courses = courses
                          .where((course) =>
                              course.categoryId == widget.categoryId)
                          .toList(); // Filter berdasarkan categoryId
                    }

                    return Column(
                      children: courses.map((course) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: CategoryCard(
                            courseId:
                                course.id, // Pastikan ini valid dan diteruskan
                            instrukturId: course.instruktur
                                .id, // Pastikan ini valid dan diteruskan
                            imageUrl: course.fullGambarUrl,
                            title: course.nama,
                            deskripsi: course.deskripsi,
                            instructorName: course.instruktur.nama,
                            instructorImage: course.instruktur.fullImageUrl,
                            rating: course.rating.toString(),
                            duration: '${course.jamPelajaran} hr',
                            sections: '${course.jumlahPertemuan} Sections',
                            startDate: course.formattedStartCourse,
                            price: '\$${course.harga}',
                            language: course.language.split(','),
                            languageIcon: 'https://via.placeholder.com/17x17',
                          ),
                        );
                      }).toList(),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFilterButton(String title) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _sortOption = title;
          futureCourses =
              apiService.getCourses(); // Re-fetch courses to apply sorting
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
    switch (_sortOption) {
      case 'Now':
        courses.sort((a, b) =>
            b.startCourse.compareTo(a.startCourse)); // Paling baru di atas
        break;
      case 'Latest':
        courses.sort((a, b) =>
            a.startCourse.compareTo(b.startCourse)); // Paling lama di atas
        break;
      default:
        // Default sorting or 'Refine' logic
        break;
    }

    return courses;
  }
}

class CategoryCard extends StatelessWidget {
  final int courseId; // Tambahkan ini
  final int instrukturId; // Tambahkan ini
  final String imageUrl;
  final String title;
  final String deskripsi;
  final String instructorName;
  final String instructorImage;
  final String rating;
  final String duration;
  final String sections;
  final String startDate;
  final String price;
  final List<String> language;
  final String languageIcon;

  const CategoryCard({
    Key? key,
    required this.courseId, // Tambahkan ini
    required this.instrukturId, // Tambahkan ini
    required this.imageUrl,
    required this.title,
    required this.deskripsi,
    required this.instructorName,
    required this.instructorImage,
    required this.rating,
    required this.duration,
    required this.sections,
    required this.startDate,
    required this.price,
    required this.language,
    required this.languageIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        CategoriescourseDetail.showCourseDetails(
          context,
          courseId, // Pastikan variabel ini dideklarasikan dan valid
          instrukturId, // Pastikan variabel ini dideklarasikan dan valid
          title,
          imageUrl,
          instructorName,
          instructorImage,
          rating,
          duration,
          price,
          language,
          startDate,
          sections,
          deskripsi,
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
                        borderRadius: BorderRadius.circular(
                            15), 
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black
                                .withOpacity(0.25), // Shadow color with opacity
                            blurRadius: 10, // Shadow blur radius
                            offset: Offset(0, 4), // Shadow position
                          ),
                        ],
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
                            child: instructorImage.startsWith('assets/')
                                ? Image.asset(
                                    instructorImage,
                                    width: 33,
                                    height: 33,
                                    fit: BoxFit.cover,
                                  )
                                : FadeInImage.assetNetwork(
                                    placeholder:
                                        '', // Remove the asset placeholder
                                    image: instructorImage,
                                    width: 33,
                                    height: 33,
                                    fit: BoxFit.cover,
                                    placeholderErrorBuilder:
                                        (context, error, stackTrace) {
                                      return Icon(
                                        Icons
                                            .person, // Display a people or human icon while loading
                                        size: 33,
                                      );
                                    },
                                    imageErrorBuilder:
                                        (context, error, stackTrace) {
                                      return Image.asset(
                                        'assets/error.jpg',
                                        width: 33,
                                        height: 33,
                                        fit: BoxFit.cover,
                                      );
                                    },
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
                      SizedBox(width: 4),
                      Text(
                        rating,
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
            Padding(
              padding: const EdgeInsets.fromLTRB(22.0, 0.0, 15.0, 10.0),
              child: Row(
                children: [
                  Icon(Icons.access_time, size: 17, color: Color(0xFF999999)),
                  SizedBox(width: 8),
                  Text(
                    duration,
                    style: TextStyle(
                      fontSize: 12,
                      color: Color(0xFF999999),
                    ),
                  ),
                  SizedBox(width: 25),
                  Icon(Icons.book, size: 17, color: Color(0xFF999999)),
                  SizedBox(width: 8),
                  Text(
                    sections,
                    style: TextStyle(
                      fontSize: 12,
                      color: Color(0xFF999999),
                    ),
                  ),
                  Spacer(),
                  Icon(Icons.calendar_today,
                      size: 17, color: Color(0xFF999999)),
                  SizedBox(width: 8),
                  Text(
                    'Start: $startDate',
                    style: TextStyle(
                      fontSize: 12,
                      color: Color(0xFF999999),
                    ),
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
