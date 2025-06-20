import 'package:flutter/material.dart';

class TabButton extends StatelessWidget {
  final int selectedTab;
  final Function(int) onTabSelected;

  const TabButton({
    Key? key,
    required this.selectedTab,
    required this.onTabSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tabs = ['Reminders', 'Tips', 'Challenges'];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(tabs.length, (index) {
        final isSelected = index == selectedTab;
        return GestureDetector(
          onTap: () => onTabSelected(index),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: isSelected ? Colors.green : Colors.grey[200],
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              tabs[index],
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.black87,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      }),
    );
  }
}
