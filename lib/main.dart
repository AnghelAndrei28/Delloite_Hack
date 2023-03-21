import 'package:digi_hack/CustomMark.dart';
import 'package:digi_hack/MainScreen.dart';
import 'package:digi_hack/MapScreen.dart';
import 'package:digi_hack/Random.dart';
import 'package:digi_hack/ReportScreen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'login_screen.dart';

void initializeFirebase () async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

void main(){
  initializeFirebase();
  runApp(MyApp());
}

ColorScheme defaultColorScheme = const ColorScheme(
  primary: Color(0xffBB86FC),
  secondary: Color(0xff03DAC6),
  surface: Color(0xff181818),
  background: Color(0xff121212),
  error: Color(0xffCF6679),
  onPrimary: Color(0xff000000),
  onSecondary: Color(0xff000000),
  onSurface: Color(0xffffffff),
  onBackground: Color(0xffffffff),
  onError: Color(0xff000000),
  brightness: Brightness.dark,
);

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        ReportScreen.routName: (ctx) => ReportScreen(),
        MapScreen.routName: (ctx) => MapScreen(),
        MainScreen.routName: (ctx) => MainScreen(),
        Random.routName: (ctx) => Random(),
      },
      home: const LoginPage(title: 'Login UI'),
    );
  }
}

