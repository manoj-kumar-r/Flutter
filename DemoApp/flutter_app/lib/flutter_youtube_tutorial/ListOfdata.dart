import 'package:flutter/material.dart';

class QuoteList extends StatefulWidget {
  @override
  _QuoteListState createState() => _QuoteListState();
}

class _QuoteListState extends State<QuoteList> {
  List<Quote> quotes = [
    Quote(text: "Test 1", author: "T1"),
    Quote(text: "Test 2", author: "T2"),
    Quote(text: "Test 3", author: "T3"),
    Quote(text: "Test 4", author: "T4"),
    Quote(text: "Test 5", author: "T5"),
    Quote(text: "Test 6", author: "T6"),
    Quote(text: "Test 7", author: "T7"),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: Colors.grey[850]),
      home: Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          title: Text('List Of Data'),
          centerTitle: true,
          backgroundColor: Colors.redAccent,
          elevation: 0.0,
        ),
        body: Column(
          children: quotes
              .map((quote) => QuoteCard(
                  quote: quote,
                  deleteMethod: () {
                    setState(() {
                      quotes.remove(quote);
                    });
                  }))
              .toList(),
        ),
      ),
    );
  }
}

class QuoteCard extends StatelessWidget {
  final Quote quote;
  final Function deleteMethod;

  QuoteCard({this.quote, this.deleteMethod});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.fromLTRB(16, 10, 16, 0),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              quote.text,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.grey[600]),
            ),
            SizedBox(height: 6),
            Text(
              quote.author,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: Colors.grey[800]),
            ),
            SizedBox(height: 8),
            FlatButton.icon(
              onPressed: deleteMethod,
              label: Text('Delete Quote'),
              icon: Icon(Icons.delete),
            )
          ],
        ),
      ),
    );
  }
}

class Quote {
  String text;
  String author;

  //constructor with named parameters
  Quote({this.text, this.author});

  @override
  String toString() {
    return 'Quote { text: $text, author: $author }';
  }
}
