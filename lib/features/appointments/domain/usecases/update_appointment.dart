import '../entities/appointment_entity.dart';
import '../repositories/appointment_repository.dart';

class AddAppointment {
  final AppointmentRepository repository;

  AddAppointment(this.repository);

  Future<void> call(AppointmentEntity appointment) async {
    await repository.addAppointment(appointment);
  }
}
