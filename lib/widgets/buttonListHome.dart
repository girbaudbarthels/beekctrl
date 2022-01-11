import 'package:beekctrl/blocs/camera_bloc.dart';
import 'package:beekctrl/blocs/location_bloc.dart';
import 'package:beekctrl/blocs/theme.dart';
import 'package:beekctrl/pages/camera.dart';
import 'package:beekctrl/pages/kaart.dart';
import 'package:beekctrl/widgets/ButtonHomeCard.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ButtonList extends StatelessWidget {
  const ButtonList({
    Key key,
    @required this.size,
    @required ThemeChanger themeChanger,
    @required this.panelcontroller,
  })  : _themeChanger = themeChanger,
        super(key: key);

  final double size;
  final ThemeChanger _themeChanger;
  final panelcontroller;

  @override
  Widget build(BuildContext context) {
    CameraBloc _camera = Provider.of<CameraBloc>(context);
    Upload _upload = Provider.of<Upload>(context);

    return Expanded(
      child: LayoutBuilder(builder: (builder, constraintst) {
        var sizeExpanded = constraintst.maxHeight - size * 8;
        var sizeWidth = constraintst.maxWidth;
        return Container(
          margin: EdgeInsets.all(size * 4),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              InkWell(
                onTap: () {
                  _themeChanger.panCtrl.open();
                },
                child: ButtonCardHome(
                    sizeExpanded: sizeExpanded,
                    sizeWidth: sizeWidth,
                    string: 'MELDHISTORIE',
                    subString: 'Bekijk jouw meldingen',
                    color1: _themeChanger.colorMain,
                    color2: _themeChanger.colorMainDark,
                    icon: Icons.notifications),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Kaart()));
                },
                child: ButtonCardHome(
                    sizeExpanded: sizeExpanded,
                    sizeWidth: sizeWidth,
                    string: 'OPEN DE KAART',
                    subString: 'Meldingen in jouw buurt',
                    color1: _themeChanger.colorSec,
                    color2: _themeChanger.colorSecDark,
                    icon: Icons.map),
              ),
              InkWell(
                onTap: () {
                  _camera.reset();

                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => CameraApp()));
                },
                child: ButtonCardHome(
                    sizeExpanded: sizeExpanded,
                    sizeWidth: sizeWidth,
                    color1: _themeChanger.colorMain,
                    color2: _themeChanger.colorMainDark,
                    string: 'SCAN EEN BEEK',
                    subString: 'Breng een beek in kaart',
                    icon: Icons.camera),
              ),
            ],
          ),
        );
      }),
    );
  }
}
