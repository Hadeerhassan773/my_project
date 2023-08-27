import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  File? image;
  Future pickImage() async {
    try {
      //final image = await ImagePicker().pickImage(source: ImageSource.camera);
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemb = File(image.path);
      setState(() => this.image = imageTemb);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }


  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title:
              const Text("Image Picker Example", textAlign: TextAlign.center),
        ),
        body: Center(
          child: Column(
            children: [
              MaterialButton(
                  height: 100,
                  color: Colors.blue,
                  child: const Text("Pick Image from Gallery",
                      style: TextStyle(
                        color: Colors.white70,
                        fontWeight: FontWeight.bold,
                      )),
                  onPressed: () {
                    pickImage();
                  }),
              SizedBox(height: 100),
              MaterialButton(
                  height: 100,
                  color: Colors.blue,
                  child: const Text("Pick Image from Camera",
                      style: TextStyle(
                          color: Colors.white70, fontWeight: FontWeight.bold)),
                  onPressed: () {}),
              SizedBox(
                height: 20,
              ),
              image != null ? Image.file(image!) : Text("no image selected")
            ],
          ),
        ));
  }
}
