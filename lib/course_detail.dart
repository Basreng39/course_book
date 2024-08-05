import 'package:flutter/material.dart';

class CourseDetail extends StatelessWidget {
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

  const CourseDetail({
    Key? key,
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
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 15),
          // Kontainer untuk gambar
          Container(
            width: 345,
            height: 232,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
              image: DecorationImage(
                image: AssetImage('assets/drawart.png'), // Ganti dengan gambar yang sesuai
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Judul Kursus
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),

                // Nama Instruktur dan Gambar Instruktur
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        instructorName,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                    ),
                    SizedBox(width: 8),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(
                        instructorImage,
                        width: 40,
                        height: 40,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),

                // Rating, Durasi, dan Harga
                Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Icon(Icons.star, color: Colors.amber, size: 20),
                          Text(
                            rating,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          Icon(Icons.access_time, color: Colors.grey, size: 20),
                          Text(
                            duration,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          Icon(Icons.attach_money, color: Colors.grey, size: 20),
                          Text(
                            price,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),

                // Bahasa
                Row(
                  children: [
                    Icon(Icons.language, color: Colors.grey, size: 20), // Ikon untuk Languages
                    SizedBox(width: 8), // Jarak antara ikon dan teks
                    Expanded(
                      child: Text(
                        'Languages:',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        languages.join(', '),
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),

                // Tanggal Mulai
                Row(
                  children: [
                    Icon(Icons.calendar_today, color: Colors.grey, size: 20), // Ikon untuk Start Date
                    SizedBox(width: 8), // Jarak antara ikon dan teks
                    Expanded(
                      child: Text(
                        'Start Date:',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        startDate,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),

                // Pertemuan
                Row(
                  children: [
                    Icon(Icons.event, color: Colors.grey, size: 20), // Ikon untuk Meetings
                    SizedBox(width: 8), // Jarak antara ikon dan teks
                    Expanded(
                      child: Text(
                        'Meetings:',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        meetings,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 16),

                // Deskripsi
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
                SizedBox(height: 16),

                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      _showBookingConfirmed(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF40B59F),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      minimumSize: Size(150, 40),
                      padding: EdgeInsets.symmetric(vertical: 12),
                    ),
                    child: Text(
                      'Book Now',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontFamily: 'Quicksand',
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.20,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showBookingConfirmed(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.all(16.0),
          backgroundColor: Color(0xFFD2EFFF),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          content: SizedBox(
            width: 304,
            height: 153,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/Check.png"),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  'Booking Confirmed!',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'You have successfully booked the course.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black.withOpacity(0.6),
                    fontSize: 14,
                    fontFamily: 'Quicksand',
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.2,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  static void showCourseDetails(
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
