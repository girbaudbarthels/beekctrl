import 'package:beekctrl/blocs/theme.dart';
import 'package:beekctrl/pages/imagePage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:google_fonts/google_fonts.dart';

class MeldhistoriePanel extends StatelessWidget {
  const MeldhistoriePanel({
    Key key,
    @required this.sizeHeight,
    @required this.fetchList,
    @required ThemeChanger themeChanger,
    @required this.sizeWidth,
  })  : _themeChanger = themeChanger,
        super(key: key);

  final double sizeHeight;
  final Future<QuerySnapshot> fetchList;
  final ThemeChanger _themeChanger;
  final double sizeWidth;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            height: sizeHeight * 80,
            child: FutureBuilder(
                future: fetchList,
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                    return Container(
                      margin: EdgeInsets.only(top: 20),
                      child: new ListView(
                        padding: EdgeInsets.zero,
                        children: snapshot.data.documents
                            .map((DocumentSnapshot document) {
                          Timestamp date = document['uploadDate'];
                          bool litter = document['vervuild'];
                          double conf = document['confidence'];

                          return InkWell(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => ImagePage(
                                    url: document['fotoUrl'],
                                    hero: document['uploadDate'].toString(),
                                  ),
                                ),
                              );
                            },
                            child: new Container(
                              height: sizeHeight * 17,
                              margin: EdgeInsets.only(
                                  bottom: 20, left: 20, right: 20),
                              decoration: BoxDecoration(
                                color: _themeChanger.colorMain,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: sizeWidth * 65.3,
                                    padding:
                                        EdgeInsets.only(left: 20, right: 20),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          height: sizeHeight * 8,
                                          width: sizeWidth * 14,
                                          child: Stack(
                                            children: [
                                              Align(
                                                alignment:
                                                    Alignment.bottomCenter,
                                                child: Container(
                                                  margin: EdgeInsets.only(
                                                      bottom: sizeHeight * 1),
                                                  height:
                                                      (sizeHeight * 5) * conf,
                                                  width: sizeWidth * 9,
                                                  color: litter
                                                      ? conf < 0.75
                                                          ? Colors.yellow
                                                          : Colors.red
                                                      : Colors.green,
                                                ),
                                              ),
                                              Icon(
                                                FontAwesome.trash_o,
                                                size: sizeHeight * 8,
                                                color: Colors.black,
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          width: sizeWidth * 38,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                '${date.toDate().day}/${date.toDate().month}/${date.toDate().year}',
                                                textScaleFactor: 1,
                                                maxLines: 1,
                                                textAlign: TextAlign.center,
                                                style: GoogleFonts.roboto(
                                                  textStyle: TextStyle(
                                                      fontSize: sizeHeight * 3,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              Text(
                                                document['adres'].toString(),
                                                maxLines: 2,
                                                textScaleFactor: 1,
                                                textAlign: TextAlign.center,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  ClipRRect(
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(12),
                                        bottomRight: Radius.circular(12)),
                                    child: Opacity(
                                      opacity: 0.4,
                                      child: Container(
                                        width: sizeWidth * 15,
                                        height: sizeHeight * 17,
                                        child: Hero(
                                          tag:
                                              document['uploadDate'].toString(),
                                          child: ExtendedImage.network(
                                            document['fotoUrl'],
                                            cache: true,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    );
                  } else {
                    return Container();
                  }
                }),
          ),
        ],
      ),
    );
  }
}
