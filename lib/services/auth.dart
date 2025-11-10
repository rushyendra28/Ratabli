import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Stream to track auth state changes
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  // Email & Password Sign In
  Future<String?> signInWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
      return null; // Success
    } on FirebaseAuthException catch (e) {
      return _handleAuthError(e);
    } catch (_) {
      return 'Something went wrong. Please try again.';
    }
  }

  // Email & Password Sign Up with optional display name
  Future<String?> signUpWithEmail({
    required String email,
    required String password,
    String? displayName,
  }) async {
    try {
      final cred = await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );

      if (displayName != null && cred.user != null) {
        await cred.user!.updateDisplayName(displayName);
        await cred.user!.reload();
      }

      return null; // Success
    } on FirebaseAuthException catch (e) {
      return _handleAuthError(e);
    } catch (_) {
      return 'Something went wrong. Please try again.';
    }
  }

  // 🔹 Google Sign-In
  // Future<String?> signInWithGoogle() async {
  //   try {
  //     final googleSignIn = GoogleSignIn(
  //       scopes: ['email'],
  //     );

  //     final GoogleSignInAccount? googleUser = await googleSignIn.sigfnIn();
  //     if (googleUser == null) return 'Sign-in aborted';

  //     final GoogleSignInAuthentication googleAuth =
  //         await googleUser.authentication;

  //     final credential = GoogleAuthProvider.credential(
  //       accessToken: googleAuth.accessToken,
  //       idToken: googleAuth.idToken,
  //     );

  //     await _auth.signInWithCredential(credential);
  //     return null;
  //   } on FirebaseAuthException catch (e) {
  //     return _handleAuthError(e);
  //   } catch (_) {
  //     return 'Something went wrong. Please try again.';
  //   }
  // }

  // // 🔸 Sign Out
  // Future<void> signOut() async {
  //   await _auth.signOut();
  //   await GoogleSignIn().signOut();
  // }

  // 🔹 Firebase Error Handler
  String _handleAuthError(FirebaseAuthException e) {
    switch (e.code) {
      case 'email-already-in-use':
        return 'This email is already in use.';
      case 'invalid-email':
        return 'This email address is invalid.';
      case 'user-disabled':
        return 'This account has been disabled.';
      case 'user-not-found':
        return 'No user found with these credentials.';
      case 'wrong-password':
        return 'Incorrect password, please try again.';
      case 'weak-password':
        return 'Your password is too weak.';
      case 'account-exists-with-different-credential':
        return 'This account exists with different credentials.';
      default:
        return 'Authentication failed. Please try again.';
    }
  }
}
