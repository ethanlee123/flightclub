import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

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
                                  Theme.of(context).primaryTextTheme.headline4),
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
                      Text('Hello, Again!\nWelcome\nBack',
                          style: Theme.of(context).primaryTextTheme.subtitle1),
                      SizedBox(height: 20.0),
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
                        child: Text('login'.toUpperCase()),
                      ),
                      SizedBox(height: 8.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          TextButton(
                            onPressed: () {},
                            child: Text('Forgot Your Password'),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/signup');
                            },
                            child: Text('Sign up'),
                          ),
                        ],
                      )
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
