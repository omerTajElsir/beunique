import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:responsive_widgets/responsive_widgets.dart';

class FullScreenImage extends StatefulWidget {
  final String pic;
  FullScreenImage({this.pic});
  @override
  _FullScreenImageState createState() => _FullScreenImageState();
}

class _FullScreenImageState extends State<FullScreenImage> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
//  set the screen based on the sized of the device on the XD file
    ResponsiveWidgets.init(
      context,
      height: 812.0,
      width: 375.0,
      allowFontScaling: true,
    );
    return ResponsiveWidgets.builder(
        height: 812.0,
        width: 375.0,
        allowFontScaling: true,
        child: Scaffold(
            body: Stack(
          children: [
            CachedNetworkImage(
              imageUrl: widget.pic,
              fit: BoxFit.fill,
              height: height,
              width: width,
              placeholder: (context, url) => new CircularProgressIndicator(
                valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
              ),
              errorWidget: (context, url, error) => new Icon(Icons.error),
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            ContainerResponsive(),
          ],
        )));
  }
}
