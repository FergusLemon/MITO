import 'package:mockito/mockito.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInAuthMock extends Mock implements GoogleSignInAuthentication {
  @override
  final String idToken = 'id';
  @override
  final String accessToken = 'secret';
}
