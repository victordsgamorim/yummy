import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:yummy_app/app_widget.dart';
import 'package:yummy_app/core/injection/injections.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setup();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const MyApp());
}
