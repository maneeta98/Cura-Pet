import 'package:cura_pet/features/home/view_model/home_state.dart';
import 'package:cura_pet/features/home/view_model/home_view_model.dart';
import 'package:cura_pet/shared/widgets/tab_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeView extends StatelessWidget {
  HomeView({Key? key}) : super(key: key);

  final List<Map<String, dynamic>> featuredPets = [
    {
      'name': 'Bella',
      'breed': 'Golden Retriever',
      'age': 3,
      'imageUrl':
          'https://www.vidavetcare.com/wp-content/uploads/sites/234/2022/04/golden-retriever-dog-breed-info.jpeg',
    },
    {
      'name': 'Max',
      'breed': 'Bulldog',
      'age': 5,
      'imageUrl':
          'https://www.zigly.com/media/mageplaza/blog/post/b/u/bull_dog_101.png',
    },
    {
      'name': 'Luna',
      'breed': 'Siamese Cat',
      'age': 2,
      'imageUrl':
          'https://images.wagwalkingweb.com/media/daily_wag/blog_articles/hero/1678934108.5188236/everything-you-need-to-know-about-siamese-cats.png',
    },
    {
      'name': 'Charlie',
      'breed': 'Beagle',
      'age': 4,
      'imageUrl':
          'https://lirp.cdn-website.com/e5dbb6fb/dms3rep/multi/opt/coy-beagle-puppy-234x316.dm.edit_l8ICpI-400w.jpg',
    },
  ];

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

  Widget buildBottomContent(int selectedTab) {
    switch (selectedTab) {
      case 0:
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
                    subtitle: Text(
                      '${reminder['date']} at ${reminder['time']}',
                    ),
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
      case 1:
        return Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          margin: const EdgeInsets.symmetric(vertical: 6),
          child: const Padding(
            padding: EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Pet Care Tips",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                SizedBox(height: 10),
                Text(
                  "• Provide fresh water daily\n• Feed a balanced diet\n• Schedule regular vet checkups\n• Daily exercise and playtime",
                ),
              ],
            ),
          ),
        );
      case 2:
        return Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          margin: const EdgeInsets.symmetric(vertical: 6),
          child: const Padding(
            padding: EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Challenges",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                SizedBox(height: 10),
                Text(
                  "• Walk your dog daily for 30 minutes\n• Try a new training trick weekly\n• Track your pet’s weight weekly",
                ),
              ],
            ),
          ),
        );
      default:
        return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeViewModel, HomeState>(
      builder: (context, state) {
        final selectedTab = state.selectedIndex;

        return Scaffold(
          appBar: AppBar(
            title: const Text('CuraPet'),
            backgroundColor: Colors.green,
            centerTitle: true,
            actions: [
              IconButton(
                icon: const Icon(Icons.logout),
                tooltip: 'Logout',
                onPressed: () {
                  context.read<HomeViewModel>().logout(context);
                },
              ),
            ],
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Hello, Aman!",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      children: const [
                        Icon(Icons.pets, color: Colors.green),
                        SizedBox(width: 4),
                        Text(
                          "Your pets' dashboard",
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ],
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
                  "Explore More",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                TabButton(
                  selectedTab: selectedTab,
                  onTabSelected: (index) {
                    context.read<HomeViewModel>().onTabTapped(index);
                  },
                ),
                const SizedBox(height: 24),
                buildBottomContent(selectedTab),
                const SizedBox(height: 40),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      // Navigate to Add New Pet
                    },
                    icon: const Icon(Icons.add, color: Colors.white),
                    label: const Text(
                      "Add New Pet",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        );
      },
    );
  }
}
