//This page will serve as a way to search for events and add them to your calendar
//I have to think conceptially of the flow of this a bit more

import 'package:flutter/material.dart';
import 'drawer.dart';

class FindEventsPage extends StatelessWidget {
  const FindEventsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Find Events'),
      ),
      drawer: const MyDrawer(currentPage: PageType.findEvents),
      body: const Center(
        child: Text(
          'Find/Add Events Placeholder',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
