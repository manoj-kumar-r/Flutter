import 'package:bajajdt/com/bajaj/dnt/database/TableKeys.dart';
import 'package:bajajdt/com/bajaj/dnt/database/TableName.dart';

class TableCreateStatements {
  //table create statements
  //language table
  static final String CREATE_TABLE_LANGUAGE = "CREATE TABLE IF NOT EXISTS " +
      TableName.TABLE_LANGUAGE +
      "(" +
      TableKeys.LANG_ID +
      " INTEGER PRIMARY KEY," +
      TableKeys.LANG_DESC +
      " TEXT," +
      TableKeys.LANG_TEXT +
      " TEXT," +
      TableKeys.LANG_CODE +
      " TEXT," +
      TableKeys.IS_ACTIVE +
      " TEXT," +
      TableKeys.CREATED_DATE +
      " TEXT" +
      ")";

  //model table
  static final String CREATE_TABLE_MODEL = "CREATE TABLE IF NOT EXISTS " +
      TableName.TABLE_MODEL +
      "(" +
      TableKeys.KEY_ID +
      " INTEGER PRIMARY KEY," +
      TableKeys.MODEL_ID +
      " TEXT," +
      TableKeys.MODEL_NAME +
      " TEXT," +
      TableKeys.VARIANT_DESC +
      " TEXT," +
      TableKeys.VARIANT_ID +
      " TEXT," +
      TableKeys.VEHICLE_TYPE +
      " TEXT," +
      TableKeys.IS_DOWNLOADED +
      " TEXT," +
      TableKeys.EMPLOYEE_KEY_ID +
      " TEXT," +
      TableKeys.NOTIFICATION_RECEIVED +
      " TEXT," +
      TableKeys.SYNC_LOG_DATE +
      " TEXT," +
      TableKeys.IS_ACTIVE +
      " TEXT," +
      TableKeys.CREATED_DATE +
      " TEXT" +
      ")";

  //support table
  static final String CREATE_TABLE_SUPPORT = "CREATE TABLE IF NOT EXISTS " +
      TableName.TABLE_SUPPORT +
      "(" +
      TableKeys.SUPPORT_ID +
      " INTEGER PRIMARY KEY," +
      TableKeys.EMPLOYEE_KEY_ID +
      " TEXT," +
      TableKeys.SUPPORT_DESC +
      " TEXT," +
      TableKeys.COUNTRY_ID +
      " TEXT," +
      TableKeys.FILE_NAME +
      " TEXT," +
      TableKeys.FILE_PATH +
      " TEXT," +
      TableKeys.MAIN_MENU_ID +
      " TEXT," +
      TableKeys.MODEL_NAME +
      " TEXT," +
      TableKeys.VARIANT_DESC +
      " TEXT," +
      TableKeys.STEP_NO +
      " TEXT," +
      TableKeys.SUPPORT_STATUS +
      " TEXT," +
      TableKeys.TICKET_NO +
      " TEXT," +
      TableKeys.SUPPORT_RESPONSE +
      " TEXT," +
      TableKeys.KEY_IS_SENT +
      " TEXT," +
      TableKeys.RESPONSE_DATE +
      " TEXT," +
      TableKeys.KEY_IS_READ +
      " TEXT," +
      TableKeys.TICKET_DATE +
      " TEXT," +
      TableKeys.CREATED_DATE +
      " TEXT" +
      ")";

  //steps table
  static final String CREATE_TABLE_STEPS = "CREATE TABLE IF NOT EXISTS " +
      TableName.TABLE_STEPS +
      "(" +
      TableKeys.KEY_ID +
      " INTEGER PRIMARY KEY," +
      TableKeys.STEP_ID +
      " TEXT," +
      TableKeys.MODEL_ID +
      " TEXT," +
      TableKeys.VARIANT_NO +
      " TEXT," +
      TableKeys.STEP_TEXT +
      " TEXT," +
      TableKeys.STEP_PARENT_ID +
      " TEXT," +
      TableKeys.STEP_SEQUENCE +
      " TEXT," +
      TableKeys.MAIN_MENU_ID +
      " TEXT," +
      TableKeys.STEP_OK_ID +
      " TEXT," +
      TableKeys.STEP_NOT_OK_ID +
      " TEXT," +
      TableKeys.STEP_NO +
      " TEXT," +
      TableKeys.STEP_PARENT_NO +
      " TEXT," +
      TableKeys.STEP_IS_ROOT +
      " TEXT," +
      TableKeys.STEP_IS_LAST +
      " TEXT," +
      TableKeys.STEP_IS_OPTION +
      " TEXT," +
      TableKeys.IS_ACTIVE +
      " TEXT," +
      TableKeys.CREATED_DATE +
      " TEXT" +
      ")";

