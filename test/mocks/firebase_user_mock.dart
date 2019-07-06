import 'package:firebase_auth/firebase_auth.dart';
import 'package:mockito/mockito.dart';
import '../helpers/form_validation_helpers.dart';

class FirebaseUserMock extends Mock implements FirebaseUser {
  @override
  final String uid = 'thisIsATestId';
  final String email = validEmail;
}
