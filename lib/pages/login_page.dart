import 'package:mito/forms/login_form.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  const LoginPage({ Key key }) : super(key: key);
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text('Login'),
            centerTitle: true,
        ),
        body: const SingleChildScrollView(
            child: Padding(
                padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 10.0),
                child: const LoginForm(),
              ),
            ),
    );
  }
}
