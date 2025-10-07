//this will be the event calendar that displays in app
//will hold the profile page for the app

/*
Your personal Info
maybe a bio
connections with a link to that page also
your events that you are going to 
settings which will link you to admin stuff so you can make events
links to social media
company info if you want to add it 
*/

import 'package:flutter/material.dart';
import 'drawer.dart';

class ConnectionsPage extends StatelessWidget {
  const ConnectionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calendar'),
      ),
      drawer: const MyDrawer(currentPage: PageType.connections),
      body: const Center(
        child: Text(
          'Profile Page Placeholder',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
