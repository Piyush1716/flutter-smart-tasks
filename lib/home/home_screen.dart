import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todoapp/Task%20Pages/task_item.dart';
import 'package:todoapp/home/add_task_screen.dart';
import 'package:todoapp/home/category_selection_page.dart';
import 'package:todoapp/sign%20in%20up/loginpage.dart';
import 'package:todoapp/home/profile_page.dart';
import 'package:todoapp/services/auth_services.dart';
import 'package:todoapp/services/task_services.dart';
import 'package:todoapp/theme/appcolor.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  bool _completed = false;
  Map<String, dynamic>? user;
  Future<void> getUserDetail() async {
    final AuthServices auth = AuthServices();
    user = await auth.getUserData();
  }
  Stream<QuerySnapshot> getTasks(){
    final TaskServices taskServices = TaskServices();
    return taskServices.getTaskByFilter(_completed); // based on selected return completed or incompleted tasks.
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _dropDown((bool newval){
            setState(() {
              _completed = newval;
            });
            // we have used call back function bacauseif we pass the _completed 
            // it will not passed by reference so it will not changed so.. 
          }),
          Expanded(
            child: StreamBuilder(
              stream: getTasks(),
              builder: (context, snapshot){
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return _buildEmptyTaskUI();
                }
                return _buildTasks(snapshot);
              },
            ),
          )
        ],
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
        shape: CircleBorder(),
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
      notchMargin: 4.0,
      color: Colors.grey[900],
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10,),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                _buildNavItem(Icons.home, "Index", true, () {
                  // Navigator.pushReplacement(context,
                  //     MaterialPageRoute(builder: (context) => HomePage()));
                }),
                SizedBox(width: 30),
                _buildNavItem(Icons.calendar_today, "Calendar", false, () {
                  // Navigator.pushReplacement(context,
                  //     MaterialPageRoute(builder: (context) => HomePage()));
                }),
              ],
            ),
            Row(
              children: [
                _buildNavItem(Icons.access_time, "Focus", false, () {
                  // Navigator.pushReplacement(context,
                  //     MaterialPageRoute(builder: (context) => HomePage()));
                }),
                SizedBox(width: 30),
                _buildNavItem(Icons.person, "Profile", false, () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => ProfilePage()));
                }),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, bool isActive, void Function() ontap) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(icon: Icon(icon,size: 24, color: isActive ? Colors.white : Colors.white60), onPressed: ontap,),
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            color: isActive ? Colors.white : Colors.white60,
          ),
        ),
      ],
    );
  }

  Widget _buildTasks(AsyncSnapshot<QuerySnapshot> snapshot){
    return ListView(
      padding: EdgeInsets.all(16),
      children: snapshot.data!.docs.map((task) {
        var data = task.data() as Map<String, dynamic>;
        return TaskItem(
          data: data,
        );
      }).toList(),
    );
  }

  Widget _dropDown(void Function(bool) change_filter){
    return Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
            margin: EdgeInsets.symmetric(horizontal: 16,),
            decoration: BoxDecoration(
              color: Colors.grey[800], // Match image style
              borderRadius: BorderRadius.circular(6),
            ),
            child: DropdownButton<bool>(
              borderRadius: BorderRadius.circular(15),
              value: _completed,
              dropdownColor: Appcolor.secodary, // Dark dropdown
              underline: SizedBox(), // Hide default underline
              icon: Icon(Icons.keyboard_arrow_down, color: Colors.white),
              style: TextStyle(color: Colors.white,),
              items: [true, false].map((bool value) {
                return DropdownMenuItem<bool>(
                  value: value,
                  child: Text(value ? 'Completed' : 'Incomplete'),
                );
              }).toList(),
              onChanged: (bool? newval){
                if(newval != null){
                  change_filter(newval);
                }
              }
            ),
          );
  }
}