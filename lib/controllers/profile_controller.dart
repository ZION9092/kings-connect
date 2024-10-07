// ignore_for_file: avoid_print
import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kings_connect/Firebase/firebase_helper.dart';
import 'package:kings_connect/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
 
final authProvider = Provider<FirebaseAuth>((ref) => FirebaseAuth.instance);

final profileControllerProvider = StateNotifierProvider<ProfileController, AsyncValue<UserModel?>>((ref) {
  final auth = ref.watch(authProvider);
  return ProfileController(ref, auth);
});

class ProfileController extends StateNotifier<AsyncValue<UserModel?>> {
  final FirebaseHelper _firebaseHelper = FirebaseHelper();
  // ignore: unused_field
  final Ref _ref;
  final FirebaseAuth _auth;

  ProfileController(this._ref, this._auth) : super(const AsyncValue.loading()) {
    // Listen to authentication state changes
    _auth.authStateChanges().listen((user) {
      if (user != null) {
        _loadUserData(user.uid);
      } else {
        state = const AsyncValue.data(null); // User is signed out
      }
    });
  }

  // Load user data when authenticated
  Future<void> _loadUserData(String userId) async {
    try {
      UserModel? user = await _firebaseHelper.getUserData(userId);
      if (user != null) {
        state = AsyncValue.data(user);
      } else {
        // Optionally handle cases where user data does not exist
        state = const AsyncValue.data(null);
      }
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }

  // Save changes for profile picture and user info
  Future<void> saveChanges({File? imageFile, required String fullName, required String email}) async {
    try {
      String userId = _auth.currentUser!.uid;
      UserModel? currentUser = state.value;

      String imageUrl = currentUser!.profileImageUrl; // Default to existing image

      if (imageFile != null) {
        // Upload image if provided and get the download URL
        imageUrl = await _firebaseHelper.uploadProfileImage(imageFile, userId);
        print('Image uploaded successfully. Download URL: $imageUrl');
      }

      // Create a new UserModel with updated information
      UserModel updatedUser = UserModel(
        fullName: fullName,
        email: email,
        profileImageUrl: imageUrl,
      );

      // Save the updated user data in Firestore
      await _firebaseHelper.saveUserData(updatedUser, userId);
      print('User data updated with new information.');

      // Update the state with the new user data
      state = AsyncValue.data(updatedUser);
    } catch (e, stackTrace) {
      print('Error saving changes: $e');
      state = AsyncValue.error(e, stackTrace);
    }
  }

  // Update profile picture
  Future<void> updateProfilePicture(File imageFile) async {
    // Logic for updating the profile picture (if separate from saveChanges)
  }

  // Image Picker for selecting profile picture
  Future<File?> pickProfileImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    return pickedFile != null ? File(pickedFile.path) : null;
  }

  void updateUserInfo(String value, String email) {}
}

