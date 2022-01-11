import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

class ImagePage extends StatelessWidget {
  const ImagePage({Key key, @required this.url, @required this.hero})
      : super(key: key);
  final String url;
  final String hero;
  @override
  Widget build(BuildContext context) {
        var sizeHeight = MediaQuery.of(context).size.height / 100;
    var sizeWidth = MediaQuery.of(context).size.width / 100;
    return Scaffold(
      body: Container(
          child: Stack(
        children: [
          Center(
            child: Container(
              height: sizeHeight*100,
              width: sizeWidth*100,
              child: Hero(
                tag: hero,
                child: ExtendedImage.network(
                  url,
                  cache: true,
                  enableSlideOutPage: true,
                  mode: ExtendedImageMode.gesture,
                  initGestureConfigHandler: (state) {
                    return GestureConfig(
                      minScale: 0.9,
                      animationMinScale: 0.7,
                      maxScale: 30.0,
                      animationMaxScale: 30.5,
                      speed: 1.0,
                      inertialSpeed: 10.0,
                      initialScale: 1.0,
                      inPageView: false,
                      initialAlignment: InitialAlignment.center,
                    );
                  },
                ),
              ),
            ),
          ),
          SafeArea(
            child: IconButton(
              color: Colors.white,
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () {
                print('bss');
                Navigator.pop(context);
              },
            ),
          )
        ],
      )),
    );
  }
}
