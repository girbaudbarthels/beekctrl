import 'package:beekctrl/widgets/responsiveText.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ButtonCardHome extends StatelessWidget {
  const ButtonCardHome({
    Key key,
    @required this.sizeExpanded,
    @required this.sizeWidth,
    @required this.string,
    @required this.subString,
    @required this.icon,
    @required this.color1,
    @required this.color2,
  }) : super(key: key);

  final double sizeExpanded;
  final double sizeWidth;
  final String string;
  final String subString;
  final IconData icon;
  final Color color1;
  final Color color2;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10),
      height: sizeExpanded / 3 - 20,
      width: sizeWidth,
      decoration:
          BoxDecoration(color: color1, borderRadius: BorderRadius.circular(12)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: ResponsiveText(
                    string: string,
                    style: GoogleFonts.roboto(
                        fontWeight: FontWeight.bold, letterSpacing: 2),
                    size: sizeExpanded / 17),
              ),
              SizedBox(height: sizeExpanded/40,),
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: ResponsiveText(
                    string: subString,
                    style: GoogleFonts.roboto(
                        fontWeight: FontWeight.bold, letterSpacing: 2),
                    size: sizeExpanded / 25),
              ),
            ],
          ),
          Stack(
            alignment: Alignment.centerRight,
            children: <Widget>[
              Align(
                alignment: Alignment.centerRight,
                child: Container(
                  height: sizeExpanded / 3 - 20,
                  width: sizeExpanded / 10,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(12),
                          bottomRight: Radius.circular(12)),
                      color: color2),
                ),
              ),
              Icon(
                icon,
                size: sizeExpanded / 7,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
