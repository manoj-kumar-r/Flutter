import 'package:bajajdt/com/bajaj/dnt/database/TableCreateStatements.dart';
import 'package:bajajdt/com/bajaj/dnt/database/TableKeys.dart';
import 'package:bajajdt/com/bajaj/dnt/models/ApiModel.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sms_otp_auto_verify/sms_otp_auto_verify.dart';
import 'package:sqflite_sqlcipher/sqflite.dart';

import 'TableName.dart';

class DbHelper {
  // make this a singleton class
  DbHelper._privateConstructor();

  static final DbHelper instance = DbHelper._privateConstructor();

  // only have a single app-wide reference to the database
  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    // lazily instantiate the db the first time it is accessed
    _database = await _initDatabase();
    return _database;
  }

  // this opens the database (and creates it if it doesn't exist)
  _initDatabase() async {
    var documentsDirectory = await getApplicationDocumentsDirectory();
    var path = documentsDirectory.path + TableName.DATABASE_NAME;

    var pKey = await SmsRetrieved.getAppSignature();
    print("pKey:$pKey");

    return await openDatabase(path,
        password: pKey,
        version: TableName.DATABASE_VERSION,
        onCreate: _onCreateDb);
  }

  _onCreateDb(Database db, int newVersion) async {
    await db.execute(TableCreateStatements.CREATE_TABLE_MODEL);
    await db.execute(TableCreateStatements.CREATE_TABLE_LANGUAGE);
    await db.execute(TableCreateStatements.CREATE_TABLE_SUPPORT);
    await db.execute(TableCreateStatements.CREATE_TABLE_STEPS);
    await db.execute(TableCreateStatements.CREATE_TABLE_STEP_FILES);
    await db.execute(TableCreateStatements.CREATE_TABLE_MAIN_MENU);
    await db.execute(TableCreateStatements.CREATE_TABLE_FAV);
    await db.execute(TableCreateStatements.CREATE_TABLE_RECENT);
    await db.execute(TableCreateStatements.CREATE_TABLE_COUNTRY);
    await db.execute(TableCreateStatements.CREATE_TABLE_LOGIN);
    await db.execute(TableCreateStatements.CREATE_TABLE_STEP_TRANSACTION);
  }

  Future<int> insertBrand(Brand brand, String userId) async {
    Database db = await DbHelper.instance.database;

    Map<String, String> content = {
      TableKeys.MODEL_ID: brand.brandid.toString(),
      TableKeys.MODEL_NAME: brand.brand.toString(),
      TableKeys.VEHICLE_TYPE: brand.vehicletype.toString(),
      TableKeys.VARIANT_DESC: brand.variant.toString(),
      TableKeys.VARIANT_ID: brand.variantno.toString(),
      TableKeys.EMPLOYEE_KEY_ID: userId,
      TableKeys.IS_ACTIVE: "Y",
      TableKeys.IS_DOWNLOADED: "N",
      TableKeys.CREATED_DATE: getDateTime(),
    };

    var result = await db.update(TableName.TABLE_MODEL, content,
        where:
            TableKeys.MODEL_ID + ' = ? and ' + TableKeys.VARIANT_ID + ' = ? ',
        whereArgs: [brand.brandid, brand.variantno]);

    if (result == 0) {
      result = await db.insert(TableName.TABLE_MODEL, content);
    }
    return result;
  }

  Future<int> insertFavBrand(Brand brand, String userId) async {
    Database db = await DbHelper.instance.database;

    Map<String, String> content = {
      TableKeys.MODEL_ID: brand.brandid.toString(),
      TableKeys.MODEL_NAME: brand.brand.toString(),
      TableKeys.VARIANT_DESC: brand.variant.toString(),
      TableKeys.VARIANT_ID: brand.variantno.toString(),
      TableKeys.CREATED_DATE: getDateTime(),
      TableKeys.EMPLOYEE_KEY_ID: userId,
    };

    var result = await db.update(TableName.TABLE_FAVOURITE, content,
        where:
            TableKeys.MODEL_ID + ' = ? and ' + TableKeys.VARIANT_ID + ' = ? ',
        whereArgs: [brand.brandid, brand.variantno]);

    if (result == 0) {
      result = await db.insert(TableName.TABLE_FAVOURITE, content);
    }
    return result;
  }

  Future<List<Brand>> getBrandList(
      int pos, String brandId, String userId) async {
    Database db = await DbHelper.instance.database;
    var query = "";
    if (pos == 0) {
      query = "Select * From " +
          TableName.TABLE_MODEL +
          " Where " +
          TableKeys.IS_ACTIVE +
          "='Y'  AND " +
          TableKeys.EMPLOYEE_KEY_ID +
          "='" +
          userId +
          "' GROUP BY " +
          TableKeys.MODEL_ID;
    } else if (pos == 1) {
      query = "Select * From " +
          TableName.TABLE_MODEL +
          " Where " +
          TableKeys.IS_ACTIVE +
          "='Y' And " +
          TableKeys.MODEL_ID +
          "='" +
          brandId +
          "' And " +
          TableKeys.EMPLOYEE_KEY_ID +
          "='" +
          userId +
          "'";
    }
    var result = await db.rawQuery(query);
    return List.generate(result.length, (i) {
      var brand = Brand();
      brand.brandid = result[i][TableKeys.MODEL_ID].toString();
      brand.brand = result[i][TableKeys.MODEL_NAME].toString();
      brand.variant = result[i][TableKeys.VARIANT_DESC].toString();
      brand.variantno = result[i][TableKeys.VARIANT_ID].toString();
      brand.vehicletype = result[i][TableKeys.VEHICLE_TYPE].toString();
      return brand;
    });
  }

  Future<List<Brand>> getFavList(String userId) async {
    Database db = await DbHelper.instance.database;
    var query = "Select * From " + TableName.TABLE_FAVOURITE + " where " + TableKeys.EMPLOYEE_KEY_ID + "='" + userId + "' AND " +
        TableKeys.VARIANT_ID + " in( select " +  TableKeys.VARIANT_ID + " FROM " +  TableName.TABLE_MODEL + " WHERE " +  TableKeys.IS_ACTIVE + "='Y') "
        + " ORDER BY " +  TableKeys.CREATED_DATE + " DESC";;
    var result = await db.rawQuery(query);
    return List.generate(result.length, (i) {
      var brand = Brand();
      brand.brandid = result[i][TableKeys.MODEL_ID].toString();
      brand.brand = result[i][TableKeys.MODEL_NAME].toString();
      brand.variant = result[i][TableKeys.VARIANT_DESC].toString();
      brand.variantno = result[i][TableKeys.VARIANT_ID].toString();
      return brand;
    });
  }

  Future<int> getFavCount(Brand brand) async {
    Database db = await this.database;
    List<Map<String, dynamic>> x = await db.rawQuery(" Select count(*) From " +
        TableName.TABLE_FAVOURITE +
        " Where " +
        TableKeys.MODEL_ID +
        "='" +
        brand.brandid +
        "' AND " +
        TableKeys.VARIANT_ID +
        "='" +
        brand.variantno +
        "' AND " +
        TableKeys.VARIANT_DESC +
        "='" +
        brand.variant +
        "'");
    var count = Sqflite.firstIntValue(x);
    print("Fav count:$count");
    return count;
  }

// Delete Operation: Delete a Note object from database
  Future<int> deleteFav(Brand brand) async {
    var db = await this.database;
    return await db.rawDelete(
        "DELETE FROM ${TableName.TABLE_FAVOURITE} Where " +
            TableKeys.MODEL_ID +
            "='" +
            brand.brandid +
            "' AND " +
            TableKeys.VARIANT_ID +
            "='" +
            brand.variantno +
            "' AND " +
            TableKeys.VARIANT_DESC +
            "='" +
            brand.variant +
            "'");
    ;
  }

  String getDateTime() {
    return new DateFormat("dd-MM-yyyy HH:mm:ss").format(DateTime.now());
  }
}
