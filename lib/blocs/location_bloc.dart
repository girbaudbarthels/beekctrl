import 'dart:async';
import 'dart:io';

import 'package:beekctrl/pages/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_info/device_info.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:location/location.dart';

class Upload extends ChangeNotifier {
  double lat;
  double long;
  String refUrl;
  String devid;
  var adres;
  var first;

  bool upping = false;
  TextEditingController texController = new TextEditingController();
  Future<String> geoCode(lat, long) async {
    final coordinates = new Coordinates(lat, long);
    adres = await Geocoder.local.findAddressesFromCoordinates(coordinates);
    first = adres.first.addressLine;
    notifyListeners();
  }

  Future getLoc() async {
    Location location = new Location();

    var _locationData = await location.getLocation();
    lat = _locationData.latitude;
    long = _locationData.longitude;

    getDevId();
    geoCode(lat, long);
    notifyListeners();
  }

  Future getDevId() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      print('Running on ${androidInfo.id}');
      devid = androidInfo.id.toString();
      notifyListeners();
    } else {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      devid = iosInfo.identifierForVendor.toString();
      notifyListeners();
      print('Running on ${iosInfo.identifierForVendor}');
    }
  }

  Future uploadImage(foto, index, confidence, context) async {
    upping = true;
    notifyListeners();
    final StorageReference storageReference = index == 0
        ? FirebaseStorage().ref().child('Beken/proper/${TimeOfDay.now()}')
        : FirebaseStorage().ref().child('Beken/vuil/${TimeOfDay.now()}');

    final StorageUploadTask uploadTask = storageReference.putFile(foto);

    refUrl = await (await uploadTask.onComplete).ref.getDownloadURL();
    notifyListeners();
    upload(index, confidence, context);
  }

  Future upload(index, confidence, context) async {
    var doc = Firestore.instance.collection('Meldingen').document();
    print('upping doc');
    await doc.setData(
      {
        'doc': doc.documentID,
        'location': ({'lat': lat, 'long': long}),
        'fotoUrl': refUrl,
        'uploadDate': Timestamp.now(),
        'vervuild': index == 0 ? false : true,
        'confidence': confidence,
        'gebruiker': devid,
        'adres': first,
        'extraInfo': texController.text
      },
    );

    Navigator.push(
        context, MaterialPageRoute(builder: (context) => HomePage()));
    upping = false;
    notifyListeners();
  }
}
