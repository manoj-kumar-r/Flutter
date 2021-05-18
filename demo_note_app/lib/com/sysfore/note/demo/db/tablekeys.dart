import 'package:demo_note_app/com/sysfore/note/demo/db/tablename.dart';

class TableKeys {
  //note table keys
  static final keyId = "id";
  static final createdDate = "createdDate";
  static final userId = "userId";
  static final noteTitle = "noteTitle";
  static final noteDesc = "noteDesc";
  static final isAttached = "isAttached";
  static final attachType = "attachType";
  static final attachPath = "attachPath";
  static final attachName = "attachName";
}

class TableCreateStatements {
  //table create statements
  //note table
  static final createNoteTable = "CREATE TABLE IF NOT EXISTS " +
      TableName.tableNote +
      "(" +
      TableKeys.keyId +
      " TEXT PRIMARY KEY," +
      TableKeys.noteTitle +
      " TEXT," +
      TableKeys.noteDesc +
      " TEXT," +
      TableKeys.isAttached +
      " INTEGER," +
      TableKeys.attachType +
      " TEXT," +
      TableKeys.attachPath +
      " TEXT," +
      TableKeys.attachName +
      " TEXT," +
      TableKeys.userId +
      " TEXT," +
      TableKeys.createdDate +
      " TEXT" +
      ")";
}
