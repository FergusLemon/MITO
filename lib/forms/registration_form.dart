import 'package:flutter/material.dart';
import 'package:mito/inherited_user_services.dart';
import 'package:mito/pages/login_page.dart';
import '../helpers/email_validator.dart';
import '../helpers/password_validator.dart';
import '../helpers/validation_warnings.dart';

class RegistrationForm extends StatefulWidget {
  static const firstNameKey = Key('First Name');
  static const lastNameKey = Key('Last Name');
  static const emailKey = Key('Email');
  static const passwordKey = Key('Password');
  static const passwordConfirmKey = Key('Confirm Password');
  static const signUpKey = Key('Sign Up');
  static const navigateToLogin = Key('Navigate registered user to login');
  const RegistrationForm({Key key }) : super(key: key);

  @override
  _RegistrationFormState createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  final _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;
  bool _isUniqueEmail = true;

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
  void initState() {
    super.initState();
    _emailController.addListener(onChange);
  }

  void onChange() {
    _isUniqueEmail = true;
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
              SizedBox(height: 20.0),
              FlatButton(
                  key: RegistrationForm.navigateToLogin,
                  onPressed: () => _navigateToLoginPage(context),
                  child: Text(
                     'Already got an account? Login.',
                  ),
              ),
            ],
        ),
    );
  }

  Future<String> _attemptSignUp() async {
    final form = _formKey.currentState;
    if (form.validate()) {
      try {
        final auth = InheritedUserServices.of(context).auth;
        final userStatus = InheritedUserServices.of(context).userStatus;
        final store = InheritedUserServices.of(context).firestore;
        String uid = await auth.signUp(_emailController.text, _passwordController.text);
        final userProfile = {
          'email': _emailController.text,
          'firstName': _firstNameController.text,
          'lastName': _lastNameController.text,
        };
          try {
            await store.collection('users').document(uid).setData(userProfile);
            userStatus.signInUser();
            Navigator.of(context).pop();
          } catch (e) {
            print('Error: $e');
          }
      } catch (e) {
        if (_emailAlreadyRegistered(e.message)) {
          setState(() => _isUniqueEmail = false);
          _attemptSignUp();
        }
      }
    } else {
      setState(() => _autoValidate = true);
    }
    return null;
  }

  bool _emailAlreadyRegistered(String errorMessage) {
    return errorMessage == firebaseAuthErrorExistingEmail;
  }

  String _validateFirstName(String value) {
    return value.trim().isEmpty
        ? missingFirstNameWarning
        : null;
  }

  String _validateLastName(String value) {
    return value.trim().isEmpty
        ? missingLastNameWarning
        : null;
  }

  String _validateEmail(String value) {
    return value.trim().isEmpty 
        ? missingEmailWarning
        : _isValidEmail(value) && _isUniqueEmail
        ? null
        : _isValidEmail(value)
        ? registeredEmailWarning
        : invalidEmailWarning;
  }

  bool _isValidEmail(String value) {
    return validateEmail(value);
  }

  String _validatePassword(String value) {
    return value.trim().isEmpty
        ? missingPasswordWarning
        : _isValidPassword(value)
        ? null
        : invalidPasswordWarning;
  }

  bool _isValidPassword(String value) {
    return validatePassword(value);
  }

  String _confirmPassword(String value) {
    return value.trim().isEmpty
        ? missingPasswordConfirmWarning
        : _isSamePassword(value)
        ? null
        : notSamePasswordWarning;
  }

  bool _isSamePassword(String value) {
    return value == _passwordController.text;
  }

  void _navigateToLoginPage(BuildContext context) {
    final route = MaterialPageRoute(builder: (_) => LoginPage());
    Navigator.of(context).push(route);
  }
}
