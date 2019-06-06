import 'package:mito/forms/registration_form.dart';
import 'package:flutter/material.dart';

class RegistrationPage extends StatefulWidget {
  @override
  const RegistrationPage({ Key key, this.onSignedIn }) : super(key: key);
  final VoidCallback onSignedIn;
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text('Registration'),
            centerTitle: true,
        ),
        body: SingleChildScrollView(
            child: Padding(
                padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 10.0),
                child: RegistrationForm(onSignedIn: widget.onSignedIn),
              ),
            ),
    );
  }
}
