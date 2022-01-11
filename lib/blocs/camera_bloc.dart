import 'dart:io';

import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';

class CameraBloc extends ChangeNotifier {
  File bl;
  String entiteit;
  int textLabel;
  double confident = 0.000000;
  bool loading = true;
  bool camOpen = false;

  Future getImage() async {
    camOpen = true;
    notifyListeners();
    var image = await ImagePicker.pickImage(source: ImageSource.camera);

    bl = image;
    runOnImage(image);
    notifyListeners();
  }

  void reset() {
    bl = null;
    entiteit = null;
    textLabel = null;
    confident = 0.000000;
    loading = true;
    camOpen = false;
    notifyListeners();
  }

  Future runOnImage(image) async {
    loading = true;
    notifyListeners();
    await Tflite.loadModel(
      model: "assets/model_unquant.tflite",
      labels: "assets/labels.txt",
    );

    var recognitions = await Tflite.runModelOnImage(
        path: image.path, // required
        imageMean: 0.0, // defaults to 117.0
        imageStd: 256.0, // defaults to 1.0
        numResults: 2, // defaults to 5
        threshold: 0.01, // defaults to 0.1
        asynch: true);

    textLabel = recognitions[0]['index'];
    loading = false;
    notifyListeners();
    confident = recognitions[0]['confidence'];

    notifyListeners();
    await Tflite.close();
  }
}
