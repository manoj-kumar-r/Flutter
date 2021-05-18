import 'dart:io';

import 'package:demo_note_app/com/sysfore/note/demo/customui/customuielements.dart';
import 'package:demo_note_app/com/sysfore/note/demo/db/dbhelper.dart';
import 'package:demo_note_app/com/sysfore/note/demo/models/note_model.dart';
import 'package:demo_note_app/com/sysfore/note/demo/utils/constants.dart';
import 'package:demo_note_app/com/sysfore/note/demo/utils/customcolor.dart';
import 'package:demo_note_app/com/sysfore/note/demo/utils/fireauth.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CreateNoteRoute extends CupertinoPageRoute {
  CreateNoteRoute()
      : super(builder: (BuildContext context) => new CreateNote());

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return new FadeTransition(
      opacity: animation,
      child: new CreateNote(),
    );
  }
}

class CreateNote extends StatefulWidget {
  @override
  _CreateNoteState createState() => _CreateNoteState();
}

class _CreateNoteState extends State<CreateNote> {
  var _currentTime = DateTime.now();
  var _formKey = GlobalKey<FormState>();

  var _noteDescController = TextEditingController();
  var _noteTitleController = TextEditingController();

  var _note = NoteModel();
  var _dataBase = DbHelper.instance;

  var _picker = ImagePicker();
  var _audioPath = "";

  @override
  void initState() {
    _getEditingNote();
    super.initState();
  }

