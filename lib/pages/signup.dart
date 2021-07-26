import 'package:flutter/material.dart';

class SignUp extends StatelessWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.fromLTRB(0.0, 30.0, 00.0, 0),
          width: MediaQuery.of(context).size.width,
          // height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                color: Theme.of(context).backgroundColor,
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      child: Container(
                        padding: EdgeInsets.only(top: 20.0),
                        color: Theme.of(context).primaryColor,
                      ),
                      bottom: 0,
                      width: MediaQuery.of(context).size.width,
                    ),
                    Image.asset(
                      'assets/images/mountains.png',
                    ),
                    Align(
                      child: Column(
                        children: [
                          Text('flightclub'.toUpperCase(),
                              style:
                                  Theme.of(context).accentTextTheme.headline3),
                          ImageIcon(
                            AssetImage('assets/images/drone_art.png'),
                            size: 100.0,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Flexible(
                flex: 2,
                child: Container(
                  padding: EdgeInsets.fromLTRB(40.0, 20.0, 40.0, 0),
                  width: MediaQuery.of(context).size.width,
                  // height: MediaQuery.of(context).size.height,
                  // color: Theme.of(context).primaryColor,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    //   mainAxisAlignment: MainAxisAlignment.
                    children: <Widget>[
                      Text('Hey! Sign Up \nto get started.',
                          style: Theme.of(context).primaryTextTheme.bodyText1),
                      SizedBox(height: 20.0),
                      TextField(
                        decoration: InputDecoration(
                          labelText: 'Name',
                        ),
                      ),
                      SizedBox(height: 8.0),
                      TextField(
                        decoration: InputDecoration(
                          labelText: 'Email',
                        ),
                      ),
                      SizedBox(height: 8.0),
                      TextField(
                        decoration: InputDecoration(
                          labelText: 'password',
                        ),
                      ),
                      SizedBox(height: 8.0),
                      ElevatedButton(
                        onPressed: () {},
                        child: Text('Sign up'.toUpperCase()),
                      ),
                      SizedBox(height: 8.0),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('Already Have An Account? Login'),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
