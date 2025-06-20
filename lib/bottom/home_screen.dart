import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required bool showSnackbar});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Image.asset('assets/CURA PET.png', height: 150, width: 150),
            const SizedBox(height: 20),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
                children: const [
                  DashboardCard(
                    title: 'Appointments',
                    icon: Icons.calendar_month,
                  ),
                  DashboardCard(
                    title: 'Health Timeline',
                    icon: Icons.health_and_safety,
                  ),
                  DashboardCard(title: 'Diet Planner', icon: Icons.fastfood),
                  DashboardCard(title: 'Reminders', icon: Icons.alarm),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DashboardCard extends StatelessWidget {
  final String title;
  final IconData icon;

  const DashboardCard({super.key, required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      color: Colors.teal.shade50,
      child: InkWell(
        onTap: () {}, // Set navigation or action here
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 50, color: Colors.teal),
              const SizedBox(height: 10),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
