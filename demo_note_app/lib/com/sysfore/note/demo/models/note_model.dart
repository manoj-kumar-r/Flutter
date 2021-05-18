import 'package:uuid/uuid.dart';

class NoteModel {
  String keyId = Uuid().v1();
  String noteTitle = "";
  String noteDesc = "";
  bool isAttached = false;
  String attachType = "";
  String attachPath = "";
  String attachName = "";
  String createdDate = "";
  String userId = "";
}
