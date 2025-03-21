import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:todoapp/services/task_services.dart';
import 'package:todoapp/theme/appcolor.dart';
import 'package:todoapp/ui%20helper/TimeStamp_to_date.dart';
import 'package:todoapp/ui%20helper/btn.dart';

class TaskDetailsPage extends StatelessWidget {
  final Map<String, dynamic> data;
  TaskDetailsPage({required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(data['title'],
            style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            icon: Icon(LucideIcons.refreshCcw, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  data['description'],
                  style: TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                      fontStyle: FontStyle.italic),
                ),
                Spacer(),
                IconButton(onPressed: (){}, icon: Icon(Icons.edit, ))
              ],
            ),
            SizedBox(height: 20),
            TaskDetailItem(
                icon: LucideIcons.clock,
                label: 'Task Time',
                value: timeAndDate(data['createdAt'])),
            TaskDetailItem(
                icon: LucideIcons.mapPin,
                label: 'Task Category',
                value: data['category']==''? 'General' : data['category'],
                isBadge: true),
            TaskDetailItem(
                icon: LucideIcons.flag,
                label: 'Task Priority',
                value: data['priority'] == '' ? 'Default' : data['priority'],
                isBadge: true),
            TaskDetailItem(
                icon: LucideIcons.list,
                label: 'Sub - Task',
                value: 'Add Sub - Task',
                isButton: true),
            TaskDetailItem(
                icon: LucideIcons.bookMarked,
                label: 'Completed',
                value: data['isCompleted'] ? 'Completed' : 'Not Completed',),
            SizedBox(height: 20),
            Divider(color: Appcolor.secodary, thickness: 1),
            SizedBox(height: 10),
            Center(
              child: TextButton(
                onPressed: () {_showDeleteConfirmation(context, data['taskId']);},
                style: TextButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  backgroundColor: Colors.red.withOpacity(0.2),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(LucideIcons.trash, color: Colors.red),
                    SizedBox(width: 8),
                    Text('Delete Task',
                        style: TextStyle(
                            color: Colors.red,
                            fontSize: 16,
                            fontWeight: FontWeight.w500)),
                  ],
                ),
              ),
            ),
            Spacer(),
            SizedBox(
              width: double.infinity,
              child: Btn(ontap: (){}, text: 'Edit Task')
            ),
          ],
        ),
      ),
    );
  }


  void _showDeleteConfirmation(BuildContext context, String taskId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Appcolor.secodary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        title: Text('Delete Task',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        content: Text(
          'Are you sure you want to delete this task?\nTask title: Do Math Homework',
          style: TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel', style: TextStyle(color: Appcolor.primary)),
          ),
          Btn(
            ontap: () {
              final TaskServices taskServices = TaskServices();
              taskServices.deleteTask(taskId, context);
            },
            text: 'Delete',
            width: 100,
          ),
        ],
      ),
    );
  }

}

class TaskDetailItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final bool isBadge;
  final bool isButton;

  const TaskDetailItem({
    required this.icon,
    required this.label,
    required this.value,
    this.isBadge = false,
    this.isButton = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.white, size: 24),
          SizedBox(width: 12),
          Text('$label : ',
              style: TextStyle(
                  color: Colors.white70,
                  fontSize: 18,
                  fontWeight: FontWeight.w500)),
          Spacer(),
          isBadge
              ? Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Appcolor.secodary,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(value,
                      style: TextStyle(color: Colors.white, fontSize: 16)),
                )
              : isButton
                  ? TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(
                        backgroundColor: Appcolor.secodary,
                        padding:
                            EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                      ),
                      child: Text(value,
                          style: TextStyle(color: Colors.white, fontSize: 16)),
                    )
                  : Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Appcolor.secodary,
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    child: Text(value,
                        style: TextStyle(color: Colors.white, fontSize: 16)),
                  ),
        ],
      ),
    );
  }
}
