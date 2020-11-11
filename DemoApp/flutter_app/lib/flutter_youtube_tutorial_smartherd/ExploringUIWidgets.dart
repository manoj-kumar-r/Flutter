import 'package:flutter/material.dart';

class ExploringUI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Stateful App Example',
      home: StatefulFavouriteCity(),
    );
  }
}

class StatefulFavouriteCity extends StatefulWidget {
  @override
  _StatefulFavouriteCityState createState() => _StatefulFavouriteCityState();
}

class _StatefulFavouriteCityState extends State<StatefulFavouriteCity> {
  String _nameOfTheCity = '';
  String _currencySelected = 'Select';
  var _currencies = ['Select','Rupees', 'Dollar', 'Pounds'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Stateful App Example'),
      ),
      body: Container(
        margin: EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(onChanged: (String userInput) {
              setState(() {
                this._nameOfTheCity = userInput;
              });
            }, onSubmitted: (String userInput) {
              setState(() {
                this._nameOfTheCity = userInput;
              });
            }),
            DropdownButton<String>(
              value: this._currencySelected,
              items: _currencies.map(
                (item) {
                  return DropdownMenuItem<String>(
                    value: item,
                    child: Text(item),
                  );
                },
              ).toList(),
              onChanged: (String newValueSelected) {
                _dropDownValueSelected(newValueSelected);
              },
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Your City is $_nameOfTheCity',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Your Currency is $_currencySelected',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _dropDownValueSelected(String newValue){
    setState(() {
      this._currencySelected = newValue;
    });
  }
}

//Container are like Div elements in the web
class Examples extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Exploring UI Widgets',
      home: dynamicListView(context),
    );
  }

  Widget dynamicListView(BuildContext context) {
    var items = List<String>.generate(1000, (index) => 'Item $index');
    var listView = ListView.builder(itemBuilder: (context, index) {
      return Card(
        child: ListTile(
          leading: Icon(Icons.arrow_right),
          title: getText(items[index]),
          onTap: () {
            showSnackBar(context, items[index]);
          },
        ),
      );
    });
    return Scaffold(
      appBar: AppBar(
        title: Text('Dynamic List Widget'),
        backgroundColor: Colors.blueAccent,
      ),
      body: listView,
      floatingActionButton: FloatingActionButton(
        tooltip: 'Add One More Item',
        child: Icon(Icons.add),
        onPressed: () {
          showSnackBar(context, 'Floating Button');
        },
      ),
    );
  }

  void showSnackBar(BuildContext context, String item) {
    var snackBar = SnackBar(
      content: getText("you tapped $item"),
      action: SnackBarAction(
        label: 'UNDO',
        onPressed: () {},
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Widget fixedListView() {
    var listView = ListView(
      children: [
        ListTile(
          leading: Icon(Icons.landscape),
          title: getText('Landscape'),
          subtitle: getText('Beautiful View'),
          trailing: Icon(Icons.wb_sunny),
          onTap: () {},
        ),
        ListTile(
          leading: Icon(Icons.laptop_chromebook),
          title: getText('Windows'),
          onTap: () {},
        ),
        ListTile(
          leading: Icon(Icons.phone),
          title: getText('Phone'),
          onTap: () {},
        ),
        getText('Another Element in list'),
        Container(
          color: Colors.red,
          height: 50,
        )
      ],
    );
    return Scaffold(
      appBar: AppBar(
        title: Text('Fixed List Widget'),
        backgroundColor: Colors.blueAccent,
      ),
      body: listView,
    );
  }

  Widget home() {
    return Examples();
  }

  Widget getText(String text) {
    return Text(
      text,
      style: TextStyle(
        decoration: TextDecoration.none,
        fontSize: 20.0,
        color: Colors.grey,
        fontFamily: 'IndieFlowerRegular',
      ),
      textDirection: TextDirection.ltr,
    );
  }
}

class CustomContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.only(left: 10, right: 10),
        margin: EdgeInsets.only(left: 35, top: 50, right: 35),
        alignment: Alignment.center,
        color: Colors.deepPurple[200],
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Spice Jet ',
                    style: TextStyle(
                      decoration: TextDecoration.none,
                      fontSize: 20.0,
                      color: Colors.white,
                      fontFamily: 'IndieFlowerRegular',
                    ),
                    textDirection: TextDirection.ltr,
                  ),
                ),
                Expanded(
                  child: Text(
                    'From Mumbai to bangalore view new delhi.',
                    style: TextStyle(
                      decoration: TextDecoration.none,
                      fontSize: 20.0,
                      color: Colors.white,
                      fontFamily: 'IndieFlowerRegular',
                    ),
                    textDirection: TextDirection.ltr,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Indigo ',
                    style: TextStyle(
                      decoration: TextDecoration.none,
                      fontSize: 20.0,
                      color: Colors.white,
                      fontFamily: 'IndieFlowerRegular',
                    ),
                    textDirection: TextDirection.ltr,
                  ),
                ),
                Expanded(
                  child: Text(
                    'From Mumbai to bangalore view Amritsar.',
                    style: TextStyle(
                      decoration: TextDecoration.none,
                      fontSize: 20.0,
                      color: Colors.white,
                      fontFamily: 'IndieFlowerRegular',
                    ),
                    textDirection: TextDirection.ltr,
                  ),
                ),
              ],
            ),
            CustomImage(),
            CustomRaisedButton()
          ],
        ),
      ),
    );
  }
}

class CustomImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AssetImage assetImage = AssetImage('assets/images/germany.png');
    return Image(
      image: assetImage,
      width: 100,
      height: 100,
    );
  }
}

class CustomRaisedButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(30.0),
      width: 250,
      height: 50,
      child: RaisedButton(
        onPressed: () => showAlert(context),
        color: Colors.deepOrange,
        elevation: 6.0,
        child: Text(
          'Click me for alert',
          style: TextStyle(
            decoration: TextDecoration.none,
            fontSize: 20.0,
            color: Colors.white,
            fontFamily: 'IndieFlowerRegular',
          ),
        ),
      ),
    );
  }

  void showAlert(BuildContext context) {
    var alertDialog = AlertDialog(
      title: Text(
        'Clicked Button',
        style: TextStyle(
          decoration: TextDecoration.none,
          fontSize: 20.0,
          color: Colors.black,
          fontFamily: 'IndieFlowerRegular',
        ),
      ),
      content: Text(
        'Thanks for clicking the button',
        style: TextStyle(
          decoration: TextDecoration.none,
          fontSize: 20.0,
          color: Colors.black,
          fontFamily: 'IndieFlowerRegular',
        ),
      ),
    );
    showDialog(
      context: context,
      builder: (BuildContext context) => alertDialog,
    );
  }
}
