// import 'dart:html';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:image_picker/image_picker.dart';
import 'firebase_options.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class ReportScreen extends StatefulWidget {
  static const routName = "/report";

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
    final StorageWeb storageWeb = StorageWeb();
    final StorageMobile storageMobile = StorageMobile();

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
                    child: FlatButton(
                      child: const Text('Add image'),
                      onPressed: () async {
                        // It returns true if the form is valid, otherwise returns false
                        if (_formKey.currentState!.validate()) {
                          final FilePickerResult? result = await FilePicker.platform.pickFiles (
                            allowMultiple: false,
                          );

                          if (kIsWeb) {
                            final bytes = result?.files.single.bytes;
                            final fileName = result?.files.single.name;
                            storageWeb.uploadFile(bytes!, fileName!);
                          } else {
                            final path = result?.files.single.path;
                            final fileName = result?.files.single.name;
                            storageMobile.uploadFile(path!, fileName!);
                          }

                        }
                      },
                    )),
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

class StorageWeb {
  final firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  Future<void> uploadFile (
      var bytes,
      var fileName,
      ) async {
    try {
      await storage.ref ('test/$fileName').putData(bytes);
    } on firebase_core.FirebaseException catch (e) {
      print (e);
    }
  }
}

class StorageMobile {
  final firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  Future<void> uploadFile (
      var path,
      var fileName,
      ) async {
    File file = File(path);
    try {
      await storage.ref ('test/$fileName').putFile(file);
    } on firebase_core.FirebaseException catch (e) {
      print (e);
    }
  }
}