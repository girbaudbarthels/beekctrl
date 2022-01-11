import 'package:flutter/material.dart';

class ResponsiveText extends StatelessWidget {
  const ResponsiveText({
    Key key,
    @required this.size,
    @required this.string,
    @required this.style,
  }) : super(key: key);

  final double size;
  final String string;
  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      child: FittedBox(
        fit: BoxFit.contain,
        child: Text(
          string,
          style: style == null ? TextStyle() : style,
        ),
      ),
    );
  }
}
