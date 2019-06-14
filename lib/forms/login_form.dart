import 'package:flutter/material.dart';
import 'package:mito/inherited_user_services.dart';
import '../helpers/email_validator.dart';
import '../helpers/password_validator.dart';

class LoginForm extends StatefulWidget {
  static const loginKey = Key('Login button');
  static const emailKey = Key('Email field');
  static const passwordKey = Key('Password field');
  const LoginForm({Key key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                  key: LoginForm.emailKey,
                  decoration: const InputDecoration(
                      labelText: 'Email',
                  ),
                  validator: _validateEmail,
                  controller: _emailController,
              ),
              SizedBox(height: 12.0),
              TextFormField(
                  key: LoginForm.passwordKey,
                  decoration: const InputDecoration(
                      labelText: 'Password',
                  ),
                  validator: _validatePassword,
                  controller: _passwordController,
                  obscureText: true,
              ),
              SizedBox(height: 10.0),
              RaisedButton(
                  key: LoginForm.loginKey,
                  onPressed: _attemptLogin,
                  child: const Text(
                      'LOGIN',
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

  void _attemptLogin() async {
    final form = _formKey.currentState;
    if (form.validate()) {
      try {
        final auth = InheritedUserServices.of(context).auth;
        final userStatus = InheritedUserServices.of(context).userStatus;
        String uid = await auth.signIn(_emailController.text, _passwordController.text);
        userStatus.signInUser();
        Navigator.of(context).pop();
      } catch(e) {
        print('$e');
      }
    } else {
      print('Sign in Unsuccessful');
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
    return validateEmail(value);
  }

  String _validatePassword(String value) {
    return value.trim().isEmpty
        ? 'Please enter a password.'
        : _isValidPassword(value)
        ? null
        : 'The password you entered is not a valid password.';
  }

  bool _isValidPassword(String value) {
    return validatePassword(value);
  }
}
