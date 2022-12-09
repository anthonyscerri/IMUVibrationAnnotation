// ignore: import_of_legacy_library_into_null_safe
import 'dart:async';
import 'dart:io';

import 'package:location/location.dart';
import 'package:path_provider/path_provider.dart';
import 'package:ssh/ssh.dart';

Location location = Location();
int _dateTime = 0;
int _phoneTime = 0;
int _timeDiff = 0;
double _lat = 0;
double _long = 0;
double _speed = 0;

class Util {
  Util() {
    changeSettings();
    _startLocation();
  }
  //File writer
  _write(String text) async {
    var directory = await getExternalStorageDirectory();
    final File file = File('${directory!.path}/vib_ann.txt');
    await file.writeAsString(text, mode: FileMode.append);
  }

  Future<bool> changeSettings(
      {LocationAccuracy accuracy = LocationAccuracy.high,
      int interval = 1,
      double distanceFilter = 0}) async {
    bool change = await location.changeSettings();
    return change;
  }

  _startLocation() {
    location.onLocationChanged.listen((LocationData currentLocation) async {
      if (_dateTime != currentLocation.time!.toInt()) {
        _dateTime = currentLocation.time!.toInt();
        _timeDiff = (_dateTime - DateTime.now().millisecondsSinceEpoch.toInt());
      }
      _dateTime = currentLocation.time!.toInt();
      _lat = currentLocation.latitude!;
      _long = currentLocation.longitude!;
      _speed = currentLocation.speed!;
    });
  }

  getLocation(int roadDefect, int phoneTime) async {
    _write(_dateTime.toString() +
        ',' +
        phoneTime.toString() +
        ',' +
        _timeDiff.toString() +
        ',' +
        _lat.toString() +
        ',' +
        _long.toString() +
        ',' +
        _speed.toString() +
        ',' +
        roadDefect.toString() +
        '\n');
  }

  void transferFileSFTP() async {
    var directory = await getExternalStorageDirectory();
    final File file = File('${directory!.path}/vib_ann.txt');

    var client = new SSHClient(
      host: "192.168.1.230",
      port: 22,
      username: "sftpmr",
      passwordOrKey: "MaltaMalta123",
    );
    await client.connect();
    await client.connectSFTP();

    await client.sftpUpload(
      path: file.path.toString(),
      toPath: "./sftpmr/",
      callback: (progress) {
        print(progress); // read upload progress
      },
    );
    await client.disconnectSFTP();
  }

  @override
  void initState() {
    _startLocation();
    // TODO: implement initState
  }
}
