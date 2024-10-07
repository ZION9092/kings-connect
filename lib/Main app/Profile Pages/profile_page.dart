import 'package:flutter/material.dart';
import 'package:kings_connect/Main%20app/Profile%20Pages/edit_profile_screen.dart';
import 'package:kings_connect/Main%20app/Profile%20Pages/Payment/payment_method_screen.dart';
import 'package:kings_connect/constants/colors.dart';
import 'package:kings_connect/constants/font_sizes.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: const Text(
          "Profile",
          style: TextStyle(
            fontSize: FontSizes.headline2,
            fontWeight: FontSizes.bold,
            letterSpacing: -1,
            color: AppColors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch, // Makes everything stretch horizontally
            children: [
              const Text(
                'Personal',
                style: TextStyle(
                  fontSize: FontSizes.headline3,
                  fontWeight: FontWeight.bold,
                  letterSpacing: -1,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(height: 20),
        
              // Profile Options directly arranged
              _buildProfileOption(
                icon: Icons.edit,
                label: 'Edit Profile',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const EditProfileScreen()),
                  );
                },
              ),
              const SizedBox(height: 10),
        
              _buildProfileOption(
                icon: Icons.payment,
                label: 'Payment Methods',
                onTap: () {
                  // Handle navigation to Payment Methods
                   Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const PaymentMethodScreen()),
                  );
                },
              ),
              const SizedBox(height: 10),
        
              _buildProfileOption(
                icon: Icons.notifications,
                label: 'Notifications',
                onTap: () {
                  // Handle navigation to Notifications
                },
              ),
        
               const SizedBox(height: 10),
        
              _buildProfileOption(
                icon: Icons.location_pin,
                label: 'Delivery Address',
                onTap: () {
                  // Handle navigation to Settings
                },
              ),
              const SizedBox(height: 5),
        
              const Divider(color: AppColors.primary),
        
              const SizedBox(height: 8),
              const Text('Account',
              style: TextStyle(
                fontSize: FontSizes.headline3,
                  fontWeight: FontWeight.bold,
                  letterSpacing: -1,
                  color: AppColors.primary,
              ),
              ),
              const SizedBox(height: 10),
        
              _buildProfileOption(
                icon: Icons.settings,
                label: 'Settings',
                onTap: () {
                  // Handle navigation to Settings
                },
              ),
              const SizedBox(height: 10),
        
              _buildProfileOption(
                icon: Icons.help,
                label: 'Help & Support',
                onTap: () {
                  // Handle navigation to Help & Support
                },
              ),
              const SizedBox(height: 10),
        
              _buildProfileOption(
                icon: Icons.logout,
                label: 'Log Out',
                onTap: () {
                  // Handle Log Out
                },
              ),
              const SizedBox(height: 30),
        
              const Row(
                children: [
                  Icon(Icons.delete,color:AppColors.errorColor,),
                  SizedBox(width: 10),
                  Text('Delete Account',
                  style: TextStyle(
                    color: AppColors.errorColor,
                    fontWeight: FontSizes.regular,
                    fontSize: FontSizes.headline5,
                    letterSpacing: -1,
                  ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
      backgroundColor: AppColors.white,
    );
  }


  // Widget for building Profile Options
  Widget _buildProfileOption({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: AppColors.primary),
      title: Text(
        label,
        style: const TextStyle(
          fontSize: FontSizes.headline5,
          letterSpacing: -1,
          fontWeight: FontSizes.regular,
          color: AppColors.textColor,
        ),
      ),
      trailing: const Icon(Icons.arrow_forward_ios, color: AppColors.primary, size: 16),
      onTap: onTap,
    );
  }
}
