import 'package:flutter/material.dart';
import 'package:animated_analog_clock/animated_analog_clock.dart';
import 'package:cached_network_image/cached_network_image.dart';
class ClockWithCachedImage extends StatefulWidget {
  final String imageUrl;
  final String location;
  ClockWithCachedImage({required this.imageUrl,required this.location , Key? key}) : super(key: key);

  @override
  _ClockWithCachedImageState createState() => _ClockWithCachedImageState();
}

class _ClockWithCachedImageState extends State<ClockWithCachedImage> {

  @override
  Widget build(BuildContext context) {
    final screenRatio = MediaQuery.of(context).devicePixelRatio;
    final textScale=MediaQuery.of(context).textScaleFactor;
    final statusbar_height = MediaQuery.of(context).padding.top;
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return CachedNetworkImage(
      imageUrl: widget.imageUrl,
      imageBuilder: (context, imageProvider) {
        // Image loaded successfully
        return AnimatedAnalogClock(
          size: screenRatio*45,
          backgroundImage: imageProvider, // Use the cached image here!
          dialType: DialType.numberAndDashes,
          numberColor: Colors.black,
          location: widget.location,
        );
      },
      placeholder: (context, url) => Center(
        child: Image.asset(
          'assets/loader.gif',
          width: 100,
          height: 100,
        ),
      ),
      errorWidget: (context, url, error) => Center(
        child: Icon(Icons.error, size: 50, color: Colors.red),
      ),
    );
  }
}
