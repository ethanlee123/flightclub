import 'package:flutter/material.dart';

class BottomDrawer extends StatefulWidget {
  const BottomDrawer({
    Key? key,
  }) : super(key: key);

  @override
  _BottomDrawerState createState() => _BottomDrawerState();
}

class _BottomDrawerState extends State<BottomDrawer> {
  String dropoff = "";
  String eta = "";
  String distance = "";

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
              Container(
                child: Icon(
                  Icons.keyboard_arrow_up,
                  size: 20,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Dropoff: $dropoff',
                      style: Theme.of(context).primaryTextTheme.bodyText2),
                  Text('ETA: $eta',
                      style: Theme.of(context).primaryTextTheme.bodyText2),
                  Text('Distance: $distance',
                      style: Theme.of(context).primaryTextTheme.bodyText2)
                ],
              ),
              SizedBox(height: 50.0),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/checkout');
                  },
                  child: Text('Proceed'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void setDropoff(String dropoff) {
      this.dropoff = dropoff;
  }
}
