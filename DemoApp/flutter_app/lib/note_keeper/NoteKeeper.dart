import 'package:flutter/material.dart';

import 'createnote.dart';

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
      initialRoute: '/',
      routes: {
        '/': (context) => NKHome(),
        '/createNote': (context) => NKCreateNote(),
      },
    );
  }
}

class NKHome extends StatefulWidget {
  @override
  _NKHomeState createState() => _NKHomeState();
}

class _NKHomeState extends State<NKHome> {
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
        onPressed: () => _createNewNote(),
      ),
    );
  }

  Widget getListView(){
    var items = List<String>.generate(1000, (index) => 'Item $index');
    var listView = ListView.builder(itemBuilder: (context, index) {
      return Card(
        child: ListTile(
          leading: Icon(Icons.arrow_right),
          title: Text(items[index]),
          onTap: () {
            _editNote();
          },
        ),
      );
    });
    return listView;
  }

  void _editNote(){
    Navigator.pushNamed(context, '/createNote');
  }

  void _createNewNote() {
    Navigator.pushNamed(context, '/createNote');
  }
}
