import 'package:flutter/material.dart';
import 'package:mito/pages/registration_page.dart';
import 'package:mito/pages/login_page.dart';

class HomePage extends StatefulWidget {
  static const navigateToRegistrationButtonKey = Key('navigateToRegistration');
  static const navigateToLoginButtonKey = Key('navigateToLogin');
  @override
  const HomePage({ Key key }) : super(key: key);
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void _navigateToRegistrationPage(BuildContext context) {
    final route = MaterialPageRoute(builder: (_) => RegistrationPage());
    Navigator.of(context).push(route);
  }
  void _navigateToLoginPage(BuildContext context) {
    final route = MaterialPageRoute(builder: (_) => LoginPage());
    Navigator.of(context).push(route);
  }

  @override
  Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Welcome to MITO'),
        ),
        body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Flexible(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(40.0, 40.0, 40.0, 200.0),
                    child: Text(
                      'Help Those Around You',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 36.0,
                        ),
                      ),
                    ),
                  ),
                  ButtonTheme(
                      minWidth: 200.0,
                      height: 40.0,
                      child: RaisedButton(
                        key: HomePage.navigateToLoginButtonKey,
                        onPressed: () => _navigateToLoginPage(context),
                        child: Text(
                          'LOGIN',
                          style: TextStyle(
                            fontSize: 18.0,
                          ),
                        ),
                        color: Colors.red,
                        textColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius:
                          BorderRadius.circular(30.0)),
                      ),
                  ),
                  SizedBox(height: 5.0),
                  ButtonTheme(
                    minWidth: 200.0,
                    height: 40.0,
                    child: RaisedButton(
                      key: HomePage.navigateToRegistrationButtonKey,
                      onPressed: () => _navigateToRegistrationPage(context),
                      child: Text(
                        'SIGN UP',
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                      color: Colors.white,
                      textColor: Colors.red,
                      shape: RoundedRectangleBorder(borderRadius:
                        BorderRadius.circular(30.0)),
                    ),
                  ),
              ],
            ),// Column
          ),// Center
      );// Scaffold
  }
}
