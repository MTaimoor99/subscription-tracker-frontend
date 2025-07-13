import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RegisterPage extends ConsumerWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final formKey = GlobalKey<FormState>();
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //Email
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                  ),
                  hintText: 'Email',
                ),
                validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Email is required';
                }
                
                // Remove whitespace
                value = value.trim();
                
                // Check basic format
                final emailRegex = RegExp(
                  r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$'
                );
                
                if (!emailRegex.hasMatch(value)) {
                  return 'Please enter a valid email address';
                }
                
                // Additional checks
                if (value.length > 254) {
                  return 'Email address is too long';
                }
                
                if (value.startsWith('.') || value.endsWith('.')) {
                  return 'Email cannot start or end with a dot';
                }
                
                if (value.contains('..')) {
                  return 'Email cannot contain consecutive dots';
                }
                
                return null;
                }, 
              ),
              SizedBox(height:8),
              //Password
              TextFormField(
                obscureText: true,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                ),
                hintText: 'Password',
                ),
                validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Password is required';
                }
                if (value.length < 6) {
                  return 'Password must be at least 6 characters long';
                }
                return null;
              },
              ),
              SizedBox(height:8),
              ElevatedButton(onPressed: () {
              //Will be sending the API call here.
              if (formKey.currentState!.validate()){
                print('User registered');
              }
              },
              child: Text('Register User'),
              )
            ],
          ),
        ),
      ),
    );
  }
}