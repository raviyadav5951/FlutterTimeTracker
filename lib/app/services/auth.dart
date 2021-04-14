import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class AuthBase {
  User get currentUser;

  //authStateChanges method will let us know the user logged in or sign out with Stream
  Stream<User> authStateChanges();
  Future<User> signInAnonymously();
  Future<void> signOut();
  Future<User> signInWithGoogle();
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

    GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
    ],
  );

    await _googleSignIn.signOut();
    await _firebaseAuth.signOut();
  }

  @override
  Stream<User> authStateChanges() => _firebaseAuth.authStateChanges();

  @override
  Future<User> signInWithGoogle() async {
    GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
    ],
  );
  
    final GoogleSignInAccount googleSignInAccount =
        await _googleSignIn.signIn();
    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication authentication =
          await googleSignInAccount.authentication;
      if (authentication != null) {
        print('access token=${authentication?.accessToken}');
        print('id token=${authentication?.idToken}');
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: authentication.accessToken,
          idToken: authentication.idToken,
        );

        try {
          final UserCredential userCredential =
              await _firebaseAuth.signInWithCredential(credential);
          print('user =${userCredential?.user?.uid}');
          return userCredential.user;
        } on FirebaseAuthException catch (e) {
          if (e.code == 'account-exists-with-different-credential') {
            // handle the error here
          } else if (e.code == 'invalid-credential') {
            // handle the error here
          }
        } catch (e) {
          // handle the error here
          return null;
        }
        return null;
      } else {
        throw FirebaseAuthException(
            code: 'ERROR_MISSING_AUTH_TOKEN', message: 'Missing auth token');
      }
    } else {
      throw FirebaseAuthException(
            code: 'ERROR_SIGN_IN_ABORTED', message: 'Sign in aborted by user');
    }
   
  }
}
