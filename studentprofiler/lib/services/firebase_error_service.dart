import 'package:firebase_auth/firebase_auth.dart';

class FirebaseErrorService {
  // --------------------------- Find Firebase Auth Error Type ---------------------------
  String findFirebaseAuthErrorType(FirebaseAuthException authError) {
    switch (authError.code) {
      case 'user-not-found':
        return 'There is no user record corresponding to this identifier. The user may have been deleted.';
      case 'email-already-in-use':
        return 'An account with the given email address already exists.';
      case 'invalid-email':
        return 'Email address is not valid.';
      case 'operation-not-allowed':
        return 'Email/Password accounts are not enabled.';
      case 'wrong-password':
        return 'The password is invalid or the user does not have a password.';
      case 'weak-password':
        return 'Password is not strong enough.';
      case 'network-request-failed':
        return 'A network error has occurred.';
      default:
        return 'An error occurred.';
    }
  }

  // --------------------------- Find Firebase Firestore Error Type ---------------------------
  String findFirebaseFirestoreErrorType(FirebaseException firestoreError) {
    switch (firestoreError.code) {
      case 'permission-denied':
        return 'The caller does not have permission to execute the specified operation.';
      case 'unavailable':
        return 'The service is currently unavailable.';
      case 'cancelled':
        return 'The operation was cancelled (typically by the caller).';
      case 'unknown':
        return 'Unknown error or an error from a different error domain.';
      case 'invalid-argument':
        return 'Client specified an invalid argument.';
      case 'deadline-exceeded':
        return 'Deadline expired before operation could complete.';
      case 'not-found':
        return 'Some requested document was not found.';
      case 'already-exists':
        return 'Some document that we attempted to create already exists.';
      case 'resource-exhausted':
        return 'Some resource has been exhausted, perhaps a per-user quota, or perhaps the entire file system is out of space.';
      case 'failed-precondition':
        return 'Operation was rejected because the system is not in a state required for the operation\'s execution.';
      case 'aborted':
        return 'The operation was aborted, typically due to a concurrency issue like transaction aborts, etc.';
      case 'out-of-range':
        return 'Operation was attempted past the valid range.';
      case 'unimplemented':
        return 'Operation is not implemented or not supported/enabled.';
      case 'internal':
        return 'Internal errors.';
      case 'data-loss':
        return 'Unrecoverable data loss or corruption.';
      case 'unauthenticated':
        return 'The request does not have valid authentication credentials for the operation.';
      default:
        return 'An error occurred.';
    }
  }
}
