import 'package:beekctrl/blocs/camera_bloc.dart';
import 'package:beekctrl/blocs/location_bloc.dart';
import 'package:beekctrl/blocs/theme.dart';
import 'package:beekctrl/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'blocs/panel_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ThemeChanger>(
          create: (_) => ThemeChanger(ThemeData.dark()),
        ),
        ChangeNotifierProvider(
          create: (_) => CameraBloc(),
        ),
        ChangeNotifierProvider(
          create: (_) => PanelBloc(),
        ),
        ChangeNotifierProvider(
          create: (_) => Upload(),
        ),
      ],
      child: MaterialAppWithTheme(),
    );
  }
}

class MaterialAppWithTheme extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeChanger>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: theme.getTheme(),
      home: HomePage(),
    );
  }
}
