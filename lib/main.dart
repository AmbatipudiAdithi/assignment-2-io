import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Weather App"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FutureBuilder(
                  future: apicall(),
                  builder: (context,snapshot) {
                    if(snapshot.hasData){
                      return Column(
                        children: [
                          Text("Hello! Today's temperature: "),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10,20,30,40),
                            child:
                            Text(snapshot.data['temp'].toString()),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(snapshot.data['description'].toString()),
                          ),
                          Text(snapshot.data['icon'].toString())
                        ],
                      );
                    }
                    else{
                      return CircularProgressIndicator();
                    }

                  })

            ],
          ),
        )
    );
  }
}
Future apicall() async {
  final url = Uri.parse("https://api.openweathermap.org/data/2.5/weather?q=bangalore&appid=178350a47f5cb0cbe136cd9419bc0675&units=metric");
  final response = await http.get(url);
  print(response.body);
  final json = jsonDecode(response.body);
  print(json['weather'][0]['description']);
  final output = {
    'description': json['weather'][0]['description'],
    'temp' : json['main']['temp'],
    'icon' : json['weather'][0]['icon']
  };
  return output;


}