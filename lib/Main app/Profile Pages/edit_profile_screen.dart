// ignore_for_file: use_build_context_synchronously, avoid_print

import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kings_connect/constants/colors.dart';
import 'package:kings_connect/constants/font_sizes.dart';
import 'package:kings_connect/controllers/profile_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; 

class EditProfileScreen extends ConsumerWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userState = ref.watch(profileControllerProvider);

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: const Text(
          'Edit Profile',
          style: TextStyle(
            fontSize: FontSizes.headline2,
            fontWeight: FontWeight.bold,
            color: AppColors.white,
            letterSpacing: -1,
          ),
        ),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back_ios,
            color: AppColors.white,
            size: 20,
          ),
        ),
      ),
      body: userState.when(
        data: (user) {
          if (user == null) {
            return const Center(child: Text('No user data available'));
          }
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                // Profile Picture with Edit Icon
                Center(
                  child: Stack(
                    children: [
                      // Profile Picture
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: user.profileImageUrl.isNotEmpty
                            ? NetworkImage(user.profileImageUrl)
                            : const AssetImage('assets/profile_pic.jpg')
                                as ImageProvider,
                      ),
                      // Edit Icon
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: InkWell(
                          onTap: () async {
                            File? pickedImage = await ref
                                .read(profileControllerProvider.notifier)
                                .pickProfileImage();
                            if (pickedImage != null) {
                              await ref
                                  .read(profileControllerProvider.notifier)
                                  .updateProfilePicture(pickedImage);
                            }
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: AppColors.primary,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.white,
                                width: 2,
                              ),
                            ),
                            padding: const EdgeInsets.all(6),
                            child: const Icon(
                              Icons.edit,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                // Name TextField
                _buildProfileField(
                  label: "Full Name",
                  hintText: "Enter your name",
                  initialValue: user.fullName,
                  onChanged: (value) {
                    ref
                        .read(profileControllerProvider.notifier)
                        .updateUserInfo(value, user.email);
                  },
                ),
                const SizedBox(height: 15),
                // Email TextField
                _buildProfileField(
                  label: "Email",
                  hintText: "Enter your email",
                  initialValue: user.email,
                  onChanged: (value) {
                    ref
                        .read(profileControllerProvider.notifier)
                        .updateUserInfo(user.fullName, value);
                  },
                ),
                const SizedBox(height: 40),
                // Save Changes Button
                ElevatedButton(
                  onPressed: () async {
                    await _saveProfileChanges(
                      fullName: user.fullName,
                      email: user.email,
                      context: context,
                      ref: ref,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 30),
                    backgroundColor: AppColors.primary,
                    minimumSize: const Size(double.infinity, 30),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'Save Changes',
                    style: TextStyle(
                      color: AppColors.white,
                      fontSize: FontSizes.headline5,
                      letterSpacing: -1,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
        loading: () => const Center(child: CupertinoActivityIndicator(radius:30,color: AppColors.primary,)),
        error: (e, _) => Center(child: Text('Error: $e')),
      ),
    );
  }

  Widget _buildProfileField({
    required String label,
    required String hintText,
    required String initialValue,
    required Function(String) onChanged,
  }) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      initialValue: initialValue,
      onChanged: onChanged,
    );
  }

  Future<void> _saveProfileChanges({
    required String fullName,
    required String email,
    required BuildContext context,
    required WidgetRef ref,
  }) async {
    print("Save Changes button clicked."); // Debug print
    try {
      // Update profile in Firebase Firestore
      await FirebaseFirestore.instance.collection('users').doc(email).update({
        'fullName': fullName,
        'email': email,
        // Add other fields as needed
      });

      // Show success dialog
      _showSuccessDialog(context);
    } catch (e) {
      // Handle errors (e.g., show an error message)
      print('Failed to update profile: $e');
      _showErrorDialog(context, e.toString());
    }
  }

  void _showErrorDialog(BuildContext context, String errorMessage) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error',
              style: TextStyle(
                letterSpacing: -1,
                color: AppColors.primary,
              )),
          content: Text(errorMessage),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text(
                'OK',
                style: TextStyle(
                  letterSpacing: -1,
                  color: AppColors.primary,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Success',
            style: TextStyle(
              letterSpacing: -1,
              color: AppColors.primary,
            ),
          ),
          content: const Text('Profile updated successfully!',style: TextStyle(letterSpacing: -1),),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('OK',
                style: TextStyle(
                  letterSpacing: -1,
                  color: AppColors.primary,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}


