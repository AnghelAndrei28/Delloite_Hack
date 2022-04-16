import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ReportScreen extends StatefulWidget {
  static const routName = "/tracks";

  @override
  _ReportScreenState createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as LatLng;
    TextEditingController _controllerCoordinates =  new TextEditingController(text: args.toString());
    TextEditingController _controllerDescription = new TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text("Report lost pet"),
      ),
      body: Center(
        child: Form (
          key: _formKey,
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                    icon: const Icon(Icons.add_location),
                    labelText: 'Coordinates',
                  ),
                  controller: _controllerCoordinates,
                  enabled: false,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    icon: const Icon(Icons.description),
                    hintText: 'Enter description of your pet',
                    labelText: 'Description',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  controller: _controllerDescription,
                ),
                Container(
                    padding: const EdgeInsets.only(left: 150.0, top: 40.0),
                    child: new FlatButton(
                      child: const Text('Submit'),
                      onPressed: () {
                        // It returns true if the form is valid, otherwise returns false
                        if (_formKey.currentState!.validate()) {
                          // If the form is valid, display a Snackbar.
                          Navigator.pop(context, _controllerDescription.text);
                        }
                      },
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
