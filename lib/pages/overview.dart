import 'package:beekctrl/blocs/camera_bloc.dart';
import 'package:beekctrl/blocs/location_bloc.dart';
import 'package:beekctrl/blocs/panel_bloc.dart';
import 'package:beekctrl/blocs/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class Overview extends StatefulWidget {
  @override
  _OverviewState createState() => _OverviewState();
}

class _OverviewState extends State<Overview> with TickerProviderStateMixin {
  PanelController _panelController = new PanelController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _panelController.open();
    });
  }

  @override
  Widget build(BuildContext context) {
    CameraBloc _camera = Provider.of<CameraBloc>(context);
    ThemeChanger _themeChanger = Provider.of<ThemeChanger>(context);
    PanelBloc _panelBloc = Provider.of<PanelBloc>(context);
    Upload _upload = Provider.of<Upload>(context);
    final mqData = MediaQuery.of(context);
    final mqDataNew = mqData.copyWith(
        textScaleFactor:
            mqData.textScaleFactor > 1.0 ? 1.0 : mqData.textScaleFactor);
    return Scaffold(
      backgroundColor: _themeChanger.colorBg,
      resizeToAvoidBottomInset: false,
      body: InkWell(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: LayoutBuilder(
          builder: (builder, constraints) {
            var orientation = constraints.maxWidth > 600;
            var size = !orientation
                ? constraints.maxHeight / 100
                : constraints.maxWidth / 100;

            var sizeWidth = orientation
                ? constraints.maxHeight / 100
                : constraints.maxWidth / 100;

            print('${size * 20} BLABLAdzadz');
            return Stack(
              children: <Widget>[
                SafeArea(
                  child: Padding(
                    padding: EdgeInsets.all(size * 3),
                    child: ClipRRect(
                      borderRadius: _themeChanger.border,
                      child: Container(
                        height: size * 100,
                        width: sizeWidth * 100,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                          image: FileImage(_camera.bl),
                          fit: BoxFit.cover,
                        )),
                      ),
                    ),
                  ),
                ),
                SlidingUpPanel(
                  defaultPanelState: PanelState.CLOSED,
                  backdropEnabled: true,
                  minHeight: size * 8,
                  maxHeight: size * 75,
                  borderRadius: _themeChanger.borderTop,
                  controller: _panelController,
                  onPanelOpened: () {
                    _upload.getLoc();

                    if (_panelController.isPanelOpen) {
                      _panelBloc.setHeight(
                          size, _camera.confident, _camera.textLabel);
                    }
                  },
                  margin: EdgeInsets.only(
                    left: size * 5,
                    right: size * 5,
                  ),
                  panel: MediaQuery(
                    data: mqData,
                    child: Scaffold(
                      backgroundColor: Colors.transparent,
                      resizeToAvoidBottomInset: true,
                      body: InkWell(
                        onTap: () {
                          FocusScope.of(context).requestFocus(FocusNode());
                        },
                        child: Container(
                          padding: EdgeInsets.only(left: 20, right: 20),
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  height: size * 25,
                                  child: Stack(
                                    children: <Widget>[
                                      Container(
                                        height: size * 25,
                                        margin:
                                            EdgeInsets.only(bottom: size * 3.5),
                                        child: Align(
                                          alignment: Alignment.bottomCenter,
                                          child: AnimatedSize(
                                            curve: Curves.fastOutSlowIn,
                                            duration: new Duration(
                                                milliseconds: 1500),
                                            child: Container(
                                              color: _panelBloc.sizeAnim <
                                                      size * 5
                                                  ? _themeChanger.colorSec
                                                  : _panelBloc.sizeAnim >
                                                              size * 5 &&
                                                          _panelBloc.sizeAnim <
                                                              size * 10
                                                      ? _themeChanger.colorBg
                                                      : _themeChanger.colorRed,
                                              height: _panelBloc.sizeAnim,
                                              width: sizeWidth * 30,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Center(
                                        child: Icon(
                                          FontAwesome.trash_o,
                                          color: Colors.black,
                                          size: size * 25,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Column(
                                  children: [
                                    Text(
                                      'Jouw Melding',
                                      textScaleFactor: 1,
                                      style: GoogleFonts.roboto(
                                          color: Colors.black,
                                          fontSize: size * 4,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      _upload.first == null
                                          ? ""
                                          : _upload.first,
                                      textScaleFactor: 1,
                                      maxLines: 2,
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.roboto(
                                          color: Colors.black,
                                          fontSize: size * 2,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(height: size * 5),
                                    Container(
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.black, width: 2),
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 15.0),
                                        child: TextFormField(
                                          textCapitalization:
                                              TextCapitalization.sentences,
                                          controller: _upload.texController,
                                          maxLines: 6,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: size * 2),
                                          decoration: InputDecoration(
                                              enabledBorder: InputBorder.none,
                                              border: InputBorder.none,
                                              hintText:
                                                  'Geef hier extra informatie...',
                                              hintStyle: TextStyle(
                                                  color: Colors.black38,
                                                  fontSize: size * 2)),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SafeArea(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        width: sizeWidth * 34,
                                        height: size * 6,
                                        child: MaterialButton(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12)),
                                          color: Colors.red,
                                          child: Text(
                                            'Annuleer',
                                            textScaleFactor: 1,
                                            style: TextStyle(
                                                fontSize: size * 2,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                        ),
                                      ),
                                      Container(
                                        width: sizeWidth * 34,
                                        height: size * 6,
                                        child: MaterialButton(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12)),
                                          color: _themeChanger.colorSec,
                                          child: !_upload.upping
                                              ? Text(
                                                  'Opslaan',
                                                  textScaleFactor: 1,
                                                  style: TextStyle(
                                                      fontSize: size * 2,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )
                                              : CircularProgressIndicator(),
                                          onPressed: () {
                                            _upload.uploadImage(
                                                _camera.bl,
                                                _camera.textLabel,
                                                _camera.confident,
                                                context);
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
