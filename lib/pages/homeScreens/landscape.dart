import 'package:beekctrl/blocs/theme.dart';
import 'package:beekctrl/widgets/responsiveText.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LandscapeHome extends StatelessWidget {
  const LandscapeHome({
    Key key,
    @required this.size,
    @required ThemeChanger themeChanger,
  })  : _themeChanger = themeChanger,
        super(key: key);

  final double size;
  final ThemeChanger _themeChanger;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: size * 100,
      child: Row(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(left: size * 4, right: size * 4),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
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
              ],
            ),
          ),
          //ButtonList(size: size, themeChanger: _themeChanger)
        ],
      ),
    );
  }
}
