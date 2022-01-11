import 'dart:async';

import 'package:beekctrl/blocs/theme.dart';
import 'package:beekctrl/pages/imagePage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class Kaart extends StatefulWidget {
  @override
  _KaartState createState() => _KaartState();
}

class _KaartState extends State<Kaart> {
  final Completer<GoogleMapController> _controller = Completer();

  final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(50.9307, 5.3325),
    zoom: 12,
  );
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  PanelController _panelController = new PanelController();

  Timestamp uploadDate = Timestamp.now();
  String adres = "";
  String fotoUrl = "";
  bool vervuild = false;
  String gebruiker = "";
  double conf = 0.00;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Firestore.instance
          .collection('Meldingen')
          .getDocuments()
          .then((value) => {
                value.documents.forEach((element) {
                  BitmapDescriptor pinLocationIcon;

                  var markerIdVal = UniqueKey().toString();
                  MarkerId markerId = MarkerId(markerIdVal);
                  var latMeld = element.data['location']['lat'];
                  var longMeld = element.data['location']['long'];
                  double vvCijfer = element.data['confidence'];
                  bool isvv = element.data['vervuild'];
                  String path = isvv
                      ? vvCijfer > 0.65
                          ? 'assets/red.png'
                          : 'assets/yellow.png'
                      : vvCijfer < 0.65
                          ? 'assets/yellow.png'
                          : 'assets/green.png';

                  BitmapDescriptor.fromAssetImage(
                          ImageConfiguration(size: Size(10, 10)), '$path',
                          mipmaps: false)
                      .then((onValue) {
                    final Marker marker = Marker(
                      icon: onValue,
                      markerId: markerId,
                      position: LatLng(latMeld, longMeld),
                      onTap: () {
                        setState(() {
                          adres = element.data['adres'];
                          vervuild = element.data['vervuild'];
                          fotoUrl = element.data['fotoUrl'];
                          gebruiker = element.data['gebruiker'];
                          uploadDate = element.data['uploadDate'];
                          conf = element.data['confidence'];
                        });
                        _panelController.open();
                      },
                    );
                    setState(() {
                      markers[markerId] = marker;
                    });
                  });
                })
              });
    });
  }

  @override
  Widget build(BuildContext context) {
    ThemeChanger _themeChanger = Provider.of<ThemeChanger>(context);
    var sizeHeight = MediaQuery.of(context).size.height / 100;
    var sizeWidth = MediaQuery.of(context).size.width / 100;
    return new Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            mapType: MapType.normal,
            myLocationEnabled: true,
            markers: Set<Marker>.of(markers.values),
            initialCameraPosition: _kGooglePlex,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: FloatingActionButton(
                child: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                backgroundColor: _themeChanger.colorSec,
              ),
            ),
          ),
          SlidingUpPanel(
            defaultPanelState: PanelState.CLOSED,
            backdropEnabled: true,
            minHeight: 0,
            maxHeight: sizeHeight * 90,
            borderRadius: _themeChanger.borderTop,
            controller: _panelController,
            margin: EdgeInsets.only(
              left: sizeWidth * 5,
              right: sizeWidth * 5,
            ),
            panel: KaartPanel(
              uploadDate: uploadDate,
              adres: adres,
              vervuild: vervuild,
              gebruiker: gebruiker,
              fotoUrl: fotoUrl,
              conf: conf,
            ),
          )
        ],
      ),
    );
  }
}

class KaartPanel extends StatelessWidget {
  const KaartPanel(
      {Key key,
      @required this.uploadDate,
      @required this.adres,
      @required this.vervuild,
      @required this.gebruiker,
      @required this.fotoUrl,
      @required this.conf})
      : super(key: key);

  final Timestamp uploadDate;
  final String adres;
  final bool vervuild;
  final String gebruiker;
  final String fotoUrl;
  final double conf;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        var height = constraints.maxHeight / 100;
        var width = constraints.maxWidth;
        print(height);
        return ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Container(
            height: height * 100,
            width: width,
            child: Column(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => ImagePage(
                            url: fotoUrl, hero: uploadDate.toString()),
                      ),
                    );
                  },
                  child: Hero(
                    tag: uploadDate.toString(),
                    child: Container(
                        height: height * 55,
                        width: width,
                        child: ExtendedImage.network(
                          fotoUrl,
                          fit: BoxFit.cover,
                          cache: true,
                        )),
                  ),
                ),
                SafeArea(
                  child: Container(
                    height: height * 35,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          height: height * 20,
                          width: width,
                          child: Stack(
                            children: [
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: Container(
                                  margin: EdgeInsets.only(bottom: height * 2),
                                  height: (height * 13) * conf,
                                  width: width / 4,
                                  color: vervuild
                                      ? conf < 0.75
                                          ? Colors.yellow
                                          : Colors.red
                                      : Colors.green,
                                ),
                              ),
                              Center(
                                child: Icon(
                                  FontAwesome.trash_o,
                                  size: height * 20,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                            width: width / 1.5,
                            child: Text(
                              adres,
                              textAlign: TextAlign.center,
                              textScaleFactor: 1,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: height * 3,
                                  fontWeight: FontWeight.bold),
                            )),
                        Container(
                          width: width / 1.5,
                          child: Text(
                            '${uploadDate.toDate().day}/${uploadDate.toDate().month}/${uploadDate.toDate().year}',
                            textAlign: TextAlign.center,
                            textScaleFactor: 1,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: height * 2.5,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
