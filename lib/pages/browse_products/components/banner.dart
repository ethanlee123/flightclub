import 'package:flutter/material.dart';
import 'package:page_indicator/page_indicator.dart';

class Banners extends StatefulWidget {
  const Banners({Key? key,
  }) : super(key: key);

  @override
  _BannersState createState() => _BannersState();
}

class _BannersState extends State<Banners> with SingleTickerProviderStateMixin {
  late PageController controller;
  GlobalKey<PageContainerState> key = GlobalKey();
  
  final List<Widget> _banners = List.generate(
    3,
    (index) => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: Image.asset(
        'assets/images/vegs_banner.png',
        fit: BoxFit.fill,
      ),
    ),
  );

  @override
  void initState() {
    controller = PageController();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.23,  
      width: MediaQuery.of(context).size.width,    
      child: PageIndicatorContainer(
        child: PageView(
            children: _banners,
            controller: controller,
        ),
        align: IndicatorAlign.bottom,
        length: 3,
        indicatorSpace: 5.0,
        padding: const EdgeInsets.all(12),
        indicatorColor: Theme.of(context).backgroundColor,
        indicatorSelectorColor: Theme.of(context).accentColor,
        shape: IndicatorShape.circle(size: 8),
      ),
    );
  }
}