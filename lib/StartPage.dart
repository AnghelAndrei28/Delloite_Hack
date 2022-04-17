import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class AnotherGarbage extends StatelessWidget {
    const AnotherGarbage({Key? key, title}) : super(key: key);
    Widget build(BuildContext context) {
      return Scaffold(
          body: Center(
            child: Text('placeholder route'),
          ),
      );
    }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Hey yo wassup!'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Welcome to name'),
              Image.asset('logo.png', width: 300, height: 300),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AnotherGarbage()));
            }
        ),
    );
  }
}