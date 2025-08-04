import 'package:flutter/material.dart';
import '../../domain/entities/appointment_entity.dart';
import '../../domain/usecases/get_appointments.dart';
import '../../domain/usecases/add_appointment.dart' hide GetAppointments;
import '../../domain/usecases/update_appointment.dart';
import '../../domain/usecases/delete_appointment.dart';

class AppointmentViewModel extends ChangeNotifier {
  final GetAppointments getAppointmentsUseCase;
  final AddAppointment addAppointmentUseCase;
  final UpdateAppointment updateAppointmentUseCase;
  final DeleteAppointment deleteAppointmentUseCase;

  AppointmentViewModel({
    required this.getAppointmentsUseCase,
    required this.addAppointmentUseCase,
    required this.updateAppointmentUseCase,
    required this.deleteAppointmentUseCase,
  });

  List<AppointmentEntity> appointments = [];
  bool isLoading = false;

  Future<void> loadAppointments() async {
    isLoading = true;
    notifyListeners();
    appointments = await getAppointmentsUseCase();
    isLoading = false;
    notifyListeners();
  }

  Future<void> addAppointment(AppointmentEntity appointment) async {
    await addAppointmentUseCase(appointment);
    await loadAppointments();
  }

  Future<void> updateAppointment(AppointmentEntity appointment) async {
    await updateAppointmentUseCase(appointment);
    await loadAppointments();
  }

  Future<void> deleteAppointment(String id) async {
    await deleteAppointmentUseCase;
    await loadAppointments();
  }
}

class DeleteAppointment {}
