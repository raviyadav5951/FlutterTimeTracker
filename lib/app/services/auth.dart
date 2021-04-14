import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthBase {
  User get currentUser;

  //authStateChanges method will let us know the user logged in or sign out with Stream
  Stream<User> authStateChanges();
  Future<User> signInAnonymously();
  Future<void> signOut();
}

class Auth implements AuthBase {
  final _firebaseAuth = FirebaseAuth.instance;

  User get currentUser => _firebaseAuth.currentUser;
  @override
  Future<User> signInAnonymously() async {
    final userCredential = await _firebaseAuth.signInAnonymously();
    return userCredential.user;
  }

  @override
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  @override
  Stream<User> authStateChanges() => _firebaseAuth.authStateChanges();
}
