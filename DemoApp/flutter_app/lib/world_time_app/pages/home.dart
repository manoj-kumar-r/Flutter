import 'package:flutter/material.dart';

import 'choose_location.dart';
import 'loading.dart';

class WorldTimeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => Loading(),
        '/home': (context) => WorldTimeHome(),
        '/location': (context) => ChooseLocation()
      },
    );
  }
}

class WorldTimeHome extends StatefulWidget {
  @override
  _WorldTimeHomeState createState() => _WorldTimeHomeState();
}

class _WorldTimeHomeState extends State<WorldTimeHome> {
  Map data = {};

  @override
  Widget build(BuildContext context) {
    data = data.isEmpty ? ModalRoute.of(context).settings.arguments : data;
    print(data);

    //set back ground
    bool isDayTime = data['isDayTime'];
    String bgImage = isDayTime ? 'day.png' : 'night.png';
    Color backGroundColor = isDayTime ? Colors.blue : Colors.indigo[700];
    Color textColor = isDayTime ? Colors.white : Colors.white;
    Color iconColor = isDayTime ? Colors.grey[300] : Colors.white;

    return Scaffold(
      backgroundColor: backGroundColor,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/$bgImage'),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 120, 0, 0),
            child: Column(
              children: [
                FlatButton.icon(
                  onPressed: () async {
                    dynamic result =
                        await Navigator.pushNamed(context, '/location');
                    if (result is Map) {
                      setState(() {
                        data = result;
                      });
                    }
                  },
                  icon: Icon(
                    Icons.edit_location,
                    color: iconColor,
                  ),
                  label: Text(
                    'Edit Location',
                    style: TextStyle(
                      color: iconColor,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      data['location'],
                      style: TextStyle(
                        fontSize: 20,
                        letterSpacing: 2,
                        color: textColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Text(
                  data['time'],
                  style: TextStyle(
                    fontSize: 66,
                    letterSpacing: 2,
                    color: textColor,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
