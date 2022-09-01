import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:todo/app/app.dart';
import 'package:todo/bootstrap.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  configureInjector();

  await Firebase.initializeApp();

  await FirebaseAppCheck.instance.activate();

  await bootstrap(App.new);
}
