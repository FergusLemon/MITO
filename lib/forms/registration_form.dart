import 'package:flutter/material.dart';

class RegistrationForm extends StatefulWidget {
  @override
  const RegistrationForm({Key key}) : super(key: key);

  _RegistrationFormState createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
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
              SizedBox(height: 12.0),
              TextFormField(
                  decoration: const InputDecoration(
                      labelText: 'Confirm Password',
                  ),
              ),
              SizedBox(height: 10.0),
              RaisedButton(
                  onPressed: () {},
                  child: const Text(
                      'SIGN UP',
                  ),
                  color: Colors.red,
                  textColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius:
                    BorderRadius.circular(30.0)),
              ),
            ],
        ),
    );
  }
}
