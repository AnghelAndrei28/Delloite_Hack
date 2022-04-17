import 'package:digi_hack/MapScreen.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  static const routName = "/main";

  @override
  Widget build(BuildContext context) {
    // final user = ModalRoute.of(context)!.settings.arguments as String;
    // print(user);
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
                    // Navigator.of(context).pushNamed(routeName)
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => const GarbageRt1()),
                    // );
                  },
                ),
                ListTile(
                  leading: Icon(Icons.report),
                  title: Text('My reports'),
                  onTap: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => const GarbageRt1()),
                    // );
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
          actions: const [
            Icon(
                Icons.pets_outlined
            ),
          ],
          centerTitle: true,
          title: Text("Main Page"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              onPressed: () {
                Navigator.pushNamed(context, MapScreen.routName, arguments: true);
              },
              child: Text('Found dogs'),
            ),
            RaisedButton(
                onPressed: () {
                  Navigator.pushNamed(context, MapScreen.routName, arguments: false);
                },
                child: Text('Lost dogs'),
            )
          ],
        ),
      ),
    );
  }
}