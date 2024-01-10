import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learnflow/features/authentication/models/user.dart';
import 'package:learnflow/features/authentication/repositories/auth_provider.dart';
import 'package:learnflow/utils/utils.dart';

//auth_notifer_provider

final authNotifierProvider =
    StateNotifierProvider<AuthNotifier, AsyncValue<User?>>((ref) {
  return AuthNotifier();
});

class AuthNotifier extends StateNotifier<AsyncValue<User?>> {
  AuthNotifier() : super(const AsyncLoading());

  Future<void> signUp({
    required BuildContext context,
    required UserModel model,
  }) async {
    await AuthRepository().signUp(context: context, model: model).then((value) {
      showSnackBar(context, "User created!");
    });

    checkAuthStatus();
  }

  Future<void> logIn({
    required BuildContext context,
    required String email,
    required String password,
  }) {
    return AuthRepository()
        .logIn(context: context, email: email, password: password);
    checkAuthStatus();
  }

  void checkAuthStatus() {
    state = AsyncData(AuthRepository().getCurrentUser());
  }
}
