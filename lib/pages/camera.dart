import 'package:beekctrl/blocs/camera_bloc.dart';
import 'package:beekctrl/blocs/theme.dart';
import 'package:beekctrl/pages/overview.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CameraApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    CameraBloc _camera = Provider.of<CameraBloc>(context);
    ThemeChanger _themeChanger = Provider.of<ThemeChanger>(context);

    if (_camera.bl == null && _camera.camOpen == false) {
      //Navigator.pop(context);
      _camera.getImage();
      return Scaffold(
        backgroundColor: _themeChanger.colorBg,
        body: Center(
          child: Container(
              height: 100, width: 100, child: CircularProgressIndicator()),
        ),
      );
    } else {
      if (_camera.camOpen == true && _camera.bl == null) {
        Navigator.pop(context);
        return Scaffold(
          backgroundColor: _themeChanger.colorBg,
          body: Center(
            child: Container(
                height: 100, width: 100, child: CircularProgressIndicator()),
          ),
        );
      }
      if (_camera.loading) {
        return Scaffold(
          backgroundColor: _themeChanger.colorBg,
          body: Center(
            child: Container(
                height: 100, width: 100, child: CircularProgressIndicator()),
          ),
        );
      } else {
        return Overview();
      }
    }
  }
}
