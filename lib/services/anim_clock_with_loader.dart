import 'package:flutter/material.dart';
import 'package:animated_analog_clock/animated_analog_clock.dart';
import 'package:cached_network_image/cached_network_image.dart';
class ClockWithCachedImage extends StatefulWidget {
  final String imageUrl;
  ClockWithCachedImage({required this.imageUrl, Key? key}) : super(key: key);

  @override
  _ClockWithCachedImageState createState() => _ClockWithCachedImageState();
}

class _ClockWithCachedImageState extends State<ClockWithCachedImage> {

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: widget.imageUrl,
      imageBuilder: (context, imageProvider) {
        // Image loaded successfully
        return AnimatedAnalogClock(
          size: 200,
          backgroundImage: imageProvider, // Use the cached image here!
          dialType: DialType.numberAndDashes,
          numberColor: Colors.black,
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
