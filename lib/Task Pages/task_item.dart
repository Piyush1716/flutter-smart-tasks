import 'package:flutter/material.dart';
import 'package:todoapp/Task%20Pages/TaskDetailsPage.dart';
import 'package:todoapp/theme/appcolor.dart';

class TaskItem extends StatelessWidget {
  final Map<String, dynamic> data;

  const TaskItem({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => TaskDetailsPage(data: data)),
        );
      },
      child: Card(
        color: Appcolor.secodary,
        margin: const EdgeInsets.symmetric(vertical: 8),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                data['title'] ?? 'No Title',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                "Today At ${data['dueTime'] ?? 'N/A'}",
                style: const TextStyle(fontSize: 14, color: Colors.white70),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Chip(
                    backgroundColor: Colors.blueAccent,
                    label: Text(
                      data['category'] ?? 'General',
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  const Icon(Icons.flag, color: Colors.white70),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
