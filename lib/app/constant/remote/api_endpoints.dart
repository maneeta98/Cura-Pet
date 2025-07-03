class ApiEndpoints {
  ApiEndpoints._();

  // Timeouts
  static const connectionTimeout = Duration(seconds: 30);
  static const receiveTimeout = Duration(seconds: 30);

  // Localhost for Android Emulator
  static const String serverAddress = "http://10.0.2.2:5050";

  // Base URL
  static const String baseUrl = "$serverAddress/api/";
  static const String imageUrl = "$serverAddress/uploads/";

  // -------- AUTH --------
  static const String login = "${baseUrl}auth/login";
  static const String register = "${baseUrl}auth/register";

  // -------- USER --------
  static const String getUserProfile = "${baseUrl}users/profile";
  static const String updateUserProfile = "${baseUrl}users/update";

  // -------- APPOINTMENTS --------
  static const String createAppointment = "${baseUrl}appointments/create";
  static const String getAppointments = "${baseUrl}appointments";
  static const String updateAppointment =
      "${baseUrl}appointments/update"; // :id
  static const String deleteAppointment =
      "${baseUrl}appointments/delete"; // :id

  // -------- MEDICAL RECORDS --------
  static const String getMedicalRecords = "${baseUrl}records";
  static const String addMedicalRecord = "${baseUrl}records/add";

  // -------- REMINDERS --------
  static const String getReminders = "${baseUrl}reminders";
  static const String addReminder = "${baseUrl}reminders/add";

  // -------- DIET PLANNER --------
  static const String getDietPlan = "${baseUrl}diet";
  static const String updateDietPlan = "${baseUrl}diet/update";
}
