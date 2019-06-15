import 'package:flutter/material.dart';
import 'package:mito/pages/registration_page.dart';
import 'package:mito/pages/login_page.dart';
import 'package:mito/pages/home_page.dart';
import 'package:mito/inherited_user_services.dart';

class LandingPage extends StatefulWidget {
  static const navigateToRegistrationButtonKey = Key('navigateToRegistration');
  static const navigateToLoginButtonKey = Key('navigateToLogin');
  @override
  const LandingPage({ Key key }) : super(key: key);
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {

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
    final userStatus = InheritedUserServices.of(context).userStatus;
    return userStatus.isSignedIn() == false
        ? _buildAuthOptionsScreen()
        : HomePage();
  }

  Widget _buildAuthOptionsScreen() {
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
                    padding: EdgeInsets.fromLTRB(40.0, 40.0, 40.0, 100.0),
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
                Flexible(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(40.0, 0.0, 40.0, 0.0),
                    child: SizedBox(
                      width: double.infinity,
                      child: RaisedButton(
                        key: LandingPage.navigateToLoginButtonKey,
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
                          BorderRadius.circular(30.0)
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 5.0),
                Flexible(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(40.0, 0.0, 40.0, 0.0),
                    child: SizedBox(
                      width: double.infinity,
                      child: RaisedButton(
                        key: LandingPage.navigateToRegistrationButtonKey,
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
                          BorderRadius.circular(30.0)
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
      );
  }
}
