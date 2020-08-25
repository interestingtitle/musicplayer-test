import 'package:flutter/material.dart';
import 'package:http/http.dart' show get;
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:file_picker/file_picker.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Test Image',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Test Image'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  initState() {
    _asyncMethod();
    super.initState();
  }

  _asyncMethod() async {
    File file = await FilePicker.getFile();
    var abc=file.length();
    var documentDirectory = await getApplicationDocumentsDirectory();
    var firstPath ='/storage/emulated/0/Android/data/com.test.music_sync/images';
    var downloadLocation='/storage/emulated/0/Android/data/com.test';
    //var filePathAndName = documentDirectory.path + '/images/pic.jpg';
    var filePathAndName = downloadLocation + '/images/pic.jpg';
    filePathAndName=file.path;
    //comment out the next three lines to prevent the image from being saved
    //to the device to show that it's coming from the internet
    await Directory(firstPath).create(recursive: true); // <-- 1

    //var url = "https://www.google.com.tr/images/branding/googlelogo/1x/googlelogo_color_272x92dp.png"; // <-- 1
    //var response = await get(url);
    //var fileTest = downloadLocation + '/images/pic.png';
    //File file2 = new File(fileTest);             // <-- 2
    //file2.writeAsBytesSync(response.bodyBytes);

    setState(() {
      imageData = filePathAndName;
      dataLoaded = true;
    });
  }

  String imageData;
  bool dataLoaded = false;

  @override
  Widget build(BuildContext context) {

    if (dataLoaded) {
      return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.file(File(imageData), width: 600.0, height: 290.0)
            ],
          ),
        ),
      );
    } else {
      return CircularProgressIndicator(
        backgroundColor: Colors.cyan,
        strokeWidth: 5,
      );
    }
  }
}