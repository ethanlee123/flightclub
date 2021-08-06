import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'components/slide.dart';
import 'components/walkthrough_slides.dart';

final List<Slide> slides = [
  Slide(
    title: "Choose a drop off point.",
    imagePath: "assets/images/city.png",
    info:
        "Drop off points are currently restricted to open air drop off points.",
    key: 0,
  ),
  Slide(
      title: "Enter package details.",
      imagePath: "assets/images/packages.png",
      info:
          "Our maximum payload is 3.9 lbs (1.8 kg). \n\nOur maximum distance at max. cargo capacity is TBD.  \n\n\nDisclaimer: individual mileage may vary",
      key: 1),
  Slide(
      title: "Watch your package be delivered live!",
      imagePath: "assets/images/mobile_map.png",
      info: "Track the movements of your package live within our app.",
      key: 2),
];

class Walkthrough extends StatelessWidget {
  // const Walkthrough({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80.0),
        child: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          flexibleSpace: Align(
            child: Text(
              'flightclub'.toUpperCase(),
              style: Theme.of(context).primaryTextTheme.headline3,
            ),
          ),
        ),
      ),
      body: Container(
        child: CarouselWithIndicator(),
      ),
    );
  }
}

class CarouselWithIndicator extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _Carousel();
  }
}

class _Carousel extends State<CarouselWithIndicator> {
  int _current = 0;
  final CarouselController _controller = CarouselController();

  WalkthroughSlides walkthroughSliders = WalkthroughSlides(slides);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).accentColor,
      body: Container(
        padding: EdgeInsets.fromLTRB(20.0, 0, 20.0, 15.0),
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 2,
                offset: Offset(0, 0),
              ),
            ],
            color: Theme.of(context).primaryColor,
            border: Border.all(
              color: Theme.of(context).primaryColor,
            ),
            borderRadius: BorderRadius.vertical(top: Radius.circular(70))),
        child: Column(
        children: [
          Expanded(
            child: CarouselSlider(
              items: walkthroughSliders.walkthroughSlides,
              carouselController: _controller,
              options: CarouselOptions(
                  height: MediaQuery.of(context).size.height,
                  enlargeCenterPage: true,
                  enableInfiniteScroll: false,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _current = index;
                    });
                  }),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Row(
                  children: slides.map((entry) {
                    return GestureDetector(
                      child: Container(
                        width: 12.0,
                        height: 12.0,
                        margin: EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 4.0),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color:
                                (Theme.of(context).brightness == Brightness.dark
                                    ? Color(0xFF284B63)
                                    : Color(0xFF284B63).withOpacity(
                                        _current == entry.key ? 0.9 : 0.4))),
                      ),
                    );
                  }).toList(),
                ),
              ),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/login');
                  },
                  child: Text('Get Started'.toUpperCase()),
                ),
              ),
            ],
          ),
        ]),
      ),
    );
  }
}
