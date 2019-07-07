import 'package:mockito/mockito.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DocumentSnapshotMock extends Mock implements DocumentSnapshot {
  bool exists = true;
}
