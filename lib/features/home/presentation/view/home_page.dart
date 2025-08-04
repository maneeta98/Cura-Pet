import 'dart:async';
import 'dart:math';
import 'package:cura_pet/features/home/presentation/view/appointment_booking_page.dart';
import 'package:cura_pet/features/home/presentation/view/meal_plan_page.dart';
import 'package:cura_pet/features/home/presentation/view/vaccination_page.dart';
import 'package:cura_pet/features/user/presentation/view/register_view.dart';
import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  StreamSubscription? _accelerometerSubscription;
  double _shakeThreshold = 15.0; // Adjust sensitivity

  // For shake detection
  double lastX = 0, lastY = 0, lastZ = 0;
  int lastShakeTime = 0;

  @override
  void initState() {
    super.initState();
    _listenToShake();
  }

  @override
  void dispose() {
    _accelerometerSubscription?.cancel();
    super.dispose();
  }

  void _listenToShake() {
    _accelerometerSubscription = accelerometerEvents.listen((event) {
      double dx = event.x - lastX;
      double dy = event.y - lastY;
      double dz = event.z - lastZ;

      double speed = sqrt(dx * dx + dy * dy + dz * dz);

      int currentTime = DateTime.now().millisecondsSinceEpoch;
      if (speed > _shakeThreshold && (currentTime - lastShakeTime) > 1000) {
        lastShakeTime = currentTime;
        _onShakeLogout();
      }

      lastX = event.x;
      lastY = event.y;
      lastZ = event.z;
    });
  }

  void _onShakeLogout() {
    // Show a snack bar
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Shake detected! Logging out..."),
        backgroundColor: Colors.red,
      ),
    );

    // Navigate back to Register Page
    Future.delayed(const Duration(milliseconds: 700), () {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const RegisterPage()),
        (route) => false,
      );
    });
  }

  // Featured pets (only Bella)
  final List<Map<String, dynamic>> featuredPets = [
    {
      'name': 'Bella',
      'breed': 'Golden Retriever',
      'age': 3,
      'imageUrl':
          'https://www.vidavetcare.com/wp-content/uploads/sites/234/2022/04/golden-retriever-dog-breed-info.jpeg',
    },
  ];

  // Upcoming reminders
  final List<Map<String, dynamic>> upcomingReminders = [
    {
      'title': 'Vaccination for Bella',
      'date': 'Thu, Jul 1',
      'time': '10:00 AM',
      'status': 'Upcoming',
    },
    {
      'title': 'Grooming for Max',
      'date': 'Fri, Jul 2',
      'time': '2:00 PM',
      'status': 'Upcoming',
    },
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const MealPlanPage()),
      );
    } else if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const AppointmentBookingPage()),
      );
    } else if (index == 3) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const VaccinationPage()),
      );
    }
  }

  Widget buildUpcomingReminders() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children:
          upcomingReminders.map((reminder) {
            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              margin: const EdgeInsets.symmetric(vertical: 6),
              child: ListTile(
                title: Text(
                  reminder['title'],
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text('${reminder['date']} at ${reminder['time']}'),
                leading: const Icon(
                  Icons.notifications_active,
                  color: Colors.green,
                ),
                trailing: Text(
                  reminder['status'],
                  style: TextStyle(
                    color:
                        reminder['status'] == 'Upcoming'
                            ? Colors.green
                            : Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            );
          }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cura Pet'),
        backgroundColor: Colors.green,
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            tooltip: 'Settings',
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Logout',
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const RegisterPage()),
                (route) => false,
              );
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          // Center image in the background
          Center(
            child: Opacity(
              opacity: 0.25,
              child: Image.asset(
                'assets/homE.jpeg',
                fit: BoxFit.contain,
                width: 250,
                height: 250,
              ),
            ),
          ),

          // Foreground: existing scrollable content
          SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Hello, Manita!",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),

                const Text(
                  "Featured Pets",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  height: 180,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: featuredPets.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 12),
                    itemBuilder: (context, index) {
                      final pet = featuredPets[index];
                      return SizedBox(
                        width: 160,
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 4,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(12),
                                ),
                                child: Image.network(
                                  pet['imageUrl'],
                                  height: 100,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      pet['name'],
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                    Text(
                                      pet['breed'],
                                      style: const TextStyle(
                                        color: Colors.grey,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      'Age: ${pet['age']} years',
                                      style: const TextStyle(fontSize: 12),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                  "Upcoming Reminders",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                buildUpcomingReminders(),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        backgroundColor: Colors.green,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.fastfood),
            label: 'Meal Plan',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Appointments',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.vaccines),
            label: 'Vaccination',
          ),
        ],
      ),
    );
  }
}
