import 'package:flutter/material.dart';
import 'package:mito/inherited_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../helpers/email_validator.dart';
import '../helpers/password_validator.dart';

class RegistrationForm extends StatefulWidget {
  static const firstNameKey = Key('First Name');
  static const lastNameKey = Key('Last Name');
  static const emailKey = Key('Email');
  static const passwordKey = Key('Password');
  static const passwordConfirmKey = Key('Confirm Password');
  static const signUpKey = Key('Sign Up');
  const RegistrationForm({Key key }) : super(key: key);

  @override
  _RegistrationFormState createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  final _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;

  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
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
                key: RegistrationForm.firstNameKey,
                decoration: const InputDecoration(
                  labelText: 'First Name',
                ),
                validator: _validateFirstName,
                controller: _firstNameController,
              ),
              SizedBox(height: 12.0),
              TextFormField(
                key: RegistrationForm.lastNameKey,
                decoration: const InputDecoration(
                  labelText: 'Last Name',
                ),
                validator: _validateLastName,
                controller: _lastNameController,
              ),
              SizedBox(height: 12.0),
              TextFormField(
                key: RegistrationForm.emailKey,
                decoration: const InputDecoration(
                  labelText: 'Email',
                ),
                validator: _validateEmail,
                controller: _emailController,
              ),
              SizedBox(height: 12.0),
              TextFormField(
                key: RegistrationForm.passwordKey,
                decoration: const InputDecoration(
                  labelText: 'Password',
                ),
                validator: _validatePassword,
                controller: _passwordController,
                obscureText: true,
              ),
              SizedBox(height: 12.0),
              TextFormField(
                key: RegistrationForm.passwordConfirmKey,
                decoration: const InputDecoration(
                  labelText: 'Confirm Password',
                ),
                validator: _confirmPassword,
                obscureText: true,
              ),
              SizedBox(height: 10.0),
              RaisedButton(
                key: RegistrationForm.signUpKey,
                onPressed: _attemptSignUp,
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

  void _attemptSignUp() async {
    final form = _formKey.currentState;
    if (form.validate()) {
      try {
        final auth = InheritedAuth.of(context).auth;
        final userState = InheritedAuth.of(context).userState;
        final Firestore store = Firestore.instance;
        String uid = await auth.signUp(_emailController.text, _passwordController.text);
        final userProfile = {
          'email': _emailController.text,
          'firstName': _firstNameController.text,
          'lastName': _lastNameController.text,
        };
        await store.collection('users').document(uid).setData(userProfile);
        userState.signInUser();
        Navigator.of(context).pop();
      } catch (e) {
        print('Error: $e');
      }
    } else {
      setState(() => _autoValidate = true);
    }
  }

  String _validateFirstName(String value) {
    return value.trim().isEmpty
        ? 'Please enter your first name.'
        : null;
  }

  String _validateLastName(String value) {
    return value.trim().isEmpty
        ? 'Please enter your last name.'
        : null;
  }

  String _validateEmail(String value) {
    return value.trim().isEmpty 
        ? 'Please enter an email address.' 
        : _isValidEmail(value)
        ? null
        : 'Please enter a valid email address.';
  }

  bool _isValidEmail(String value) {
    return validateEmail(value);
  }

  String _validatePassword(String value) {
    return value.trim().isEmpty
        ? 'Please enter a password.'
        : _isValidPassword(value)
        ? null
        : 'Please enter a valid password. Passwords must be between 8-24 characters and contain 1 lowercase, 1 uppercase and 1 special character.';
  }

  bool _isValidPassword(String value) {
    return validatePassword(value);
  }

  String _confirmPassword(String value) {
    return value.trim().isEmpty
        ? 'Please confirm your password.'
        : _isSamePassword(value)
        ? null
        : 'The passwords entered do not match.';
  }

  bool _isSamePassword(String value) {
    return value == _passwordController.text;
  }
}
