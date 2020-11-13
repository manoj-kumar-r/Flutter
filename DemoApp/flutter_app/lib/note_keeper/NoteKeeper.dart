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
  int count = 2;

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
        onPressed: () => _detailsPage('Add Note'),
      ),
    );
  }

  Widget getListView() {
    var listView = ListView.builder(
        itemCount: count,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.yellow,
                child: Icon(Icons.arrow_right),
              ),
              title: Text(index.toString()),
              onTap: () {
                _detailsPage('Edit Note');
              },
              trailing: Icon(Icons.delete),
            ),
          );
        });
    return listView;
  }

  void _detailsPage(String title) {
    Navigator.pushNamed(
      context,
      '/createNote',
      arguments: {'title': title},
    );
  }
}
