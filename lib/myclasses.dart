import 'package:flutter/material.dart';
// import 'package:course_book/myclasses_detail.dart';
import 'package:course_book/models/attendance2.dart';
import 'package:course_book/services/attendance2_service.dart';

class MyClassesPage extends StatefulWidget {
  const MyClassesPage({Key? key}) : super(key: key);

  @override
  _MyClassesPageState createState() => _MyClassesPageState();
}

class _MyClassesPageState extends State<MyClassesPage> {
  late Attendance2Service _attendanceService;
  late Future<List<Attendance2>> _attendancesFuture;

  @override
  void initState() {
    super.initState();
    _attendanceService = Attendance2Service(baseUrl: 'http://192.168.100.151:8000/api'); // Ganti dengan base URL Anda
    _attendancesFuture = _attendanceService.fetchAttendances();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('My Classes'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Filter Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                FilterButton(label: 'Refine'),
                FilterButton(label: 'Now'),
                FilterButton(label: 'Latest'),
              ],
            ),
            const SizedBox(height: 20),
            // Attendance List
            Expanded(
              child: FutureBuilder<List<Attendance2>>(
                future: _attendancesFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('No classes found.'));
                  }

                  final attendances = snapshot.data!;
                  return ListView.builder(
                    itemCount: attendances.length,
                    itemBuilder: (context, index) {
                      final attendance = attendances[index];
                      return GestureDetector(
                        onTap: () => _showCourseDetail(context, attendance),
                        child: CourseCard(
                          courseTitle: attendance.booking!.course.name,
                          instructorName: attendance.booking!.course.instruktur.name,
                          courseImage: 'assets/fullClass.png', // Ubah dengan image dinamis jika ada
                          instructorImage: 'assets/pp.jpg', // Ubah dengan image dinamis jika ada
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showCourseDetail(BuildContext context, Attendance2 attendance) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return MyClassesDetailPage(attendance: attendance);
      },
    );
  }
}

class MyClassesDetailPage extends StatelessWidget {
  final Attendance2 attendance;

  const MyClassesDetailPage({
    Key? key,
    required this.attendance,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 15),
            Container(
              width: 345,
              height: 192,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
                image: DecorationImage(
                  image: AssetImage('assets/fullClass.png'), // Ganti dengan image dinamis
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    attendance.booking!.course.name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          attendance.booking!.course.instruktur.name,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset(
                          'assets/pp.jpg', // Ubah dengan image dinamis
                          width: 40,
                          height: 40,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {
                            // Implement functionality to upload photo attendance
                          },
                          icon: const Icon(Icons.upload_file),
                          label: const Text('Upload Attendance'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF40B59F),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {
                            // Implement functionality to upload medical leave
                          },
                          icon: const Icon(Icons.upload_file),
                          label: const Text('Upload Medical Leave'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF40B59F),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        // Implement check attendance functionality
                      },
                      child: const Text('Check'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF40B59F),
                        padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
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

class FilterButton extends StatelessWidget {
  final String label;

  const FilterButton({required this.label});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFFA7D7D8),
        foregroundColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
      ),
      child: Text(label),
    );
  }
}

class CourseCard extends StatelessWidget {
  final String courseTitle;
  final String instructorName;
  final String courseImage;
  final String instructorImage;

  const CourseCard({
    Key? key,
    required this.courseTitle,
    required this.instructorName,
    required this.courseImage,
    required this.instructorImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
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
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
                child: Image.asset(
                  courseImage,
                  width: double.infinity,
                  height: 182,
                  fit: BoxFit.cover,
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
                            boxShadow: const [
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
                          child: Image.asset(
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
                          style: const TextStyle(
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
                  courseTitle,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(22.0, 0.0, 15.0, 10.0),
            child: Row(
              children: const [
                Icon(Icons.access_time, size: 17, color: Color(0xFF999999)),
                SizedBox(width: 8),
                Text(
                  '6hr',
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xFF999999),
                  ),
                ),
                SizedBox(width: 25),
                Icon(Icons.book, size: 17, color: Color(0xFF999999)),
                SizedBox(width: 8),
                Text(
                  '12 sections',
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xFF999999),
                  ),
                ),
                Spacer(),
                Icon(Icons.calendar_today, size: 17, color: Color(0xFF999999)),
                SizedBox(width: 8),
                Text(
                  'Start: 23 July 2024',
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
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: MyClassesPage(),
  ));
}
