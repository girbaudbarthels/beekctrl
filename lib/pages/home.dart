import 'package:beekctrl/blocs/location_bloc.dart';
import 'package:beekctrl/blocs/theme.dart';
import 'package:beekctrl/widgets/MeldHistoriePanel.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:video_player/video_player.dart';

import 'homeScreens/portraithome.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PanelController _panelController = new PanelController();
  VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    // Pointing the video controller to our local asset.
    _controller = VideoPlayerController.asset("assets/bgvid.mp4")
      ..initialize().then((_) {
        // Once the video has been loaded we play the video and set looping to true.
        _controller.play();
        _controller.setLooping(true);
        setState(() {});
        // Ensure the first frame is shown after the video is initialized.
      });
  }

  @override
  Widget build(BuildContext context) {
    ThemeChanger _themeChanger = Provider.of<ThemeChanger>(context);
    Upload loc = Provider.of<Upload>(context);

    var sizeHeight = MediaQuery.of(context).size.height / 100;
    var sizeWidth = MediaQuery.of(context).size.width / 100;
    var fetchList = Firestore.instance
        .collection('Meldingen')
        .where('gebruiker', isEqualTo: loc.devid)
        .orderBy('uploadDate')
        .getDocuments();
    return Scaffold(
      backgroundColor: _themeChanger.colorBg,
      body: Stack(
        children: [
          SizedBox.expand(
            child: FittedBox(
                fit: BoxFit.cover,
                child: SizedBox(
                    width: _controller.value.size?.width ?? 0,
                    height: _controller.value.size?.height ?? 0,
                    child: VideoPlayer(_controller))),
          ),
          Container(
            height: sizeHeight * 100,
            width: sizeWidth * 95,
            decoration: BoxDecoration(
                color: _themeChanger.colorBg,
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(5000),
                  topRight: Radius.circular(5000),
                )),
          ),
          Opacity(
            opacity: 0.7,
            child: Container(
              height: sizeHeight * 100,
              width: sizeWidth * 100,
              decoration: BoxDecoration(
                color: _themeChanger.colorBg,
              ),
            ),
          ),
          SafeArea(
            child: LayoutBuilder(
              builder: (builder, constraints) {
                var orientation = constraints.maxWidth > 600;
                var size = !orientation
                    ? constraints.maxHeight / 100
                    : constraints.maxWidth / 100;

                return PortraitHome(
                    size: size,
                    themeChanger: _themeChanger,
                    panelcontroller: _panelController);
              },
            ),
          ),
          SlidingUpPanel(
            defaultPanelState: PanelState.CLOSED,
            backdropEnabled: true,
            minHeight: 0,
            maxHeight: sizeHeight * 80,
            borderRadius: _themeChanger.borderTop,
            controller: _themeChanger.panCtrl,
            onPanelOpened: () {
              loc.getDevId();
            },
            margin: EdgeInsets.only(
              left: sizeWidth * 5,
              right: sizeWidth * 5,
            ),
            panel: MeldhistoriePanel(
                sizeHeight: sizeHeight,
                fetchList: fetchList,
                themeChanger: _themeChanger,
                sizeWidth: sizeWidth),
          ),
        ],
      ),
    );
  }
}
