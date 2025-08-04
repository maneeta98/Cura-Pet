import '../entities/appointment_entity.dart';

abstract class AppointmentRepository {
  Future<List<AppointmentEntity>> getAppointments();
  Future<void> addAppointment(AppointmentEntity appointment);
  Future<void> updateAppointment(AppointmentEntity appointment);
  Future<void> deleteAppointment(String id);
}
