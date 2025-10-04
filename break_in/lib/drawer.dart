//This is the file that controls the main navigation drawer
//Remains constant since it will be present on all pages for easy navigation in the event the user becomes lost

//Going to edit this so I am adding some notes
/*
This will need to have a link to your profile, find/add an event, connections (which will show a full list), full calendar
*/

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key, required this.currentPage});

  final int currentPage;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.orange,
            ),
            child: Text('Drawer Header'),
          ),
          ListTile(
            title: const Text('Home'),
            onTap: () {
              // Update the state of the app.
              currentPage == 1 ? Navigator.pop(context) : context.go('/home');
            },
          ),
          ListTile(
            title: const Text('Profile'),
            onTap: () {
              // Update the state of the app.
              currentPage == 2 ? Navigator.pop(context) : context.go('/profile');
            },
          ),
          //ListTile(
          // title: const Text('Search'),
          //  onTap: () {
          //    // Update the state of the app.
          //    currentPage == 3 ? Navigator.pop(context) : context.go('/search');
          //  },
         //  ),
          ListTile(
            title: const Text('Help'),
            onTap: () {
              // Update the state of the app.
              currentPage == 4 ? Navigator.pop(context) : context.go('/help');
            },
          ),
        ],
      ),
    );
  }
}
