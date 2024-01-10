import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learnflow/common/constants/constants.dart';
import 'package:learnflow/features/authentication/models/user.dart';
import 'package:learnflow/features/home/home_screen.dart';
import 'package:learnflow/utils/utils.dart';

final authProvider = Provider<AuthRepository>((ref) => AuthRepository());

class AuthRepository {
  Future<User?> signUp({
    required BuildContext context,
    required UserModel model,
  }) async {
    try {
      await firebaseAuth
          .createUserWithEmailAndPassword(
              email: model.email, password: model.password)
          .then((value) async {
        User? user = firebaseAuth.currentUser;

        if (user != null) {
          await _storeUserData(user.uid, model);
        }
        moveScreen(context, HomeScreen(), isPushReplacement: true);
        return user;
      });
    } catch (e) {
      showSnackBar(context, e.toString());
      return null;
    }
  }

  Future<User?> logIn({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      await firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) async {
        User? user = firebaseAuth.currentUser;
        moveScreen(context, HomeScreen(), isPushReplacement: true);
        return user;
      });
    } catch (e) {
      showSnackBar(context, e.toString());
      return null;
    }
  }

  Future<void> _storeUserData(String userUid, UserModel model) async {
    User? user = getCurrentUser();

    UserModel newModel = UserModel(
        name: model.name,
        email: model.email,
        password: model.password,
        profileImageUrl: '',
        uid: user?.uid ?? 'The user UID didn\' come through, error 404.');

    await firestore.collection('users').doc(userUid).set(newModel.toMap());
  }

  User? getCurrentUser() {
    User? user = firebaseAuth.currentUser;
    return user;
  }
}
