import 'package:flutter/material.dart';
import 'course_detail.dart'; // Import file detail
import 'dashboard.dart';
// import 'booking_confirmed.dart'; // Import file booking confirmed

class SignatureCoursePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Signature Courses'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Dashboard()),
            );
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            // Header or any introduction section
            Text(
              'Explore Our Signature Courses',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 15),
            
            // List of Signature Courses
            CourseCard(
              imageUrl: 'assets/drawart.png',
              title: 'Drawing Art',
              instructorName: 'John Doe',
              instructorImage: 'assets/pp.jpg',
              rating: '9.3',
              duration: '10 hours',
              price: '\$150',
              languages: ['English', 'Indonesia'],
              startDate: '2024-08-01',
              meetings: '12 Sections',
              description: 'A comprehensive course designed for those new to drawing, covering all the basics. Learn to quickly and effectively sketch urban landscapes and cityscapes.',
              onTap: () => _showCourseDetails(
                context,
                'Drawing Art',
                'John Doe',
                'assets/pp.jpg',
                '9.3',
                '10 hours',
                '\$150',
                ['English', 'Indonesia'],
                '2024-08-01',
                '12 Sections',
                'A comprehensive course designed for those new to drawing, covering all the basics. Learn to quickly and effectively sketch urban landscapes and cityscapes.'
              ),
            ),
            // Add more CourseCard widgets here...
          ],
        ),
      ),
    );
  }

  void _showCourseDetails(
    BuildContext context,
    String title,
    String instructorName,
    String instructorImage,
    String rating,
    String duration,
    String price,
    List<String> languages,
    String startDate,
    String meetings,
    String description,
  ) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return CourseDetail(
          title: title,
          instructorName: instructorName,
          instructorImage: instructorImage,
          rating: rating,
          duration: duration,
          price: price,
          languages: languages,
          startDate: startDate,
          meetings: meetings,
          description: description,
        );
      },
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
              child: Image.asset(
                imageUrl,
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
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
                          backgroundImage: AssetImage(instructorImage),
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