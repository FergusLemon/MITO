import 'package:flutter/material.dart';
import 'package:mito/inherited_user_services.dart';
import '../helpers/email_validator.dart';
import '../helpers/password_validator.dart';
import '../helpers/validation_warnings.dart';

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
  bool _autoValidate = false;
  bool _registeredUser = true;
  bool _correctPassword = true;

  @override
  void initState() {
    super.initState();
    _emailController.addListener(onEmailChange);
    _passwordController.addListener(onPasswordChange);
  }

  void onEmailChange() {
    _registeredUser = true;
  }

  void onPasswordChange() {
    _correctPassword = true;
  }

  void dispose() {
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
                  key: LoginForm.emailKey,
                  decoration: const InputDecoration(
                      labelText: 'Email',
                  ),
                  validator: _validateEmail,
                  controller: _emailController,
              ),
              SizedBox(height: 15.0),
              TextFormField(
                  key: LoginForm.passwordKey,
                  decoration: const InputDecoration(
                      labelText: 'Password',
                  ),
                  validator: _validatePassword,
                  controller: _passwordController,
                  obscureText: true,
              ),
              SizedBox(height: 20.0),
              SizedBox(
                width: double.infinity,
                child: RaisedButton(
                  key: LoginForm.loginKey,
                  onPressed: _attemptLogin,
                  child: const Text(
                    'LOGIN',
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                  ),
                  color: Colors.red,
                  textColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius:
                    BorderRadius.circular(30.0)
                  ),
                ),
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
        if (_unregisteredUser(e.message)) {
          setState(() => _registeredUser = false);
          _attemptLogin();
        } else if (_incorrectPassword(e.message)) {
          setState(() => _correctPassword = false);
          _attemptLogin();
        } else {
          print('$e');
        }
      }
    } else {
      setState(() => _autoValidate = true);
    }
    return null;
  }

  String _validateEmail(String value) {
    return value.trim().isEmpty 
        ? missingEmailWarning
        : _isValidEmail(value) && _registeredUser
        ? null
        : _isValidEmail(value)
        ? userNotFoundWarning
        : invalidEmailWarning;
  }

  bool _isValidEmail(String value) {
    return validateEmail(value);
  }

  bool _unregisteredUser(String errorMessage) {
    return errorMessage == firebaseUserNotFound;
  }

  String _validatePassword(String value) {
    return value.trim().isEmpty
        ? missingPasswordWarning
        : _isValidPassword(value) && _correctPassword
        ? null
        : _isValidPassword(value)
        ? incorrectPasswordWarning
        : notAPasswordWarning;
  }

  bool _isValidPassword(String value) {
    return validatePassword(value);
  }

  bool _incorrectPassword(String errorMessage) {
    return errorMessage == firebaseInvalidPassword;
  }
}
