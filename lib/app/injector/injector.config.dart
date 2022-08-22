// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:firebase_auth/firebase_auth.dart' as _i3;
import 'package:get_it/get_it.dart' as _i1;
import 'package:google_sign_in/google_sign_in.dart' as _i4;
import 'package:injectable/injectable.dart' as _i2;

import '../../auth/repository/auth_repository.dart' as _i6;
import '../../auth/repository/i_auth_repository.dart' as _i5;
import '../../core/infrastructure/third_party_injectable_module.dart'
    as _i7; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final thirdPartyInjectableModule = _$ThirdPartyInjectableModule();
  gh.lazySingleton<_i3.FirebaseAuth>(
      () => thirdPartyInjectableModule.firebaseAuth);
  gh.lazySingleton<_i4.GoogleSignIn>(
      () => thirdPartyInjectableModule.googleSignIn);
  gh.lazySingleton<_i5.IAuthRepository>(() =>
      _i6.AuthRepository(get<_i3.FirebaseAuth>(), get<_i4.GoogleSignIn>()));
  return get;
}

class _$ThirdPartyInjectableModule extends _i7.ThirdPartyInjectableModule {}
