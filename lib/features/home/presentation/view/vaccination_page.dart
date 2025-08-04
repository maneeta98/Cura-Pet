import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class VaccinationPage extends StatefulWidget {
  const VaccinationPage({super.key});

  @override
  State<VaccinationPage> createState() => _VaccinationPageState();
}

class _VaccinationPageState extends State<VaccinationPage> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  final List<Map<String, String>> _vaccinations = [
    {
      'title': 'Rabies Vaccine - Bella',
      'date': '2025-08-15',
      'time': '11:00 AM',
    },
  ];

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _timeController.dispose();
    super.dispose();
  }

  void _addItem() {
    if (_selectedDay == null ||
        _titleController.text.isEmpty ||
        _timeController.text.isEmpty)
      return;

    setState(() {
      _vaccinations.add({
        'title': _titleController.text,
        'date': _selectedDay!.toIso8601String().split('T')[0],
        'time': _timeController.text,
      });
    });

    _titleController.clear();
    _timeController.clear();
    Navigator.pop(context);
  }

  void _showAddDialog() {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text('Add Vaccination'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Title'),
              ),
              TextField(
                controller: _timeController,
                decoration: const InputDecoration(labelText: 'Time'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: Navigator.of(context).pop,
              child: const Text('Cancel'),
            ),
            ElevatedButton(onPressed: _addItem, child: const Text('Add')),
          ],
        );
      },
    );
  }

  void _editItem(int index) {
    final item = _vaccinations[index];
    _titleController.text = item['title']!;
    _timeController.text = item['time']!;
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text('Edit Vaccination'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Title'),
              ),
              TextField(
                controller: _timeController,
                decoration: const InputDecoration(labelText: 'Time'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: Navigator.of(context).pop,
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _vaccinations[index] = {
                    'title': _titleController.text,
                    'date': item['date']!,
                    'time': _timeController.text,
                  };
                });
                _titleController.clear();
                _timeController.clear();
                Navigator.pop(context);
              },
              child: const Text('Update'),
            ),
          ],
        );
      },
    );
  }

  void _deleteItem(int index) {
    setState(() {
      _vaccinations.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    final selectedDate = _selectedDay?.toIso8601String().split('T')[0];
    final filtered =
        selectedDate == null
            ? _vaccinations
            : _vaccinations.where((a) => a['date'] == selectedDate).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Vaccination Schedule'),
        backgroundColor: Colors.green,
      ),
      body: Column(
        children: [
          TableCalendar(
            firstDay: DateTime.utc(2020),
            lastDay: DateTime.utc(2030),
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            onDaySelected: (selected, focused) {
              setState(() {
                _selectedDay = selected;
                _focusedDay = focused;
              });
            },
            calendarStyle: const CalendarStyle(
              todayDecoration: BoxDecoration(
                color: Colors.green,
                shape: BoxShape.circle,
              ),
              selectedDecoration: BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.circle,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: filtered.length,
              itemBuilder: (context, index) {
                final appt = filtered[index];
                return Card(
                  child: ListTile(
                    leading: const Icon(Icons.vaccines),
                    title: Text(appt['title']!),
                    subtitle: Text(
                      'Date: ${appt['date']}\nTime: ${appt['time']}',
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.blue),
                          onPressed: () => _editItem(index),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _deleteItem(index),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddDialog,
        backgroundColor: Colors.green,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
