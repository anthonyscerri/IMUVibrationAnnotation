import 'package:flutter/material.dart';
import 'util/helper.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Vibration Annotation',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Vibration Annotation Home Page'),
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
  Util utl = Util();

  void _recordAnomaly(int roadDefect) {
    int phoneTime = DateTime.now().millisecondsSinceEpoch.toInt();
    utl.getLocation(roadDefect, phoneTime);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Vibration Annotation'),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(
                      25, 60), // takes postional arguments as width and height
                  primary: Colors.blue,
                ),
                child: Text('Dep. \n Left'),
                onPressed: () {
                  _recordAnomaly(1);
                },
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(
                      25, 60), // takes postional arguments as width and height
                  primary: Colors.blue,
                ),
                child: Text('Depression'),
                onPressed: () {
                  _recordAnomaly(3);
                },
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(
                      25, 60), // takes postional arguments as width and height
                  primary: Colors.blue,
                ),
                child: Text('Dep \n Right'),
                onPressed: () {
                  _recordAnomaly(2);
                },
              ),
            ],
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              minimumSize: Size(
                  250, 48), // takes postional arguments as width and height
              primary: Colors.pink,
            ),
            child: Text('Speed Bump'),
            onPressed: () {
              _recordAnomaly(4);
            },
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              minimumSize: Size(
                  250, 48), // takes postional arguments as width and height
              primary: Colors.green,
            ),
            child: Text('Smooth'),
            onPressed: () {
              _recordAnomaly(5);
            },
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              minimumSize: Size(
                  250, 48), // takes postional arguments as width and height
              primary: Colors.purple,
            ),
            child: Text('Transfer File'),
            onPressed: () {
              utl.transferFileSFTP();
            },
          ),
        ],
      )),
    );
  }
}
