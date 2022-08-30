import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';
import 'package:todo/src/auth/repository/i_auth_repository.dart';
import 'package:todo/src/core/domain/failures/failures.dart';
import 'package:todo/src/user/user.dart' as my_user;

@LazySingleton(as: IAuthRepository)
class AuthRepository implements IAuthRepository {
  AuthRepository(
    this._firebaseAuth,
    this._googleSignIn,
  );

  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;

  @override
  Future<Either<Failure, my_user.User>> loginWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final result = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = result.user;

      if (user != null) {
        return right(
          my_user.User.empty.copyWith(
            id: user.uid,
            email: user.email,
            name: user.displayName,
            profileUrl: user.photoURL,
          ),
        );
      } else {
        return left(
          const Failure.unexpected('User not exist'),
        );
      }
    } on FirebaseAuthException catch (e) {
      return left(
        Failure.serverError(message: e.code),
      );
    }
  }

  @override
  Future<Either<Failure, my_user.User>> registerWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final result = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = result.user;

      if (user != null) {
        await user.sendEmailVerification();
        return right(
          my_user.User.empty.copyWith(
            id: user.uid,
            email: user.email,
            name: user.displayName,
            profileUrl: user.photoURL,
          ),
        );
      } else {
        return left(
          const Failure.unexpected(
            'User not found',
          ),
        );
      }
    } on FirebaseAuthException catch (e) {
      return left(
        Failure.serverError(message: e.code),
      );
    }
  }

  @override
  Future<Option<Failure>> resetPassword(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(
        email: email,
      );
      return none();
    } on FirebaseAuthException catch (e) {
      return some(
        Failure.serverError(message: e.code),
      );
    }
  }

  @override
  Future<Either<Failure, my_user.User>> loginWithGoogle() async {
    try {
      final googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        return left(
          const Failure.unexpected(
            'User not exit',
          ),
        );
      }

      final googleAuthentication = await googleUser.authentication;

      final authcredential = GoogleAuthProvider.credential(
        idToken: googleAuthentication.idToken,
        accessToken: googleAuthentication.accessToken,
      );

      final cred = await _firebaseAuth.signInWithCredential(authcredential);
      final user = cred.user;
      if (user != null) {
        return right(
          my_user.User.empty.copyWith(
            id: user.uid,
            email: user.email,
            name: user.displayName,
            profileUrl: user.photoURL,
          ),
        );
      } else {
        return left(
          const Failure.unexpected('User not exits'),
        );
      }
    } on FirebaseAuthException catch (e) {
      return left(
        Failure.serverError(message: e.code),
      );
    }
  }

  @override
  Future<void> logout() async => Future.wait(
        [
          _googleSignIn.signOut(),
          _firebaseAuth.signOut(),
        ],
      );
}
