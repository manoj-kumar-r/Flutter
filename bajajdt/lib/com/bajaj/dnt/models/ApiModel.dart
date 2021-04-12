import 'dart:core';

class MasterResponse {
  String responseStatus;
  String errorMessage;
  String userID;
  List<Language> language;
  List<Brand> brands;
  List<Country> country;

  MasterResponse({this.responseStatus, this.errorMessage, this.language});

  factory MasterResponse.fromJson(Map<String, dynamic> json) {
    MasterResponse masterResponse = MasterResponse();
    masterResponse.responseStatus = json['ResponseStatus'];
    masterResponse.errorMessage = json['ErrorMessage'];
    if (masterResponse.responseStatus != null &&
        masterResponse.responseStatus == "Pass") {
      if (json.containsKey("UserID") && json["UserID"] != null) {
        masterResponse.userID = json["UserID"].toString();
      }

      if (json.containsKey("language") && json['language'] != null) {
        var parsed = json['language'].cast<Map<String, dynamic>>();
        print("language : $parsed");
        List<Language> data =
            parsed.map<Language>((json) => Language.fromJson(json)).toList();
        data.sort((a, b) => a.languageId.compareTo(b.languageId));
        masterResponse.language = data;
      }

      if (json.containsKey("brands") && json['brands'] != null) {
        var parsed = json['brands'].cast<Map<String, dynamic>>();
        print("brands : $parsed");
        masterResponse.brands =
            parsed.map<Brand>((json) => Brand.fromJson(json)).toList();
      }

      if (json.containsKey("country") && json['country'] != null) {
        var parsed = json['country'].cast<Map<String, dynamic>>();
        print("country : $parsed");
        masterResponse.country =
            parsed.map<Country>((json) => Country.fromJson(json)).toList();
      }
    }
    return masterResponse;
  }
}

class Language {
  int languageId;
  String language;
  String isActive;
  String languageText;
  String languageCode;

  @override
  String toString() {
    return 'Language{languageId: $languageId, language: $language, isActive: $isActive, languageText: $languageText, languageCode: $languageCode}';
  }

  Language(
      {this.languageId,
      this.language,
      this.isActive,
      this.languageText,
      this.languageCode});

  factory Language.fromJson(Map<String, dynamic> json) {
    var language = Language();
    language.languageId = json['languageid'];
    language.language = json['language'].toString();
    language.isActive = json['isActive'].toString();
    language.languageText = json['languagetext'].toString();
    language.languageCode = json['languagecode'].toString();
    return language;
  }
}

class Brand {
  String brandid;
  String brand;
  String variant;
  String variantno;
  String active;
  String vehicletype;
  String noOfFiles;
  String logDate;
  String langId;
  String userId;
  bool clicked = false;
  bool isDownloaded = false;
  bool notificationReceived = false;
  bool favSelected = false;
  int image;

  Brand(
      {this.brandid,
      this.brand,
      this.variant,
      this.variantno,
      this.active,
      this.clicked,
      this.langId,
      this.isDownloaded,
      this.noOfFiles,
      this.vehicletype,
      this.userId,
      this.notificationReceived,
      this.logDate,
      this.favSelected,
      this.image});

  factory Brand.fromJson(Map<String, dynamic> json) {
    var brand = Brand();
    brand.brandid = json['brandid'].toString();
    brand.brand = json['brand'].toString();
    brand.variant = json['variant'].toString();
    brand.variantno = json['variantno'].toString();
    brand.active = json['active'].toString();
    brand.vehicletype = json['vehicletype'].toString();
    return brand;
  }

  Map<String, dynamic> toJson() => {
        'brandid': brandid,
        'brand': brand,
        'variant': variant,
        'variantno': variantno,
        'active': active,
        'vehicletype': vehicletype,
      };
}

class Country {
  String countryId = "-1";
  String country = "Select";

  Country({this.countryId, this.country});

  factory Country.fromJson(Map<String, dynamic> json) {
    var country = Country();
    country.countryId = json['countryid'].toString();
    country.country = json['country'].toString();
    return country;
  }

  Map<String, dynamic> toJson() => {
        'countryid': countryId,
        'country': country,
      };
}
