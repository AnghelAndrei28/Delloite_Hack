import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class Report {
  final double latitude;
  final double longitude;
  final String description;
  final bool type;
  final String userId;

  const Report({
    required this.latitude,
    required this.longitude,
    required this.description,
    required this.type,
    required this.userId,
  });

  factory Report.fromJson(Map<String, dynamic> json) {
    return Report(
        latitude: json['lat'],
        longitude: json['lon'],
        description: json['description'],
        type: json['type'],
        userId: json['userId']
    );
  }
}

class User {
  final String email;
  final String first_name;
  final String last_name;
  final String password;
  final String phone;

  const User({
    required this.email,
    required this.first_name,
    required this.last_name,
    required this.password,
    required this.phone,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      email: json['email'],
      first_name: json['first_name'],
      last_name: json['last_name'],
      password: json['password'],
      phone: json['phone'],
    );
  }
}

class Details {
  String description = "";
  String phone = "";
  String name = "";

  // Details(description, phone, name) {
  //   this.description = description;
  //   this.phone = phone;
  //   this.name = name;
  // }
}



//to be removed
class GarbageRt1 extends StatelessWidget {

  late Details details = new Details();

  Future<void> getDetails(String reportId) async {
    final response = await http.get(Uri.parse(
        'https://digi-hack-default-rtdb.firebaseio.com/reports.json?'));
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    print(extractedData);
    String userId = "";
    Report report;
    extractedData.forEach((r_id, r_data) {
      report = (Report(
        latitude: r_data['lat'],
        longitude: r_data['lon'],
        description: r_data['description'],
        type: r_data['type'],
        userId: r_data['userId'],
      ));

      if(r_id == reportId) {
        userId = report.userId;
        details.description = report.description;
      }
    });

    final response2 = await http.get(Uri.parse(
        'https://digi-hack-default-rtdb.firebaseio.com/Users.json?'));
    final extractedData2 = json.decode(response2.body) as Map<String, dynamic>;
    print(extractedData2);
    User user;
    extractedData2.forEach((u_id, u_data) {
      user = (User(
        email: u_data['email'],
        first_name: u_data['first_name'],
        last_name: u_data['last_name'],
        password: u_data['password'],
        phone: u_data['phone'],
      ));
      if(u_id == userId) {
        details.phone = user.phone;
        details.name = user.last_name + " " + user.first_name;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepOrange,
      appBar: AppBar(
        title: Text("Details"),
      ),
      body: Center(
          child: FutureBuilder(
              future: getDetails('ADSGHAS'),
              builder: (ctx, AsyncSnapshot<dynamic> response) {
                return Container(
                  margin: EdgeInsets.all(15),
                  padding: EdgeInsets.all(15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("Dog Found"),
                    SizedBox(height: 20),
                    Image.asset("assets/caine.png"),
                    SizedBox(height: 20,),
                    Text(details.description),
                    SizedBox(height: 20,),
                    Text("Contact"),
                    SizedBox(height: 5,),
                    Text("Name : " + details.name),
                    SizedBox(height: 5,),
                    Text("Phone : " + details.phone),
                  ],
                ),);
              })
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
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Hey yo wassup!'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      drawer: Drawer(
          child: ListView(
              children: <Widget> [
                DrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.blue,
                  ),
                  child: Text(
                    'idk what to put here mate',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.account_circle),
                  title: Text('Account settings'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => GarbageRt1()),
                    );
                  },
                ),
                ListTile(
                  leading: Icon(Icons.report),
                  title: Text('My reports'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => GarbageRt1()),
                    );
                  },
                ),
                ListTile(
                  leading: Icon(Icons.logout),
                  title: Text('Sign out'),
                ),
              ]
          )
      ),
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
          actions: const [
            Icon(
                Icons.pets_outlined
            ),
          ],
          title: Center(
              child: Column(
                  children: [
                    Text(widget.title)
                  ]
              )
          )
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>  GarbageRt1()),
                );
              },
              child: Text('I lost my doggie:('),
            ),
            RaisedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => GarbageRt1()),
                  );
                },
                child: Text('I found a lost doggie')
            )
          ],
        ),
      ),
    );
  }
}