import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'dart:async';


import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}



class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  final myControllerLat = TextEditingController();
  final myControllerLong = TextEditingController();

  String blynkurlbase = "https://blynk.cloud/external/api/update?";
  String blynktoken = "uubBmBxi_M4kF7bvyLgHCz1_PUEqsPJ_";

  int blynkdatastreamidbutton = 1;
  int blynkdatastreamidlatlong = 2;

  bool switchvalue = false;

  void _sendReq () async {
    int switchnum (switchvalue)
    {if(switchvalue == true) {return 0;} else {return 1;}}

    String toggle_req = blynkurlbase + "token=" + blynktoken + "&dataStreamId="
    + blynkdatastreamidbutton.toString() + "&value=" + switchnum(switchvalue).toString();
    var response_button = await http.get(Uri.parse(toggle_req));

    String latlong_req = blynkurlbase + "token=" + blynktoken + "&dataStreamId="
        + blynkdatastreamidlatlong.toString() + "&value=" +
        "lat" + myControllerLat.text + "lon" + myControllerLong.text;
    var response_latlong = await http.get(Uri.parse(latlong_req));
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 50.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[

              const SizedBox(height: 10),

              FlutterSwitch(
                // width: 125.0,
                // height: 55.0,
                // valueFontSize: 25.0,
                // toggleSize: 45.0,
                value: switchvalue,
                // borderRadius: 30.0,
                padding: 8.0,
                showOnOff: true,
                onToggle: (val) {
                  setState(() {
                    switchvalue = val;
                    _sendReq();
                  });
                },
              ),

              const SizedBox(height: 10),

              TextField(
                controller: myControllerLat,
                decoration: const InputDecoration(
                  hintText: 'Enter lat',
                ),
              ),

              const SizedBox(height: 10),

              TextField(
                controller: myControllerLong,
                decoration: const InputDecoration(
                  hintText: 'Enter long',
                ),
              ),

              const SizedBox(height: 10),

              TextButton(
                onPressed: _sendReq,
                child: const Text('Send Lat and long'),
              ),

              const SizedBox(height: 40),

              const Text(
                'You have pushed the button this many times:',
              ),
              const SizedBox(height: 10),
              Text(
                '$_counter',
                style: Theme.of(context).textTheme.headline4,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
        backgroundColor: Colors.red,
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
