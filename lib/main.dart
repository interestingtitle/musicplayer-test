import 'package:flutter/material.dart';
import 'package:http/http.dart' show get;
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:audioplayer/audioplayer.dart';

void main() => runApp(MyApp());
AudioPlayer playAudio = AudioPlayer();
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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


    var downloadLocation ='/storage/emulated/0/testDownload/images';  //Local downloading location


    var imgUrl = "http://51.145.250.32/Download/CreateLink/0RFKXHOX"; // <-- Image Link
    var imgResponse = await get(imgUrl);



    var mp3fileExists=File(downloadLocation+'/test.mp3').existsSync();

    var directoryExists=Directory(downloadLocation).existsSync();

    //File downloading through http

    await Directory(downloadLocation).create(recursive: true);
    var writeImg = new File(downloadLocation+'/pic.png');
    var writeMp3 = new File(downloadLocation+'/test.mp3');
    if(mp3fileExists==false)
      {
        var mp3Url = "http://51.145.250.32/Download/CreateLink/MEBGL02V"; // <-- Mp3 Link
        var mp3Response = await get(mp3Url);
        writeMp3.writeAsBytesSync(mp3Response.bodyBytes);
      }

    writeImg.writeAsBytesSync(imgResponse.bodyBytes);

    //

    setState(() {
      imageData = '/storage/emulated/0/testDownload/images/pic.png';
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
          centerTitle: true,

          title: Text('AudioTestApp'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.file(File(imageData), width: 600.0, height: 290.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FlatButton(
                    child: Icon(
                      Icons.play_arrow,
                    ),
                    onPressed: (){
                      setState(() {
                        playAudio.play('/storage/emulated/0/testDownload/images/test.mp3');
                      });
                    },
                  ),
                  FlatButton(
                    child: Icon(
                      Icons.pause,
                    ),
                    onPressed: (){
                      setState(() {
                        playAudio.pause();
                      });
                    },
                  ),
                  FlatButton(
                    child: Icon(
                      Icons.stop,
                    ),
                    onPressed: (){
                      setState(() {
                        playAudio.stop();
                      });
                    },
                  )
                ],
              ),

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