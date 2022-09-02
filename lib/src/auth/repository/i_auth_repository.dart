import 'package:dartz/dartz.dart';
import 'package:todo/src/core/domain/failures/failures.dart';
import 'package:todo/src/user/user.dart';

abstract class IAuthRepository {
  Option<User> isUserAutheticated();

  Future<Either<Failure, User>> registerWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<Either<Failure, User>> loginWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<Either<Failure, Unit>> resetPassword(String email);

  Future<Either<Failure, User>> loginWithGoogle();

  Future<void> logout();
}
