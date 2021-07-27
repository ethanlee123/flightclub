import 'package:flutter/material.dart';

class BottomDrawer extends StatefulWidget {
  const BottomDrawer({Key? key}) : super(key: key);

  @override
  _BottomDrawerState createState() => _BottomDrawerState();
}

class _BottomDrawerState extends State<BottomDrawer> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height / 5;
    double width = MediaQuery.of(context).size.width;
    return ClipRRect(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
      child: Container(
        color: Theme.of(context).primaryColor,
        width: width,
        height: height + 30,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            children: <Widget>[
              Icon(
                Icons.keyboard_arrow_up,
                size: 20,
                color: Colors.white,
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('ETA: ',
                      style: Theme.of(context).primaryTextTheme.bodyText2),
                  Text('Distance: ',
                      style: Theme.of(context).primaryTextTheme.bodyText2)
                ],
              ),
              SizedBox(
                width: double.infinity,
                child: MaterialButton(
                    onPressed: () {}, color: Theme.of(context).accentColor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
