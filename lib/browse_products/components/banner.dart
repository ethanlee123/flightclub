import 'package:flutter/material.dart';
import 'package:page_indicator/page_indicator.dart';

// import '../../../constants.dart';
// import '../../../mq.dart';


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
        length: 4,
        indicatorSpace: 5.0,
        padding: const EdgeInsets.all(12),
        indicatorColor: Theme.of(context).backgroundColor,
        indicatorSelectorColor: Theme.of(context).accentColor,
        shape: IndicatorShape.circle(size: 8),
        // shape: IndicatorShape.roundRectangleShape(size: Size.square(12),cornerSize: Size.square(3)),
        // shape: IndicatorShape.oval(size: Size(12, 8)),
      ),
    );
  }
}

// class PageIndicator extends StatefulWidget {
//   final int index;  
//   final TabController controller;
//   const PageIndicator({
//     Key? key, required this.index, required this.controller,
//   }) : super(key: key);

//   @override
//   _PageIndicatorState createState() => _PageIndicatorState();
// }

// class _PageIndicatorState extends State<PageIndicator> {

//   late bool _expanded;

//   @override
//   void initState() {    
//     super.initState();
//     _expanded = widget.index == widget.controller.index;

//     // add listener to tabcontroller to update page indicator size
//     widget.controller.addListener(() { 
//       setState(() {
//         _expanded = widget.index == widget.controller.index;
//       });
//     });

//   }

//   @override
//   Widget build(BuildContext context) {
//     return AnimatedContainer(
//       duration: Duration(milliseconds: 300),      
//       width: _expanded ? 15 : 5,
//       height: 5,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(15),      
//         color: _expanded ? Colors.black : Colors.grey,
//       ),
//     );
//   }
// }
