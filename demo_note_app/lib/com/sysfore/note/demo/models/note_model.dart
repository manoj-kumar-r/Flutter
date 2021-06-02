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

  NoteModel() {}

  Map<String, dynamic> toMap() {
    var data = Map<String, dynamic>();
    data["keyId"] = keyId;
    data["noteTitle"] = noteTitle;
    data["noteDesc"] = noteDesc;
    data["isAttached"] = isAttached;
    data["attachType"] = attachType;
    data["attachPath"] = attachPath;
    data["attachName"] = attachName;
    data["createdDate"] = createdDate;
    data["userId"] = userId;
    return data;
  }

  NoteModel.fromMap(Map<String, dynamic> mapData) {
    print(mapData);
    keyId = mapData["keyId"];
    noteTitle = mapData["noteTitle"];
    noteDesc = mapData["noteDesc"];
    isAttached = mapData["isAttached"];
    attachType = mapData["attachType"];
    attachPath = mapData["attachPath"];
    attachName = mapData["attachName"];
    createdDate = mapData["createdDate"];
    userId = mapData["userId"];
  }
}
