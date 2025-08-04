import 'package:dio/dio.dart';
import '../models/appointment_model.dart';

class AppointmentRemoteDataSource {
  final Dio dio;

  AppointmentRemoteDataSource(this.dio);

  Future<List<AppointmentModel>> fetchAppointments() async {
    final response = await dio.get('http://localhost:5050/api/appointments');
    return (response.data as List)
        .map((json) => AppointmentModel.fromJson(json))
        .toList();
  }

  Future<void> addAppointment(AppointmentModel appointment) async {
    await dio.post(
      'http://localhost:5050/api/appointments',
      data: appointment.toJson(),
    );
  }

  Future<void> updateAppointment(AppointmentModel appointment) async {
    await dio.put(
      'http://localhost:5050/api/appointments/${appointment.id}',
      data: appointment.toJson(),
    );
  }

  Future<void> deleteAppointment(String id) async {
    await dio.delete('http://localhost:5050/api/appointments/$id');
  }
}
