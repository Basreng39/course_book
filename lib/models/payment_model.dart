import 'package:json_annotation/json_annotation.dart';

part 'payment_model.g.dart';

@JsonSerializable()
class Payment {
  final int id;
  final int bookingId;
  final int userId;
  final String paymentProof;
  final String status;
  final Booking booking;

  Payment({
    required this.id,
    required this.bookingId,
    required this.userId,
    required this.paymentProof,
    required this.status,
    required this.booking,
  });

  factory Payment.fromJson(Map<String, dynamic> json) => _$PaymentFromJson(json);
  Map<String, dynamic> toJson() => _$PaymentToJson(this);
}

@JsonSerializable()
class Booking {
  final int id;
  final User user;
  final Course course;

  Booking({
    required this.id,
    required this.user,
    required this.course,
  });

  factory Booking.fromJson(Map<String, dynamic> json) => _$BookingFromJson(json);
  Map<String, dynamic> toJson() => _$BookingToJson(this);
}

@JsonSerializable()
class User {
  final int id;
  final String name;

  User({
    required this.id,
    required this.name,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}

@JsonSerializable()
class Course {
  final int id;
  final String title;

  Course({
    required this.id,
    required this.title,
  });

  factory Course.fromJson(Map<String, dynamic> json) => _$CourseFromJson(json);
  Map<String, dynamic> toJson() => _$CourseToJson(this);
}
