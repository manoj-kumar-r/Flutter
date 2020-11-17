import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'sqdb.dart';

class NKCreateNote extends StatefulWidget {
  final String appBarTitle;
  final Note note;

  NKCreateNote(this.note, this.appBarTitle);

  @override
  _NKCreateNoteState createState() =>
      _NKCreateNoteState(this.note, this.appBarTitle);
}

class _NKCreateNoteState extends State<NKCreateNote> {
  String _appBarTitle;
  Note _note;

  var _dbHelper = DbHelper();

  _NKCreateNoteState(this._note, this._appBarTitle);

  var _formKey = GlobalKey<FormState>();
  var _titleController = TextEditingController();
  var _descriptionController = TextEditingController();
  var _priorities = ['High', 'Low', 'Medium'];

  InputDecoration getInputDecoration(String text, TextStyle textStyle) {
    return InputDecoration(
      labelText: text,
      labelStyle: textStyle,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      errorStyle: TextStyle(
        color: Colors.redAccent,
        fontSize: 15,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var _textStyle = Theme
        .of(context)
        .textTheme
        .title;

    _titleController.text = _note.title;
    _descriptionController.text = _note.description;

    return WillPopScope(
      onWillPop: () => _moveBack(),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => _moveBack(),
          ),
          title: Text(_appBarTitle),
        ),
        body: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.only(top: 15, left: 10, right: 10),
            child: ListView(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 5, left: 0, right: 0),
                    child: DropdownButton<String>(
                      value: getPriorityAsString(_note.priority),
                      items: _priorities.map(
                            (item) {
                          return DropdownMenuItem<String>(
                            value: item,
                            child: Text(
                              item,
                              style: _textStyle,
                            ),
                          );
                        },
                      ).toList(),
                      onChanged: (e) => _onDropDownSelected(e),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 0, right: 0),
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    style: _textStyle,
                    validator: (String userInput) {
                      if (userInput.isEmpty) {
                        return 'Please enter title';
                      } else {
                        return null;
                      }
                    },
                    controller: _titleController,
                    onChanged: (value) => updateTitle(value),
                    decoration: getInputDecoration('Title', _textStyle),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 0, right: 0),
                  child: TextFormField(
                    style: _textStyle,
                    validator: (String userInput) {
                      if (userInput.isEmpty) {
                        return 'Please enter description';
                      } else {
                        return null;
                      }
                    },
                    onChanged: (value) => updateDescription(value),
                    controller: _descriptionController,
                    keyboardType: TextInputType.text,
                    decoration: getInputDecoration('Description', _textStyle),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 0, right: 0),
                  child: Row(
                    children: [
                      Expanded(
                        child: RaisedButton(
                          elevation: 6.0,
                          color: Theme
                              .of(context)
                              .accentColor,
                          textColor: Colors.white,
                          child: Text(
                            'Save',
                            textScaleFactor: 1.5,
                          ),
                          onPressed: () => _onSaveClicked(),
                        ),
                      ),
                      SizedBox(width: 20),
                      Expanded(
                        child: RaisedButton(
                          elevation: 6.0,
                          color: Theme
                              .of(context)
                              .accentColor,
                          textColor: Colors.white,
                          child: Text(
                            'Delete',
                            textScaleFactor: 1.5,
                          ),
                          onPressed: () => _onDeleteClicked(),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _moveBack() async {
    Navigator.pop(context, true);
  }

  void _onDropDownSelected(String newValueSelected) {
    updatePriorityAsInt(newValueSelected);
  }

  // Convert the String priority in the form of integer before saving it to Database
  void updatePriorityAsInt(String value) {
    switch (value) {
      case 'High':
        _note.priority = 1;
        break;
      case 'Low':
        _note.priority = 2;
        break;
      case 'Medium':
        _note.priority = 3;
        break;
    }
  }

  // Convert int priority to String priority and display it to user in DropDown
  String getPriorityAsString(int value) {
    String priority;
    switch (value) {
      case 1:
        priority = _priorities[0]; // 'High'
        break;
      case 2:
        priority = _priorities[1]; // 'Low'
        break;
      case 3:
        priority = _priorities[2]; // 'Low'
        break;
    }
    return priority;
  }

  // Update the title of Note object
  void updateTitle(String text) {
    print('Title=>$text');
    _note.title = _titleController.text;
  }

  // Update the description of Note object
  void updateDescription(String text) {
    print('Desc=>$text');
    _note.description =_descriptionController.text;
  }

  void _onSaveClicked() async {
    if (_formKey.currentState.validate()) {
      _note.date = DateFormat.yMMMd().format(DateTime.now());
      int result;
      if (_note.id != null) {
        // Case 1: Update operation
        result = await _dbHelper.updateNote(_note);
      } else {
        // Case 2: Insert Operation
        result = await _dbHelper.insertNote(_note);
      }
      if (result != 0) {
        // Success
        _showAlertDialog('Status', 'Note Saved Successfully')
            .then((value) => {if (value == 1) _moveBack()});
      } else {
        // Failure
        _showAlertDialog('Status', 'Problem Saving Note');
      }
    }
  }

  void _onDeleteClicked() async {
    // Case 1: If user is trying to delete the NEW NOTE i.e. he has come to
    // the detail page by pressing the FAB of NoteList page.
    if (_note.id == null) {
      _showAlertDialog('Status', 'No Note was deleted');
      return;
    }

    // Case 2: User is trying to delete the old note that already has a valid ID.
    int result = await _dbHelper.deleteNote(_note.id);
    if (result != 0) {
      _showAlertDialog('Status', 'Note Deleted Successfully')
          .then((value) => {if (value == 1) _moveBack()});
    } else {
      _showAlertDialog('Status', 'Error Occurred while Deleting Note');
    }
  }

  Future<int> _showAlertDialog(String title, String message) async {
    await showDialog(
        context: context,
        builder: (context) =>
            AlertDialog(
              title: Text(title),
              content: Text(message),
              actions: <Widget>[
                FlatButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('Ok'),
                ),
              ],
            ));
    return 1;
  }
}
