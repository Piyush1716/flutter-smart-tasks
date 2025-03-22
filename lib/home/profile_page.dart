import 'package:flutter/material.dart';
import 'package:todoapp/home/add_task_screen.dart';
import 'package:todoapp/home/home_screen.dart';
import 'package:todoapp/services/task_services.dart';
import 'package:todoapp/services/auth_services.dart';
import 'package:todoapp/slider%20and%20start/onboarding_screen.dart';
import 'package:todoapp/theme/appcolor.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<ProfilePage> createState() => _ProfilePage();
}

class _ProfilePage extends State<ProfilePage> {
  int inComplete_cnt = 0 , completed_cnt = 0;
  String user_name = '';
  final TaskServices taskServices = TaskServices();
  final AuthServices authServices = AuthServices();
  @override
  void initState() {
    super.initState();
    getTaskCounts();
    getuserdata();
  }
  getTaskCounts() async {
    inComplete_cnt = await taskServices.getInCompletedTasksCount();
    completed_cnt = await taskServices.getCompletedTasksCount();
    setState(() {
      
    });
  }
  getuserdata() async {
    final userdata = await authServices.getUserData();
    if(userdata!=null) {
      user_name = userdata['name'];
    }
    setState(() {
      
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 25),
              Text("Profile", style: TextStyle(color: Colors.white, fontSize: 20)),
              const SizedBox(height: 20),
              Icon(Icons.person, size: 50,color: Colors.white,),
              const SizedBox(height: 10),
              Text(
                user_name,
                style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _taskStatusCard(inComplete_cnt ,' Task left'),
                  const SizedBox(width: 10),
                  _taskStatusCard(completed_cnt ,' Task done'),
                ],
              ),
              SizedBox(height: 30),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                  children: [
                    _settingsOption(Icons.settings, 'App Settings'),
                    _settingsOption(Icons.person, 'Change account name'),
                    _settingsOption(Icons.lock, 'Change account password'),
                    _settingsOption(Icons.image, 'Change account Image'),
                    _settingsOption(Icons.info, 'About US'),
                    _settingsOption(Icons.help, 'FAQ'),
                    _settingsOption(Icons.feedback, 'Help & Feedback'),
                    _settingsOption(Icons.support, 'Support US'),
                    TextButton.icon(
                      onPressed: () {
                        final AuthServices auth = AuthServices();
                        auth.signout();
                        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>OnboardingScreen()), (route) => false);
                      },
                      icon: const Icon(Icons.logout, color: Colors.red),
                      label: const Text('Log out',
                          style: TextStyle(color: Colors.red)),
                    ),
                  ],
                                ),
                ),
              ), 
              SizedBox(height: 40),
            ],
          ),
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

  Widget _buildBottomNavBar() {
    return BottomAppBar(
      shape: CircularNotchedRectangle(),
      notchMargin: 4.0,
      color: Colors.grey[900],
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 10,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                _buildNavItem(Icons.home, "Index", false, 
                  (){
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));
                  }
                ),
                SizedBox(width: 30),
                _buildNavItem(Icons.calendar_today, "Calendar", false, 
                  (){
                    // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));
                  }
                ),
              ],
            ),
            Row(
              children: [
                _buildNavItem(Icons.access_time, "Focus", false, 
                  (){
                    // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));
                  }
                ),
                SizedBox(width: 30),
                _buildNavItem(Icons.person, "Profile", true, 
                  (){
                    // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));
                  }
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(
      IconData icon, String label, bool isActive, void Function() ontap) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: Icon(icon,
              size: 24, color: isActive ? Colors.white : Colors.white60),
          onPressed: ontap,
        ),
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

  Widget _taskStatusCard(int cnt, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        cnt.toString()+text,
        style: const TextStyle(color: Colors.white, fontSize: 16),
      ),
    );
  }

  Widget _settingsOption(IconData icon, String title) {
    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: Text(
        title,
        style: const TextStyle(color: Colors.white, fontSize: 16),
      ),
      trailing: const Icon(Icons.arrow_forward_ios, color: Colors.white, size: 16),
      onTap: () {},
    );
  }
  
}
