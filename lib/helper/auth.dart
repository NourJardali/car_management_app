import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

class Auth {
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<FirebaseUser> handleSignInEmail(String email, String pass) async {
    try {
      var result =
          await auth.signInWithEmailAndPassword(email: email, password: pass);
      final user = result.user;
      assert(user != null);
      assert(await user.getIdToken() != null);
      final currentUser = await auth.currentUser();
      assert(user.uid == currentUser.uid);
      print('signInEmail succeeded: $user');
      return user;
    } catch (signinerror) {
      if (signinerror is PlatformException) {
        return null;
      }
    }
    return null;
  }

  Future<FirebaseUser> handleSignUp(String email, String pass) async {
    try {
      var result = await auth.createUserWithEmailAndPassword(
          email: email, password: pass);
      final user = result.user;
      assert(user != null);
      assert(await user.getIdToken() != null);
      return user;
    } catch (signUpError) {
      if (signUpError is PlatformException) {
        if (signUpError.code == 'ERROR_EMAIL_ALREADY_IN_USE') {
          return null;
        }
      }
    }
    return null;
  }
}
