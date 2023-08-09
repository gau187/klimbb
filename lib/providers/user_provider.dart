import 'package:flutter/material.dart';
import 'package:untitled/helpers/database_helper.dart';
import 'package:untitled/modals/user_modal.dart';

final handler = DatabaseHandler();

class UserProvider with ChangeNotifier {
  List<UserModal> userModals = [];

  Future<List<UserModal>> retrieveUserProfiles() async {
    userModals = await handler.retrieveUsers();
    return userModals;
  }

  void addingUserProfile(UserModal userModal) {
    try {
      handler
          .insertUser(userModal)
          .catchError((error) {
        throw error;
      });
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }
}
