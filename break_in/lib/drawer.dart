//This is the file that controls the main navigation drawer
//Remains constant since it will be present on all pages for easy navigation in the event the user becomes lost

//Going to edit this so I am adding some notes
/*
This will need to have a link to your profile, find/add an event, connections (which will show a full list), full calendar
*/

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:firebase_auth/firebase_auth.dart';

//set up constant values for readiblity in navigation
enum PageType {
  home,
  profile,
  connections,
  calendar,
  findEvents,
  logout
}

class MyDrawer extends StatelessWidget {

  //require that you use the page type for each page to be able to navigate
  final PageType currentPage;
  const MyDrawer({super.key, required this.currentPage});

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
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () {
              currentPage == PageType.home
                  ? Navigator.pop(context)
                  : context.go('/home');
            },
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Profile'),
            onTap: () {
              currentPage == PageType.profile
                  ? Navigator.pop(context)
                  : context.go('/profile');
            },
          ),
            ListTile(
            title: Text('Connections'),
            onTap: () {
              currentPage == PageType.connections
                  ? Navigator.pop(context)
                  : context.go('/connections');
            },
          ),
          ListTile(
            title: Text('Calendar'),
            onTap: () {
              currentPage == PageType.calendar
                  ? Navigator.pop(context)
                  : context.go('/calendar');
            },
          ),
          ListTile(
            title: Text('Find Event'),
            onTap: () {
              currentPage == PageType.findEvents
                  ? Navigator.pop(context)
                  : context.go('/findEvents');
            },
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Logout'),
            onTap: () async {
              final confirmed = await showDialog<bool>(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('Log out?'),
                  content: Text('Are you sure you want to log out?'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context, false),
                      child: Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context, true),
                      child: Text('Log out'),
                    ),
                  ],
                ),
              );

              if (confirmed == true) {
                // Firebase example
                await FirebaseAuth.instance.signOut();

                // Navigate to login screen
                context.go('/startscreen');
              }
            },
          ),
        ],
      ),
    );
  }
}
