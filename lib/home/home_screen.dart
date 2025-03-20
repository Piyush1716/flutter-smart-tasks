import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todoapp/Task%20Pages/task_item.dart';
import 'package:todoapp/home/add_task_screen.dart';
import 'package:todoapp/home/category_selection_page.dart';
import 'package:todoapp/pages/loginpage.dart';
import 'package:todoapp/services/auth_services.dart';
import 'package:todoapp/services/task_services.dart';
import 'package:todoapp/theme/appcolor.dart';

class HomePage extends StatelessWidget {
  Stream<QuerySnapshot> getTasks(){
    final TaskServices taskServices = TaskServices();
    return taskServices.getTasks();
  }
  Future<void> logout(BuildContext context) async {
    final AuthServices authServices = AuthServices();
    await authServices.signout();
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: Text("Index", style: TextStyle(color: Colors.white)),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.menu, color: Colors.white),
          onPressed: ()=> showCategorySelection(context),
        ),
        actions: [
          Icon(Icons.person),
          SizedBox(width: 10),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: getTasks(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return _buildEmptyTaskUI();
          }
          return ListView(
            padding: EdgeInsets.all(16),
            children: snapshot.data!.docs.map((task) {
              var data = task.data() as Map<String, dynamic>;
              return TaskItem(data: data, );
            }).toList(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (context) => DraggableScrollableSheet(
              initialChildSize: 0.4,
              minChildSize: 0.2,
              maxChildSize: 0.9,
              expand: false,
              builder: (context, scrollController) {
                return AddTaskSheet(scrollController: scrollController);
              },
            ),
          );
        },
        backgroundColor: Appcolor.primary,
        child: Icon(Icons.add, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  Widget _buildEmptyTaskUI() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset("assets/svg/Checklist-rafiki 1.svg", height: 200),
          SizedBox(height: 20),
          Text(
            "What do you want to do today?",
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          SizedBox(height: 5),
          Text(
            "Tap + to add your tasks",
            style: TextStyle(fontSize: 14, color: Colors.white70),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavBar() {
    return BottomAppBar(
      shape: CircularNotchedRectangle(),
      notchMargin: 8.0,
      color: Colors.grey[900],
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                _buildNavItem(Icons.home, "Index", true),
                SizedBox(width: 30),
                _buildNavItem(Icons.calendar_today, "Calendar", false),
              ],
            ),
            Row(
              children: [
                _buildNavItem(Icons.access_time, "Focus", false),
                SizedBox(width: 30),
                _buildNavItem(Icons.person, "Profile", false),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, bool isActive) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: isActive ? Colors.white : Colors.white60),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: isActive ? Colors.white : Colors.white60,
          ),
        ),
      ],
    );
  }
}
