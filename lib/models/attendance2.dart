class Attendance2 {
  final int id;
  final int bookingId;
  final String date;
  final String? attendanceProof;
  final Booking? booking;

  Attendance2({
    required this.id,
    required this.bookingId,
    required this.date,
    this.attendanceProof,
    this.booking,
  });

  factory Attendance2.fromJson(Map<String, dynamic> json) {
    return Attendance2(
      id: json['id'],
      bookingId: json['booking_id'],
      date: json['date'],
      attendanceProof: json['attendance_proof'],
      booking: json['booking'] != null ? Booking.fromJson(json['booking']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'booking_id': bookingId,
      'date': date,
      'attendance_proof': attendanceProof,
      'booking': booking?.toJson(),
    };
  }
}

class Booking {
  final int id;
  final User user;
  final Course course;

  Booking({
    required this.id,
    required this.user,
    required this.course,
  });

  factory Booking.fromJson(Map<String, dynamic> json) {
    return Booking(
      id: json['id'],
      user: User.fromJson(json['user']),
      course: Course.fromJson(json['course']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user': user.toJson(),
      'course': course.toJson(),
    };
  }
}

class User {
  final int id;
  final String name;
  final String email;

  User({
    required this.id,
    required this.name,
    required this.email,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
    };
  }
}

class Course {
  final int id;
  final String name;
  final Instructor instruktur;

  Course({
    required this.id,
    required this.name,
    required this.instruktur,
  });

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      id: json['id'],
      name: json['nama'], // Ubah sesuai JSON API
      instruktur: Instructor.fromJson(json['instruktur']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'instruktur': instruktur.toJson(),
    };
  }
}

class Instructor {
  final int id;
  final String name;

  Instructor({
    required this.id,
    required this.name,
  });

  factory Instructor.fromJson(Map<String, dynamic> json) {
    return Instructor(
      id: json['id'],
      name: json['nama'], // Ubah sesuai JSON API
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}
