import 'package:flutter/material.dart';
import 'package:flutter_app/world_time_app/pages/services/world_time.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  List<WorldTime> worldTimeList = [
    WorldTime(location: 'Berlin', flag: 'germany.png', url: 'Europe/Berlin')
  ];

  void setUpWorldTime() async {
    WorldTime instance = WorldTime(
        location: 'Berlin', flag: 'germany.png', url: 'Europe/Berlin');
    await instance.getTime();

    if(instance.time !=null){
      print(instance.time);
      Navigator.pushReplacementNamed(context, '/home', arguments: {
        'location': instance.location,
        'time': instance.time,
        'flag': instance.flag,
        'url': instance.url,
        'isDayTime': instance.isDayTime
      });
    }else{

    }
  }

  @override
  void initState() {
    super.initState();
    setUpWorldTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[900],
      body: Center(
        child: SpinKitFadingCube(
          color: Colors.white,
          size: 50,
        ),
      ),
    );
  }
}
