import 'package:flutter/material.dart';

class NKCreateNote extends StatefulWidget {
  @override
  _NKCreateNoteState createState() => _NKCreateNoteState();
}

class _NKCreateNoteState extends State<NKCreateNote> {
  var _formKey = GlobalKey<FormState>();
  var _titleController = TextEditingController();
  var _descriptionController = TextEditingController();
  var _priority = ['High', 'Low', 'Medium'];
  var _prioritySelected = 'High';

  @override
  void initState() {
    super.initState();
    _prioritySelected = _priority.first;
  }

  @override
  Widget build(BuildContext context) {
    var _textStyle = Theme.of(context).textTheme.title;

    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Note'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DropdownButton<String>(
                    value: this._prioritySelected,
                    items: _priority.map(
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
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  style: _textStyle,
                  validator: (String userInput) {
                    if (userInput.isEmpty) {
                      return 'Please enter title';
                    } else {
                      return null;
                    }
                  },
                  controller: _titleController,
                  decoration: InputDecoration(
                    labelText: 'Title',
                    hintText: 'Enter Title',
                    labelStyle: _textStyle,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    errorStyle: TextStyle(
                      color: Colors.redAccent,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  style: _textStyle,
                  validator: (String userInput) {
                    if (userInput.isEmpty) {
                      return 'Please enter principal';
                    } else {
                      return null;
                    }
                  },
                  controller: _descriptionController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Description',
                    labelStyle: _textStyle,
                    hintText: 'Enter Description',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    errorStyle: TextStyle(
                      color: Colors.redAccent,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: RaisedButton(
                      elevation: 6.0,
                      color: Theme.of(context).accentColor,
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
                      color: Theme.of(context).accentColor,
                      textColor: Colors.white,
                      child: Text(
                        'Deleter',
                        textScaleFactor: 1.5,
                      ),
                      onPressed: () => _onDeleteClicked(),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onDropDownSelected(String newValueSelected) {
    setState(() {
      _prioritySelected = newValueSelected;
    });
  }

  void _onDeleteClicked() {}

  void _onSaveClicked() {
    setState(() {
      if (_formKey.currentState.validate()) {}
    });
  }
}
