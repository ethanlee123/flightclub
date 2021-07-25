import 'package:flutter/material.dart';

import 'slide.dart';

class WalkthroughSlides {
  late List<Widget> walkthroughSlides;

  WalkthroughSlides(List<Slide> slides) {
    walkthroughSlides = slides
        .map(
          (slide) => Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                SizedBox(height: 50.0),
                Text(
                  slide.title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 32.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 30.0),
                Image(
                  image: AssetImage(
                    slide.imagePath,
                  ),
                  width: 50.0,
                  height: 200.0,
                ),
                SizedBox(height: 30.0),
                Text(
                  slide.info,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.0,
                  ),
                ),
              ],
            ),
          ),
        )
        .toList();
  }
}
