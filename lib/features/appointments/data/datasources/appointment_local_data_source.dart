import 'package:hive/hive.dart';
import '../models/appointment_model.dart';

class AppointmentLocalDataSource {
  final Box box;

  AppointmentLocalDataSource(this.box);

  Future<void> cacheAppointments(List<AppointmentModel> appointments) async {
    await box.put('appointments', appointments.map((a) => a.toJson()).toList());
  }

  List<AppointmentModel> getCachedAppointments() {
    final data = box.get('appointments', defaultValue: []);
    return (data as List)
        .map(
          (json) => AppointmentModel.fromJson(Map<String, dynamic>.from(json)),
        )
        .toList();
  }
}