  //step files
  static final String CREATE_TABLE_STEP_FILES = "CREATE TABLE IF NOT EXISTS " +
      TableName.TABLE_STEP_FILES +
      "(" +
      TableKeys.KEY_ID +
      " INTEGER PRIMARY KEY," +
      TableKeys.STEP_FILES_ID +
      " TEXT," +
      TableKeys.STEP_ID +
      " TEXT," +
      TableKeys.STEP_FILE_TYPE +
      " TEXT," +
      TableKeys.STEP_FILE_NAME +
      " TEXT," +
      TableKeys.STEP_FILE +
      " TEXT," +
      TableKeys.STEP_IS_ADDITIONAL +
      " TEXT," +
      TableKeys.FILE_URL +
      " TEXT," +
      TableKeys.STEP_IMAGE_URL +
      " TEXT," +
      TableKeys.IS_DOWNLOADED +
      " TEXT," +
      TableKeys.IS_ACTIVE +
      " TEXT," +
      TableKeys.CREATED_DATE +
      " TEXT" +
      ")";

  //main menu table
  static final String CREATE_TABLE_MAIN_MENU = "CREATE TABLE IF NOT EXISTS " +
      TableName.TABLE_MASTER_MENU +
      "(" +
      TableKeys.KEY_ID +
      " INTEGER PRIMARY KEY," +
      TableKeys.MAIN_MENU_ID +
      " TEXT," +
      TableKeys.MAIN_MENU_NAME +
      " TEXT," +
      TableKeys.MODEL_ID +
      " TEXT," +
      TableKeys.VARIANT_NO +
      " TEXT," +
      TableKeys.MENU_SEQUENCE +
      " TEXT," +
      TableKeys.IS_ACTIVE +
      " TEXT," +
      TableKeys.CREATED_DATE +
      " TEXT" +
      ")";

  //Fav table
  static final String CREATE_TABLE_FAV = "CREATE TABLE IF NOT EXISTS " +
      TableName.TABLE_FAVOURITE +
      "(" +
      TableKeys.KEY_ID +
      " INTEGER PRIMARY KEY," +
      TableKeys.MODEL_ID +
      " TEXT," +
      TableKeys.MODEL_NAME +
      " TEXT," +
      TableKeys.VARIANT_DESC +
      " TEXT," +
      TableKeys.VARIANT_ID +
      " TEXT," +
      TableKeys.EMPLOYEE_KEY_ID +
      " TEXT," +
      TableKeys.CREATED_DATE +
      " TEXT" +
      ")";

  //Recent table
  static final String CREATE_TABLE_RECENT = "CREATE TABLE IF NOT EXISTS " +
      TableName.TABLE_RECENT +
      "(" +
      TableKeys.KEY_ID +
      " INTEGER PRIMARY KEY," +
      TableKeys.MODEL_ID +
      " TEXT," +
      TableKeys.MODEL_NAME +
      " TEXT," +
      TableKeys.VARIANT_DESC +
      " TEXT," +
      TableKeys.VARIANT_ID +
      " TEXT," +
      TableKeys.EMPLOYEE_KEY_ID +
      " TEXT," +
      TableKeys.CREATED_DATE +
      " TEXT" +
      ")";

  //main menu table
  static final String CREATE_TABLE_STEP_TRANSACTION = "CREATE TABLE IF NOT EXISTS " +
      TableName.TABLE_STEP_TRANSACTION +
      "(" +
      TableKeys.KEY_ID +
      " INTEGER PRIMARY KEY," +
      TableKeys.STEP_PREVIOUS +
      " TEXT," +
      TableKeys.STEP_CURRENT +
      " TEXT," +
      TableKeys.CREATED_DATE +
      " TEXT" +
      ")";

  // process log
  static final String CREATE_PROCESS_LOG = "CREATE TABLE IF NOT EXISTS " +
      TableName.TABLE_PROCESS_LOG +
      "(" +
      TableKeys.KEY_ID +
      " INTEGER PRIMARY KEY," +
      TableKeys.KEY_DATE +
      " TEXT" +
      ")";

  // Country Details
  static final String CREATE_TABLE_COUNTRY = "CREATE TABLE IF NOT EXISTS " +
      TableName.TABLE_COUNTRY +
      "(" +
      TableKeys.COUNTRY_ID +
      " INTEGER PRIMARY KEY," +
      TableKeys.COUNTRY_NAME +
      " TEXT," +
      TableKeys.CREATED_DATE +
      " TEXT" +
      ")";

  // Login Details
  static final String CREATE_TABLE_LOGIN = "CREATE TABLE IF NOT EXISTS " +
      TableName.TABLE_LOGIN +
      "(" +
      TableKeys.EMPLOYEE_KEY_ID +
      " INTEGER PRIMARY KEY," +
      TableKeys.EMPLOYEE_NAME +
      " TEXT," +
      TableKeys.EMPLOYEE_PASSWORD +
      " TEXT," +
      TableKeys.COUNTRY_ID +
      " TEXT," +
      TableKeys.COUNTRY_NAME +
      " TEXT," +
      TableKeys.CREATED_DATE +
      " TEXT" +
      ")";
}
