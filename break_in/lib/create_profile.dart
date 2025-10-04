//Collect intial profile information.

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';

class CreateProfile extends StatefulWidget {
  const CreateProfile({super.key});

  @override
  State<CreateProfile> createState() => _CreateProfileState();
}

class _CreateProfileState extends State<CreateProfile> {
  final _formKey = GlobalKey<FormState>();
  //controllers for the inputs
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _usernameController = TextEditingController();

  String _error = '';

  Future<void> _submitProfile() async {
    if (_formKey.currentState!.validate()) {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        setState(() {
          _error = 'User not authenticated';
        });
        return;
      }

      final username = _usernameController.text.trim();

      //verify the username is unique
      final query = await FirebaseFirestore.instance
          .collection('users')
          .where('username', isEqualTo: username)
          .get();

      if (query.docs.isNotEmpty) {
        setState(() {
          _error = 'Username already taken';
        });
        return;
      }

      //Save the profile information
      await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
        'firstName': _firstNameController.text.trim(),
        'lastName': _lastNameController.text.trim(),
        'username': username,
        'email': user.email,
        'createdAt': FieldValue.serverTimestamp(),
      });

      if (mounted) {
        context.go('/home'); // Or your next destination
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Your Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              if (_error.isNotEmpty)
                Text(
                  _error,
                  style: const TextStyle(color: Colors.red),
                ),
              //Collect Profile Information
              //First Name
              TextFormField(
                controller: _firstNameController,
                decoration: const InputDecoration(labelText: 'First Name'),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Required' : null,
              ),
              //Last Name
              TextFormField(
                controller: _lastNameController,
                decoration: const InputDecoration(labelText: 'Last Name'),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Required' : null,
              ),
              //Username
              TextFormField(
                controller: _usernameController,
                decoration: const InputDecoration(labelText: 'Username'),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _submitProfile,
                child: const Text('Done!'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
