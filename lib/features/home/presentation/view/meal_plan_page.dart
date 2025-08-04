import 'package:flutter/material.dart';

class MealPlanPage extends StatelessWidget {
  const MealPlanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meal Planning'),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Meal Plan for Bella',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Card(
              child: ListTile(
                leading: const Icon(Icons.breakfast_dining),
                title: const Text('Breakfast'),
                subtitle: const Text('8:00 AM - Dry Food & Water'),
              ),
            ),
            const SizedBox(height: 10),
            Card(
              child: ListTile(
                leading: const Icon(Icons.lunch_dining),
                title: const Text('Lunch'),
                subtitle: const Text('1:00 PM - Chicken & Rice'),
              ),
            ),
            const SizedBox(height: 10),
            Card(
              child: ListTile(
                leading: const Icon(Icons.dinner_dining),
                title: const Text('Dinner'),
                subtitle: const Text('7:00 PM - Wet Food'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
