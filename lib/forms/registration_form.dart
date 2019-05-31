import 'package:flutter/material.dart';
import '../helpers/form_validation_helpers.dart';

class RegistrationForm extends StatefulWidget {
  @override
  const RegistrationForm({Key key}) : super(key: key);

  _RegistrationFormState createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  final _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;
  final passwordController = TextEditingController();

  void dispose() {
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        autovalidate: _autoValidate,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Email',
                ),
                validator: _validateEmail,
              ),
              SizedBox(height: 12.0),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Password',
                ),
                validator: _validatePassword,
                controller: passwordController,
                obscureText: true,
              ),
              SizedBox(height: 12.0),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Confirm Password',
                ),
                validator: _confirmPassword,
                obscureText: true,
              ),
              SizedBox(height: 10.0),
              RaisedButton(
                onPressed: _validateInputs,
                child: const Text(
                  'SIGN UP',
                ),
                color: Colors.red,
                textColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius:
                  BorderRadius.circular(30.0),
                ),
              ),
            ],
        ),
    );
  }

  void _validateInputs() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
    } else {
      setState(() => _autoValidate = true);
    }
  }

  String _validateEmail(String value) {
    return value.trim().isEmpty 
        ? 'Please enter an email address.' 
        : _isValidEmail(value)
        ? null
        : 'Please enter a valid email address.';
  }

  bool _isValidEmail(String value) {
    return validEmail.hasMatch(value);
  }

  String _validatePassword(String value) {
    return value.trim().isEmpty
        ? 'Please enter a password.'
        : _isValidPassword(value)
        ? null
        : 'Please enter a valid password. Passwords must be between 8-24 characters and contain 1 lowercase, 1 uppercase and 1 special character.';
  }

  bool _isValidPassword(String value) {
    return validPassword.hasMatch(value);
  }

  String _confirmPassword(String value) {
    return value.trim().isEmpty
        ? 'Please confirm your password.'
        : _isSamePassword(value)
        ? null
        : 'The passwords entered do not match.';
  }

  bool _isSamePassword(String value) {
    return value == passwordController.text;
  }
}
