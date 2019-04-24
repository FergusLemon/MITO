import 'package:flutter/material.dart';

class LoginForm extends StatefulWidget {
  @override
  const LoginForm({Key key}) : super(key: key);

  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  @override
  Widget build(BuildContext context) {
    return Form(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                  decoration: const InputDecoration(
                      labelText: 'Email',
                  ),
              ),
              SizedBox(height: 12.0),
              TextFormField(
                  decoration: const InputDecoration(
                      labelText: 'Password',
                  ),
              ),
              RaisedButton(
                  onPressed: () {},
                  child: const Text(
                      'LOGIN',
                  ),
              ),
            ],
        ),
    );
  }
}
