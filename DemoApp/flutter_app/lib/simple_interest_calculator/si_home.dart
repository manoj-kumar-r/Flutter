import 'package:flutter/material.dart';

class SimpleInterestCalculator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Simple Interest Calculator App',
      home: SIForm(),
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.indigo,
        accentColor: Colors.indigoAccent,
      ),
    );
  }
}

class SIForm extends StatefulWidget {
  @override
  _SIFormState createState() => _SIFormState();
}

class _SIFormState extends State<SIForm> {
  var _currencies = ['Rupees', 'Dollar', 'Pounds'];
  var _currentItemSelected = '';
  var _calculatedReturns = '';

  var _principalController = TextEditingController();
  var _rateController = TextEditingController();
  var _termController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _currentItemSelected = _currencies.first;
  }

  @override
  Widget build(BuildContext context) {
    var _textStyle = Theme.of(context).textTheme.title;
    return Scaffold(
      appBar: AppBar(
        title: Text('Simple Interest Calculator'),
      ),
      body: Container(
        margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
        child: ListView(
          children: [
            getImageAsset(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                keyboardType: TextInputType.number,
                style: _textStyle,
                controller: _principalController,
                decoration: InputDecoration(
                    labelText: 'Principal',
                    hintText: 'Enter Principal eg. 12000',
                    labelStyle: _textStyle,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    )),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                style: _textStyle,
                controller: _rateController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: 'Rate of Interest',
                    labelStyle: _textStyle,
                    hintText: 'In Percent',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    )),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      style: _textStyle,
                      controller: _termController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          labelText: 'Term',
                          hintText: 'In Years',
                          labelStyle: _textStyle,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                          )),
                    ),
                  ),
                ),
                SizedBox(width: 25),
                Expanded(
                  child: DropdownButton<String>(
                    value: this._currentItemSelected,
                    items: _currencies.map(
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
                )
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: RaisedButton(
                    elevation: 6.0,
                    color: Theme.of(context).accentColor,
                    textColor: Theme.of(context).primaryColorDark,
                    child: Text(
                      'Calculate',
                      textScaleFactor: 1.5,
                    ),
                    onPressed: () => _onCalculateTotalReturns(),
                  ),
                ),
                SizedBox(width: 20),
                Expanded(
                  child: RaisedButton(
                    elevation: 6.0,
                    color: Theme.of(context).primaryColorDark,
                    textColor: Theme.of(context).primaryColorLight,
                    child: Text(
                      'Reset',
                      textScaleFactor: 1.5,
                    ),
                    onPressed: () => _onResetClicked(),
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                _calculatedReturns,
                style: _textStyle,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget getImageAsset() {
    return Container(
      child: Image(
        image: AssetImage('assets/images/germany.png'),
        width: 125,
        height: 125,
      ),
    );
  }

  void _onDropDownSelected(String newValueSelected) {
    setState(() {
      _currentItemSelected = newValueSelected;
    });
  }

  void _onResetClicked() {
    setState(() {
      _calculatedReturns = '';
      _principalController.text = '';
      _rateController.text = '';
      _termController.text = '';
      _currentItemSelected = _currencies.first;
    });
  }

  void _onCalculateTotalReturns() {
    var principal = double.parse(_principalController.text);
    var rate = double.parse(_rateController.text);
    var term = double.parse(_termController.text);
    var totalAmountPay = principal + (principal * rate * term) / 100;
    setState(() {
      _calculatedReturns =
          'After $term years, your investment will be worth $totalAmountPay $_currentItemSelected';
    });
  }
}
