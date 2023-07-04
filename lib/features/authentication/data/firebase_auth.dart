import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:zetaton_task/core/helpers/app_toast.dart';
import 'package:zetaton_task/features/authentication/model/user_model.dart';

class AuthData {
  Future<User?> registerUser({required UserModel userModel}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: userModel.email!,
        password: userModel.password!,
      );
      user = userCredential.user;
      await user!.reload();
      user = auth.currentUser;
      if (userCredential.user != null) {
        // User currentUser = userCredential.user!;
        await FirebaseFirestore.instance
            .collection('user')
            .add(userModel.toJson())
            .then((value) async {
          value.update({'id': value.id});
        });
      }
    } on FirebaseAuthException catch (e) {
      user = null;
      if (e.code == 'weak-password') {
        log('The password provided is too weak.');
        AppToast.errorToast('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        log('The account already exists for that email.');
        AppToast.errorToast('The account already exists for that email.');
      }
    } catch (e) {
      log(e.toString());
    }
    return user;
  }

  Future<UserModel> getUserByEmail({required String email}) async {
    return FirebaseFirestore.instance
        .collection('user')
        .where('email', isEqualTo: email)
        .limit(1)
        .get()
        .then((res) {
      if (res.docs.isNotEmpty) {
        return UserModel.fromJson(res.docs.first.data());
      } else {
        throw 'User not found';
      }
    });
  }
  // loginUser({required String email, required String password}) {
  //   FirebaseAuth.instance.signInWithEmailAndPassword(
  //     email: email,
  //     password: password,
  //   );
  // }

  Future<User?> signInUsingEmailPassword({
    required String email,
    required String password,
  }) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;

    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      user = userCredential.user;
    } on FirebaseAuthException catch (e) {
      user = null;
      if (e.code == 'user-not-found') {
        log('No user found for that email.');
        AppToast.errorToast('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        log('Wrong password provided.');
        AppToast.errorToast('Wrong password provided.');
      }
    }

    return user;
  }
}
