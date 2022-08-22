abstract class IAuthRepository {
  Future<void> registerWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<void> loginWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<void> resetPassword(String email);

  Future<void> loginWithGoogle();
  Future<void> loginWithFacebook();
  Future<void> loginWithTwitter();

  Future<void> logout();
}
