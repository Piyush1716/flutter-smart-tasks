import 'package:flutter/material.dart';
import 'package:todoapp/Task%20Pages/TaskDetailsPage.dart';
import 'package:todoapp/services/task_services.dart';
import 'package:todoapp/theme/appcolor.dart';
import 'package:todoapp/ui%20helper/TimeStamp_to_date.dart';
import 'package:todoapp/ui%20helper/btn.dart';

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
      onLongPress: (){
        _showConfirmBox(context, data['taskId']);
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
                "DueDate ${onlyDate(data['dueDate'])}",
                style: const TextStyle(fontSize: 14, color: Colors.white70),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Chip(
                    backgroundColor: Colors.blueAccent,
                    label: Text(
                      data['category'] == '' ? 'General' : data['category'],
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

  void _showConfirmBox(BuildContext context, String taskId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Appcolor.secodary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        title: Text('Complete Task',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        content: Text(
          'Do you want to mark this Task as Completed?',
          style: TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel', style: TextStyle(color: Appcolor.primary)),
          ),
          Btn(
            ontap: () {
              final TaskServices _taskServices = TaskServices();
              _taskServices.markAsCompleted(taskId);
              Navigator.pop(context);
            },
            text: 'Complete',
            width: 100,
          ),
        ],
      ),
    );
  }

}
