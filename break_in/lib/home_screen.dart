//willbecome the homescreen of the app.

/*
how this page is going to work/look it is going to have a weekly schedule at the top
then it will show the whole day outlined
then the bottom bar will have a home, a giant plus, full calendar button

if you click on an event inside the whole day it will pop up and show you all the details of that event

if you hit that big plus it will have a box pop up with two options
1: add a connection link to add in info
2: edit your schedule link to page to edit your schedule

If you click the house it will reset to the current day

if you click the full calendar it will link you to the full calendar for the "month"
*/

//packages
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'drawer.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
    title: Text('Break>In'),
        actions: [
          Builder(
            builder: (context) => IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openEndDrawer();
              },
            ),
          ),
        ],
      ),

      // Use your custom drawer here on the right side (endDrawer)
      endDrawer: MyDrawer(currentPage: PageType.home),
      body: Column(
        children: [
          // My Week Widget
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              height: 100,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.lightBlue.shade100,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Text(
                  'My Week Widget',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ),

          // My Day Widget (Big)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Container(
              height: 350,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.orange.shade100,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Text(
                  'My Day Widget',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),

          Spacer(), // Push the options bar to the bottom

          // Options Bar
          Container(
            padding: EdgeInsets.symmetric(horizontal: 24),
            height: 80,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  blurRadius: 4,
                  color: Colors.grey.withOpacity(0.3),
                  offset: Offset(0, -2),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Home Button
                IconButton(
                  icon: Icon(Icons.home, size: 30),
                  onPressed: () {
                    // Reset or navigate to home
                  },
                ),

                // Big Plus Button
                FloatingActionButton(
                  onPressed: () {
                    // Add something
                  },
                  child: Icon(Icons.add, size: 36),
                  shape: CircleBorder(),
                  backgroundColor: Colors.blue,
                ),

                // Calendar Button
                IconButton(
                  icon: Icon(Icons.calendar_today, size: 30),
                  onPressed: () {
                    // Navigate to calendar
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}