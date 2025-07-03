import 'package:flutter/material.dart';

class AppointmentView extends StatelessWidget {
  AppointmentView({Key? key}) : super(key: key);

  final List<Map<String, String>> appointments = [
    {
      'petName': 'Bella',
      'service': 'Vaccination',
      'date': '2025-07-01',
      'time': '10:00 AM',
    },
    {
      'petName': 'Max',
      'service': 'Grooming',
      'date': '2025-07-02',
      'time': '2:00 PM',
    },
    {
      'petName': 'Luna',
      'service': 'Vet Checkup',
      'date': '2025-07-10',
      'time': '11:30 AM',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Appointments'),
        backgroundColor: Colors.green,
        centerTitle: true,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: appointments.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final appt = appointments[index];
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 3,
            child: ListTile(
              leading: const Icon(Icons.event_available, color: Colors.green),
              title: Text(
                '${appt['petName']} - ${appt['service']}',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text('${appt['date']} at ${appt['time']}'),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                // TODO: Navigate to appointment details or edit page
              },
            ),
          );
        },
      ),
    );
  }
}
