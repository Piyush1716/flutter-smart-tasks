import 'package:flutter/material.dart';
import 'package:todoapp/services/task_services.dart';
import 'package:todoapp/theme/appcolor.dart';

class AddTaskSheet extends StatefulWidget {
  final ScrollController scrollController;

  const AddTaskSheet({Key? key, required this.scrollController})
      : super(key: key);

  @override
  _AddTaskSheetState createState() => _AddTaskSheetState();
}

class _AddTaskSheetState extends State<AddTaskSheet> {
  bool showDescription = false;
  final TextEditingController taskController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  DateTime? selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            primaryColor: Appcolor.primary, // Header background color
            hintColor: Colors.white, // Year selection text color
            colorScheme: ColorScheme.dark(
              primary: Appcolor.primary, // Highlight color
              onPrimary: Colors.white, // Text color on selected date
              surface: Colors.grey[900]!, // Dialog background color
              onSurface: Colors.white, // Text color
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Appcolor.primary, // Buttons color
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("Add Task",
              style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          TextField(
            controller: taskController,
            decoration: InputDecoration(
              hintText: "Task Name",
              hintStyle: TextStyle(color: Colors.white60),
              filled: true,
              fillColor: Colors.white10,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none),
            ),
            style: TextStyle(color: Colors.white),
          ),
          SizedBox(height: 10),
          if (showDescription) ...[
            Text("Description", style: TextStyle(color: Colors.white60)),
            SizedBox(height: 5),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(
                hintText: "Enter description...",
                hintStyle: TextStyle(color: Colors.white60),
                filled: true,
                fillColor: Colors.white10,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none),
              ),
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 10),
          ],
          if (selectedDate != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Text(
                "Selected Date: ${selectedDate!.toLocal()}".split(' ')[0],
                style: TextStyle(color: Colors.white60),
              ),
            ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                  icon: Icon(Icons.timer_outlined, color: Colors.white70),
                  onPressed: () => _selectDate(context)),
              IconButton(
                  icon: Icon(Icons.description_outlined, color: Colors.white70),
                  onPressed: () {
                    setState(() {
                      showDescription = !showDescription;
                    });
                  }),
              IconButton(
                  icon: Icon(Icons.flag_outlined, color: Colors.white70),
                  onPressed: () {}),
              Spacer(),
              ElevatedButton(
                onPressed: () {
                  addTask(selectedDate, taskController.text, descriptionController.text);
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Appcolor.primary,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                child: Text("Add", style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }
  
  void addTask(DateTime? dueDate, String title, description) {
    final TaskServices taskServices = TaskServices();
    try{
      taskServices.addTask(title, description, dueDate);
    }
    catch(e){
      print(e);
    }
  }
}
