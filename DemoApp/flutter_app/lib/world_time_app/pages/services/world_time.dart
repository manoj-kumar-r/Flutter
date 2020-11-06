import 'dart:convert';

import 'package:http/http.dart';
import 'package:intl/intl.dart';

String baseUrl = 'http://worldtimeapi.org/api/timezone/';

class WorldTime {
  String location; //Location name for the ui
  String time; //Time in that location
  String flag; //url to asset flag icon
  String url; //url to api end point
  bool isDayTime; // true oor false Is day or night

  WorldTime({this.location, this.flag, this.url});

  Future<void> getTime() async {
    //Simulate a network request for a user name
    // make the request
    try {
      Response response = await get('$baseUrl$url');
      Map data = jsonDecode(response.body);
      print('data:$data');

      // get properties from json
      String datetime = data['datetime'];
      String offset = data['utc_offset'].substring(1, 3);
      print('datetime:$datetime');
      print('offset:$offset');

      // create DateTime object
      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offset)));
      print(now);

      //set time property
      time = DateFormat.jm().format(now);

      isDayTime = now.hour > 6 && now.hour < 20 ? true : false;
    } catch (e) {
      print('Caught Error:$e');
      time = null;
    }
  }
}
