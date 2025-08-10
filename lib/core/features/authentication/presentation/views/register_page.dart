import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:subscription_tracker_frontend/core/features/authentication/presentation/providers/auth_provider.dart';

class RegisterPage extends ConsumerWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final registerState = ref.watch(authNotifierProvider);
    final registerNotifier = ref.read(authNotifierProvider.notifier);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: registerNotifier.registerFormKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //Email
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                controller: registerNotifier.emailController,
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
                controller: registerNotifier.passwordController,
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
              TextFormField(
                obscureText: true,
                controller: registerNotifier.confirmPasswordController,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                ),
                hintText: 'Confirm password',
                ),
                validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Confirm password field is required';
                }
                if (value.length < 6) {
                  return 'Confirm password must be at least 6 characters long';
                }
                if (value != registerNotifier.passwordController.text){
                  return "Password and confirm password fields must match";
                }
                return null;
              },
              ),
              SizedBox(height:8),
              ElevatedButton(
              onPressed: () async{
              //Will be sending the API call here.
              if (registerNotifier.registerFormKey.currentState!.validate()){
                await registerNotifier.register();
              }
              },
              child: Text('Register User'),
              ),
              SizedBox(height:8),
              TextButton(
              onPressed: () async{
              context.go('/login');
              },
              child: Text('Login User'),
              )
            ],
          ),
        ),
      ),
    );
  }
}