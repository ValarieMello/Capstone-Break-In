//willbecome the homescreen of the app.

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'drawer.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Break>In Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              //TODO: Hook up logout logic later
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Logout pressed')),
              );
            },
          )
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Welcome!',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Card(
            child: ListTile(
              leading: const Icon(Icons.event),
              title: const Text('My Schedule'),
              subtitle: const Text('View or manage your event schedule'),
              onTap: () {
                // TODO: Navigate to schedule screen
              },
            ),
          ),
          const SizedBox(height: 8),
          Card(
            child: ListTile(
              leading: const Icon(Icons.people),
              title: const Text('Networking'),
              subtitle: const Text('Connect with attendees'),
              onTap: () {
                // TODO: Navigate to networking screen
              },
            ),
          ),
          const SizedBox(height: 8),
          Card(
            child: ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              subtitle: const Text('Manage app preferences'),
              onTap: () {
                // TODO: Navigate to settings screen
              },
            ),
          ),
        ],
      ),
    );
  }
}
