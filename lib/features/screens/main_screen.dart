import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tasky/features/screens/complete_screen.dart';
import 'package:tasky/features/screens/home_screen.dart';
import 'package:tasky/features/screens/profile_screen.dart';
import 'package:tasky/features/screens/task_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final List<Widget> _screens = <Widget>[
    HomeScreen(),
    TasksScreen(),
    CompleteScreen(),
    ProfileScreen(),
  ];
  int _currentindex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentindex,
        onTap: (int index) {
          setState(() {
            _currentindex = index;
          });
        },
        type: BottomNavigationBarType.fixed,

        items: [
          //fact_check
          //task_alt
          //article_outlined
          BottomNavigationBarItem(
            icon: _buildSvgPicture('assets/svg/home.svg', 0),

            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: _buildSvgPicture('assets/svg/todo.svg', 1),

            label: 'To Do',
          ),
          BottomNavigationBarItem(
            icon: _buildSvgPicture('assets/svg/completed.svg', 2),

            label: 'Completed',
          ),
          BottomNavigationBarItem(
            icon: _buildSvgPicture('assets/svg/profile.svg', 3),

            label: 'Profile',
          ),
        ],
      ),
      body: SafeArea(child: _screens[_currentindex]),
    );
  }

  SvgPicture _buildSvgPicture(String svgAssetPath, int index) =>
      SvgPicture.asset(
        svgAssetPath,
        colorFilter: ColorFilter.mode(
          _currentindex == index ? Color(0xff15B86C) : Color(0xffC6C6C6),
          BlendMode.srcIn,
        ),
      );
}

/**              // CustomElevatedButton(
              //   onPressed: () async {
              //     //validate field
              //     if (_formKeytask.currentState?.validate() ?? false) {
              //       //save data
              //       //check by key=>'tasks'->String
              //       final taskjson = PreferencesManager().getString('tasks');
              //       // initialize list of dynami
              //       List<dynamic> listtasks = []; //List<Map<String, dynamic<>>
              //       //it is not empty
              //       if (taskjson != null) {
              //         //converted to list
              //         listtasks = jsonDecode(taskjson);
              //       }
              //       final random = Random();

              //       //listtasks.length =1=>1+1
              //       TaskModel model = TaskModel(
              //         id: random.nextInt(1000), // Generate a random ID
              //         taskname: taskNameController.text,
              //         taskdescription: taskDescriptionController.text,
              //         isHighPriority: isHighPriority,
              //       );
              //       //list of Map
              //       listtasks.add(model.toJson());
              //       //convert to String
              //       final taskencode = jsonEncode(listtasks);

              //       await PreferencesManager().setString('tasks', taskencode);

              //       Navigator.of(context).pop(true);
              //     }
              //     _formKeytask.currentState!.validate();
              //   },
              //   icon: Icon(Icons.add),
              //   label: Text(
              //     'Add Task',
              //     style: Theme.of(context).textTheme.labelLarge,
              //   ),
              // ), */