import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import 'createnote.dart';
import 'sqdb.dart';

class NoteKeeper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Note Keeper App',
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.deepPurple,
        accentColor: Colors.deepPurpleAccent,
      ),
      home: NKHome(),
    );
  }
}

class NKHome extends StatefulWidget {
  @override
  _NKHomeState createState() => _NKHomeState();
}

class _NKHomeState extends State<NKHome> {
  var _dbHelper = DbHelper();
  var _noteList = List<Note>();
  var _count = 0;

  @override
  void initState() {
    super.initState();
    _noteList = List<Note>();
    updateListView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text('Notes'),
      ),
      body: getListView(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => navigateToDetail(Note('', '', 1), 'Add Note'),
      ),
    );
  }

  Widget getListView() {
    var listView = ListView.builder(
        itemCount: _count,
        itemBuilder: (context, index) {
          print(this._noteList[index].toMap());
          return Card(
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor:
                    getPriorityColor(this._noteList[index].priority),
                child: getPriorityIcon(this._noteList[index].priority),
              ),
              title: Text(this._noteList[index].title),
              subtitle: Text(this._noteList[index].date),
              onTap: () {
                navigateToDetail(this._noteList[index], 'Edit Note');
              },
              trailing: GestureDetector(
                child: Icon(Icons.delete),
                onTap: () {
                  _delete(this._noteList[index]);
                },
              ),
            ),
          );
        });
    return listView;
  }

  void _delete(Note note) async {
    var result = await _dbHelper.deleteNote(note.id);
    if (result != 0) {
      _showSnackBar('Note deleted');
      updateListView();
    }
  }

  void _showSnackBar(String message) {
    var snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  //return priority color
  Color getPriorityColor(int priority) {
    switch (priority) {
      case 1:
        return Colors.red;
      case 2:
        return Colors.yellow;
      case 3:
        return Colors.orange;
      default:
        return Colors.yellow;
    }
  }

  //return priority Icon
  Icon getPriorityIcon(int priority) {
    switch (priority) {
      case 1:
        return Icon(Icons.play_arrow);
      case 2:
        return Icon(Icons.keyboard_arrow_right);
      case 3:
        return Icon(Icons.pause_sharp);
      default:
        return Icon(Icons.keyboard_arrow_right);
    }
  }

  void navigateToDetail(Note note, String title) async {
    bool result = await Navigator.push(context, MaterialPageRoute(
      builder: (context) {
        return NKCreateNote(note, title);
      },
    ));
    if (result == true) {
      setState(() {
        updateListView();
      });
    }
  }

  void updateListView() {
    final Future<Database> dbFuture = _dbHelper.initializeDatabase();
    dbFuture.then((database) {
      Future<List<Note>> noteListFuture = _dbHelper.getNoteList();
      noteListFuture.then((noteList) {
        setState(() {
          this._noteList = noteList;
          this._count = noteList.length;
        });
      });
    });
  }
}
