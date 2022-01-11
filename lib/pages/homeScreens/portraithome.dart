import 'package:beekctrl/blocs/theme.dart';
import 'package:beekctrl/widgets/buttonListHome.dart';
import 'package:beekctrl/widgets/responsiveText.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PortraitHome extends StatelessWidget {
  const PortraitHome({
    Key key,
    @required this.size,
    @required this.panelcontroller,
    @required ThemeChanger themeChanger,
  })  : _themeChanger = themeChanger,
        super(key: key);

  final double size;
  final ThemeChanger _themeChanger;
  final panelcontroller;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: size * 2),
                height: size * 20,
                width: size * 20,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Image.asset('assets/logo.png'),
                ),
              ),
              ResponsiveText(
                size: size * 8,
                string: 'Beekctrl',
                style: GoogleFonts.baloo(
                    letterSpacing: 1,
                    fontWeight: FontWeight.normal,
                    color: Colors.black),
              ),
              ResponsiveText(
                size: size * 3,
                string: 'Meld zwerfvuil in beken!',
                style: GoogleFonts.roboto(
                    fontWeight: FontWeight.bold, color: Colors.black),
              ),
              ButtonList(
                  size: size,
                  themeChanger: _themeChanger,
                  panelcontroller: panelcontroller)
            ],
          ),
        ),
      ],
    );
  }
}
