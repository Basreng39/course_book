import 'dart:convert';

class Course {
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

  Course({
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
  });

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      imageUrl: json['image_url'],
      title: json['title'],
      instructorName: json['instructor_name'],
      instructorImage: json['instructor_image'],
      rating: json['rating'].toString(),
      duration: json['duration'],
      sections: json['sections'].toString(),
      startDate: json['start_date'],
      price: json['price'],
      languageIcon: json['language_icon'],
    );
  }

  static List<Course> fromJsonList(String jsonString) {
    final data = json.decode(jsonString) as List;
    return data.map((json) => Course.fromJson(json)).toList();
  }
}
