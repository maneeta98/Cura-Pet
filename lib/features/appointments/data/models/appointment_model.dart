import '../../domain/entities/appointment_entity.dart';

class AppointmentModel extends AppointmentEntity {
  AppointmentModel({
    required super.id,
    required super.petName,
    required super.date,
    required super.reason,
  });

  factory AppointmentModel.fromJson(Map<String, dynamic> json) {
    return AppointmentModel(
      id: json['_id'] ?? '',
      petName: json['petName'],
      date: DateTime.parse(json['date']),
      reason: json['reason'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'petName': petName,
      'date': date.toIso8601String(),
      'reason': reason,
    };
  }
}
