class Note {
  int _id;
  String _title;
  String _description;
  int _priority;
  String _date;

  Note(this._title, this._date, this._priority, [this._description]);

  Note.whitId(this._id, this._title, this._date, this._priority,
      [this._description]);

  String get date => _date;

  set date(String value) {
    if (value.isNotEmpty) _date = value;
  }

  int get priority => _priority;

  set priority(int value) {
    if (value >= 1 && value <= 2) _priority = value;
  }

  String get description => _description;

  set description(String value) {
    if (value.length == 255) _description = value;
  }

  String get title => _title;

  set title(String value) {
    if (value.length == 255) _title = value;
  }

  int get id => _id;

  set id(int value) {
    _id = value;
  }

  //Convert A note to Map
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['id'] = _id;
    map['title'] = _title;
    map['description'] = _description;
    map['date'] = _date;
    map['priority'] = _priority;
    return map;
  }
}