  @override
  void dispose() {
    _noteDescController.dispose();
    _noteTitleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _getAppBar(),
      body: Form(
        key: _formKey,
        child: _getUi(),
      ),
    );
  }

  Widget _getAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      centerTitle: false,
      elevation: 0,
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: Colors.black54),
        onPressed: () => Navigator.of(context).pop(),
      ),
      title: Text(
        "Create Note",
        textAlign: TextAlign.start,
        style: TextStyle(
          decoration: TextDecoration.none,
          color: Colors.black87,
          fontSize: 20,
          fontFamily: 'OpenSansBold',
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () {
              _saveNote();
            },
            child: Icon(
              Icons.check_rounded,
              color: CustomColors.colorPrimary,
            ),
          ),
        ),
      ],
    );
  }

  Widget _getUi() {
    return Container(
      color: Colors.black12.withAlpha(5),
      child: Stack(
        children: [
          _topView(),
        ],
      ),
    );
  }

  Widget _topView() {
    return Align(
      alignment: Alignment.topLeft,
      child: Container(
        margin: EdgeInsets.only(left: 20, right: 20, top: 30),
        child: SingleChildScrollView(
          physics: ClampingScrollPhysics(),
          scrollDirection: Axis.vertical,
          child: _getNoteInput(),
        ),
      ),
    );
  }

  Widget _getNoteInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomUIElements.getTextAC(
            TextAlign.start, Colors.black54, 16, "Date & Time : "),
        SizedBox(height: 5),
        CustomUIElements.getTextAC(TextAlign.start, Colors.black, 16,
            "${_getFormattedTime(dateString: _note.createdDate)}"),
        SizedBox(height: 10),
        CustomUIElements.getTextAC(
            TextAlign.start, Colors.black54, 16, "Note Title : "),
        SizedBox(height: 10),
        _noteTitleTextFiled(),
        SizedBox(height: 10),
        CustomUIElements.getTextAC(
            TextAlign.start, Colors.black54, 16, "Note Description : "),
        SizedBox(height: 10),
        _noteTextFiled(),
        SizedBox(height: 5),
        if (_note.attachPath != null && _note.attachPath.length > 0)
          _getSelectedImage(),
        SizedBox(height: 5),
        _bottomView(),
        SizedBox(height: 10),
      ],
    );
  }

  Widget _noteTitleTextFiled() {
    return TextFormField(
      minLines: 1,
      maxLines: 1,
      autofocus: false,
      keyboardType: TextInputType.text,
      validator: (String userInput) {
        if (userInput.isEmpty) {
          return 'Please enter note title';
        } else {
          return null;
        }
      },
      controller: _noteTitleController,
      onChanged: (value) => _updateNoteTitle(value),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        hintText: 'Title',
        hintStyle: TextStyle(color: Colors.grey),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
      ),
    );
  }

  Widget _getSelectedImage() {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          child: Image.file(
            File(_note.attachPath),
            fit: BoxFit.fitHeight,
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: GestureDetector(
            onTap: () {
              setState(() {
                _note.attachPath = "";
              });
            },
            child: Container(
              padding: EdgeInsets.all(5),
              child: CircleAvatar(
                radius: 15.0,
                backgroundColor: CustomColors.colorPrimary,
                child: Icon(
                  Icons.close,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _noteTextFiled() {
    return TextFormField(
      minLines: 10,
      maxLines: 10,
      autofocus: false,
      keyboardType: TextInputType.multiline,
      validator: (String userInput) {
        if (userInput.isEmpty) {
          return 'Please enter note description';
        } else {
          return null;
        }
      },
      controller: _noteDescController,
      onChanged: (value) => _updateNoteDescription(value),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        hintText: 'description',
        hintStyle: TextStyle(color: Colors.grey),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
      ),
    );
  }

  Widget _bottomView() {
    return SizedBox(
      height: 50,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: Container(
          margin: EdgeInsets.only(left: 40, right: 40),
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: GestureDetector(
                  onTap: () {
                    _selectAudio();
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.25,
                    child: Icon(
                      Icons.audiotrack,
                      color: CustomColors.colorPrimary,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: GestureDetector(
                  onTap: () {
                    _selectImage();
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.25,
                    child: Icon(
                      Icons.photo_album,
                      color: CustomColors.colorPrimary,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: GestureDetector(
                  onTap: () {
                    _selectCamera();
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.25,
                    child: Icon(
                      Icons.camera,
                      color: CustomColors.colorPrimary,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _updateNoteTitle(String value) {
    _note.noteTitle = value;
  }

  void _updateNoteDescription(String value) {
    _note.noteDesc = value;
  }

  String _getFormattedTime({String dateString = ""}) {
    var formatter = new DateFormat('dd MMM yyyy hh:mm');
    if (dateString.length > 0) {
      return formatter.format(formatter.parse(dateString));
    }
    return formatter.format(_currentTime);
  }

  _selectAudio() async {
    try {
      var result = await FilePicker.platform
          .pickFiles(type: FileType.audio, allowMultiple: false);
      setState(() {
        _audioPath = result.files.single.path;
      });
    } on Exception catch (e) {
      print(e);
      CustomUIElements.showSnackBar(context, e.toString(), color: Colors.red);
      setState(() {
        _audioPath = "";
      });
    }
  }

  _selectImage() async {
    try {
      var _image = await _picker.getImage(source: ImageSource.gallery);
      setState(() {
        this._note.attachPath = _image.path;
        this._note.isAttached = true;
        this._note.attachType = "I";
      });
    } on Exception catch (e) {
      CustomUIElements.showSnackBar(context, e.toString(), color: Colors.red);
      setState(() {
        this._note.attachPath = "";
        this._note.isAttached = false;
        this._note.attachType = "";
      });
    }
  }

  _selectCamera() async {
    try {
      var _image = await _picker.getImage(source: ImageSource.camera);
      setState(() {
        this._note.attachPath = _image.path;
        this._note.isAttached = true;
        this._note.attachType = "I";
      });
    } on Exception catch (e) {
      print(e);
      CustomUIElements.showSnackBar(context, e.toString(), color: Colors.red);
      setState(() {
        this._note.attachPath = "";
        this._note.isAttached = false;
        this._note.attachType = "";
      });
    }
  }

  Future<void> _saveNote() async {
    if (_formKey.currentState.validate()) {
      _note.userId = AuthenticationService.shared.getCurrentUid();
      _note.createdDate = _getFormattedTime();
      var id = await _dataBase.insertNote(_note);
      if (id > 0) {
        CustomUIElements.showSnackBar(context, "Note Saved");
        Navigator.pop(context);
      }
    }
  }

  Future<void> _getEditingNote() async {
    var pref = await SharedPreferences.getInstance();
    var noteId = pref.getString(PreferenceHolders.noteId);
    if (noteId != null && noteId.length > 0) {
      var data = await _dataBase.getNoteListList(
          1, AuthenticationService.shared.getCurrentUid(),
          noteId: noteId);
      if (data.length > 0) {
        setState(() {
          _note = data[0];
          _noteTitleController.text = _note.noteTitle;
          _noteDescController.text = _note.noteDesc;
        });
      } else {
        setState(() {
          _note = NoteModel();
          _noteTitleController.text = "";
          _noteDescController.text = "";
        });
      }
    }
  }
}
