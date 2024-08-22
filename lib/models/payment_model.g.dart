// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Payment _$PaymentFromJson(Map<String, dynamic> json) => Payment(
      id: (json['id'] as num).toInt(),
      bookingId: (json['bookingId'] as num).toInt(),
      userId: (json['userId'] as num).toInt(),
      paymentProof: json['paymentProof'] as String,
      status: json['status'] as String,
      booking: Booking.fromJson(json['booking'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PaymentToJson(Payment instance) => <String, dynamic>{
      'id': instance.id,
      'bookingId': instance.bookingId,
      'userId': instance.userId,
      'paymentProof': instance.paymentProof,
      'status': instance.status,
      'booking': instance.booking,
    };

Booking _$BookingFromJson(Map<String, dynamic> json) => Booking(
      id: (json['id'] as num).toInt(),
      user: User.fromJson(json['user'] as Map<String, dynamic>),
      course: Course.fromJson(json['course'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$BookingToJson(Booking instance) => <String, dynamic>{
      'id': instance.id,
      'user': instance.user,
      'course': instance.course,
    };

User _$UserFromJson(Map<String, dynamic> json) => User(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };

Course _$CourseFromJson(Map<String, dynamic> json) => Course(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
    );

Map<String, dynamic> _$CourseToJson(Course instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
    };
