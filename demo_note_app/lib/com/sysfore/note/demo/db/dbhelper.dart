import 'package:demo_note_app/com/sysfore/note/demo/db/tablekeys.dart';
import 'package:demo_note_app/com/sysfore/note/demo/db/tablename.dart';
import 'package:demo_note_app/com/sysfore/note/demo/models/note_model.dart';
import 'package:path_provider/path_provider.dart';
// import 'package:sms_otp_auto_verify/sms_otp_auto_verify.dart';
import 'package:sqflite_sqlcipher/sqflite.dart';

class DbHelper {
  // make this a singleton class
  DbHelper._privateConstructor();

  static final DbHelper instance = DbHelper._privateConstructor();

  // only have a single app-wide reference to the database
  static Database? _database;

  Future<Database?> get database async {
    if (_database != null) return _database;
    // lazily instantiate the db the first time it is accessed
    _database = await _initDatabase();
    return _database;
  }

  // this opens the database (and creates it if it doesn't exist)
  _initDatabase() async {
    var documentsDirectory = await getApplicationDocumentsDirectory();
    var path = documentsDirectory.path + TableName.dataBaseName;

    var pKey = "jhkjh887987";//await SmsRetrieved.getAppSignature();
    print("pKey:$pKey");

    return await openDatabase(path,
        password: pKey,
        version: TableName.dataBaseVersion,
        onCreate: _onCreateDb);
  }

  _onCreateDb(Database db, int newVersion) async {
    await db.execute(TableCreateStatements.createNoteTable);
  }

  Future<int> insertNote(NoteModel noteModel) async {
    Database? db = await DbHelper.instance.database;

    Map<String, dynamic> content = {
      TableKeys.keyId: noteModel.keyId,
      TableKeys.createdDate: noteModel.createdDate,
      TableKeys.userId: noteModel.userId,
      TableKeys.noteTitle: noteModel.noteTitle,
      TableKeys.noteDesc: noteModel.noteDesc,
      TableKeys.isAttached: noteModel.isAttached ? 1 : 0,
      TableKeys.attachType: noteModel.attachType,
      TableKeys.attachPath: noteModel.attachPath,
      TableKeys.attachName: noteModel.attachName,
    };

    var result = await db!.update(TableName.tableNote, content,
        where: TableKeys.keyId + ' = ? and ' + TableKeys.userId + ' = ? ',
        whereArgs: [noteModel.keyId, noteModel.userId]);
    if (result == 0) {
      result = await db.insert(TableName.tableNote, content);
    }
    return result;
  }

  Future<List<NoteModel>> getNoteListList(int position, String userId,
      {String noteId = "", String type = "A"}) async {
    print("userId:$userId");
    print("noteId:$noteId");
    Database? db = await DbHelper.instance.database;
    var query = "";
    switch (position) {
      case 0:
        query = "Select * From " +
            TableName.tableNote +
            " where " +
            TableKeys.userId +
            "='" +
            userId +
            "' ORDER BY " +
            TableKeys.createdDate +
            " DESC";
        break;
      case 1:
        query = "Select * From " +
            TableName.tableNote +
            " where " +
            TableKeys.userId +
            "='" +
            userId +
            "' and " +
            TableKeys.keyId +
            "='" +
            noteId +
            "'" +
            " ORDER BY " +
            TableKeys.keyId +
            " DESC";
        break;
      case 2:
        query = "Select * From " +
            TableName.tableNote +
            " where " +
            TableKeys.userId +
            "='" +
            userId +
            "' and " +
            TableKeys.attachType +
            "='" +
            type +
            "'" +
            " ORDER BY " +
            TableKeys.keyId +
            " DESC";
        break;
    }

    var result = await db!.rawQuery(query);
    return List.generate(result.length, (i) {
      var noteModel = NoteModel();
      noteModel.keyId = result[i][TableKeys.keyId].toString();
      noteModel.createdDate = result[i][TableKeys.createdDate].toString();
      noteModel.userId = result[i][TableKeys.userId].toString();
      noteModel.noteTitle = result[i][TableKeys.noteTitle].toString();
      noteModel.noteDesc = result[i][TableKeys.noteDesc].toString();
      noteModel.isAttached =
          int.parse(result[i][TableKeys.isAttached].toString()) == 1;
      noteModel.attachType = result[i][TableKeys.attachType].toString();
      noteModel.attachPath = result[i][TableKeys.attachPath].toString();
      noteModel.attachName = result[i][TableKeys.attachName].toString();
      return noteModel;
    });
  }
}
