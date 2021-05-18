import 'dart:io';

import 'package:demo_note_app/com/sysfore/note/demo/authenticate/splash.dart';
import 'package:demo_note_app/com/sysfore/note/demo/authenticated/createnote.dart';
import 'package:demo_note_app/com/sysfore/note/demo/authenticated/profile.dart';
import 'package:demo_note_app/com/sysfore/note/demo/customui/customuielements.dart';
import 'package:demo_note_app/com/sysfore/note/demo/customui/lifecycleWatcherState.dart';
import 'package:demo_note_app/com/sysfore/note/demo/db/dbhelper.dart';
import 'package:demo_note_app/com/sysfore/note/demo/models/note_model.dart';
import 'package:demo_note_app/com/sysfore/note/demo/utils/constants.dart';
import 'package:demo_note_app/com/sysfore/note/demo/utils/customcolor.dart';
import 'package:demo_note_app/com/sysfore/note/demo/utils/fireauth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashBoardRoute extends CupertinoPageRoute {
  DashBoardRoute() : super(builder: (BuildContext context) => new DashBoard());

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return new FadeTransition(
      opacity: animation,
      child: new DashBoard(),
    );
  }
}

class DashBoard extends StatefulWidget {
  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends LifecycleWatcherState<DashBoard> {
  var _filterItems = ["All Notes", "Audio", "Images"];

  var _selectedIndex = 0;

  var _dataBase = DbHelper.instance;

  List<NoteModel> _noteList = [];
  List<NoteModel> _filterNoteList = [];

  var _searchController = new TextEditingController();

  @override
  void initState() {
    super.initState();
    _noteList = [];
    _filterNoteList = [];
    getData();
  }

  @override
  void onDetached() {
    print("onDetached");
  }

  @override
  void onInactive() {
    print("onInactive");
  }

  @override
  void onPaused() {
    print("onPaused");
  }

  @override
  void onResumed() {
    print("onResumed");
    getData();
  }

  Future<void> getData() async {
    print("Data called");
    var data;
    if (_selectedIndex == 1) {
      data = await _dataBase.getNoteListList(
          2, AuthenticationService.shared.getCurrentUid(),
          type: "A");
    } else if (_selectedIndex == 2) {
      data = await _dataBase.getNoteListList(
          2, AuthenticationService.shared.getCurrentUid(),
          type: "I");
    } else {
      data = await _dataBase.getNoteListList(
          0, AuthenticationService.shared.getCurrentUid());
    }
    setState(() {
      _noteList = data;
      _filterNoteList = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _getAppBar(),
      body: _getUI(),
      floatingActionButton: _getFloatingButton(),
    );
  }

  Widget _getAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      centerTitle: false,
      title: Text(
        "Notely",
        textAlign: TextAlign.start,
        style: TextStyle(
          decoration: TextDecoration.none,
          color: Colors.black87,
          fontSize: 20,
          fontFamily: 'OpenSansBold',
        ),
        textDirection: TextDirection.ltr,
      ),
      elevation: 0,
      actions: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () {
              _onAppBarProfileTapped();
            },
            child: CircleAvatar(
              radius: 15.0,
              backgroundColor: CustomColors.colorPrimary,
              child: CircleAvatar(
                radius: 13.0,
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.account_circle,
                  color: CustomColors.colorPrimary,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _getFloatingButton() {
    return FloatingActionButton.extended(
      backgroundColor: CustomColors.colorPrimary,
      onPressed: () {
        _onCreateTapped();
      },
      icon: Icon(
        Icons.add,
        color: Colors.white,
      ),
      label: CustomUIElements.getTextColor(Colors.white, 15, "Create"),
    );
  }

  Widget _getUI() {
    return Container(
      margin: EdgeInsets.only(left: 15, right: 15, top: 10),
      child: Column(
        children: [
          _getSearch(),
          SizedBox(height: 10),
          _getFiler(),
          SizedBox(height: 10),
          _getNoteList(),
          SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget _getSearch() {
    return TextField(
      autocorrect: true,
      onChanged: (value) => _searchValue(value),
      controller: _searchController,
      decoration: InputDecoration(
        hintText: 'Search',
        prefixIcon: Icon(
          Icons.search,
          color: Colors.black,
        ),
        hintStyle: TextStyle(color: Colors.black45),
        filled: true,
        fillColor: Colors.black.withAlpha(8),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12.0)),
          borderSide: BorderSide(color: Colors.white, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          borderSide: BorderSide(color: Colors.black26, width: 1),
        ),
      ),
    );
  }

  Widget _getFiler() {
    return SizedBox(
      height: 45,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: _filterItems.length,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.only(right: 10),
            padding: EdgeInsets.only(left: 2, right: 2),
            decoration: BoxDecoration(
              color: (index == _selectedIndex)
                  ? CustomColors.colorPrimary
                  : Colors.black12,
              borderRadius: BorderRadius.circular(8),
            ),
            child: TextButton(
              onPressed: () {
                _onFilterClicked(index);
              },
              child: CustomUIElements.getTextColor(
                  (index == _selectedIndex) ? Colors.white : Colors.black,
                  15,
                  _filterItems[index]),
            ),
          );
        },
      ),
    );
  }

  Widget _getNoteList() {
    return Expanded(
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemCount: _filterNoteList.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              _onNoteClicked(index);
            },
            child: Container(
              margin: EdgeInsets.only(top: 5),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.black.withAlpha(8),
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      Icon(
                        (_filterNoteList[index].isAttached)
                            ? (_filterNoteList[index].attachType == "A")
                                ? Icons.audiotrack_outlined
                                : Icons.photo
                            : Icons.note_rounded,
                        color: CustomColors.colorPrimary,
                        size: 40,
                      ),
                      SizedBox(width: 5),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            CustomUIElements.getTextAC(
                              TextAlign.start,
                              Colors.black87,
                              14,
                              _filterNoteList[index].noteTitle,
                            ),
                            SizedBox(height: 5),
                            CustomUIElements.getTextAC(
                              TextAlign.start,
                              Colors.black54,
                              10,
                              _filterNoteList[index].createdDate,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  CustomUIElements.getTextAC(
                    TextAlign.start,
                    Colors.black,
                    14,
                    _filterNoteList[index].noteDesc,
                  ),
                  SizedBox(height: 10),
                  if (_filterNoteList[index].isAttached)
                    if (_filterNoteList[index].attachType == "I")
                      ClipRRect(
                        borderRadius: BorderRadius.circular(15.0),
                        child: Image.file(
                          File(_filterNoteList[index].attachPath),
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _onAppBarProfileTapped() {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  ListTile(
                      leading: new Icon(
                        Icons.account_circle,
                        color: CustomColors.colorPrimary,
                      ),
                      title: Text("Profile"),
                      onTap: () {
                        Navigator.of(context).pop();
                        _profileTapped();
                      }),
                  ListTile(
                      leading: new Icon(
                        Icons.logout,
                        color: CustomColors.colorPrimary,
                      ),
                      title: Text("Logout"),
                      onTap: () {
                        Navigator.of(context).pop();
                        _logOutTapped();
                      }),
                ],
              ),
            ),
          );
        });
  }

  void _onFilterClicked(int index) {
    setState(() {
      _selectedIndex = index;
      _searchController.text = "";
      getData();
    });
  }

  Future<void> _onNoteClicked(int index) async {
    var note = _filterNoteList[index];
    var pref = await SharedPreferences.getInstance();
    await pref.setString(PreferenceHolders.noteId, note.keyId);
    Navigator.push(context, new CreateNoteRoute()).then((value) => {getData()});
  }

  void _searchValue(String value) {
    _filterNoteList = [];
    List<NoteModel> tmpList = [];
    if (value.length > 0) {
      for (int i = 0; i < _noteList.length; i++) {
        if (_noteList[i].noteTitle.contains(value) ||
            _noteList[i].noteDesc.contains(value)) {
          if (!tmpList.contains(_noteList[i])) {
            tmpList.add(_noteList[i]);
          }
        }
      }
    } else {
      tmpList.addAll(_noteList);
    }
    setState(() {
      _filterNoteList = tmpList;
    });
  }

  Future<void> _onCreateTapped() async {
    var pref = await SharedPreferences.getInstance();
    await pref.setString(PreferenceHolders.noteId, "");
    Navigator.push(context, new CreateNoteRoute()).then((value) => {getData()});
  }

  void _profileTapped() {
    Navigator.push(context, new ProfileRoute());
  }

  Future<void> _logOutTapped() async {
    await AuthenticationService.shared.signOut(
        onStatusChanged: (status, message) async {
      if (status) {
        var prefs = await SharedPreferences.getInstance();
        await prefs.setBool(PreferenceHolders.loggedId, false);
        CustomUIElements.showSnackBar(context, 'Logout Success');
        Navigator.pushAndRemoveUntil(
            context, new SplashRoute(), (route) => false);
      } else {
        CustomUIElements.showSnackBar(context, message, color: Colors.red);
      }
    });
  }
}
