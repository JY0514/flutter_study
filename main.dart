import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';

import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';

/// naming convention => 명명 규칙    e.g) snake_case, PascalCase, camelCase
Future<bool> postAccountRequestHttp(
    {
      String animal="cat",
      String human2 ="human2"
    }) async {

  /// url
  Uri url = Uri.parse("http://192.168.0.79:5000/post");

  /// url
  Map body = {
    'animal': animal,
    'human' : human2,
  };

  ///Http post
  http.Response response = await http.post(
      url,
      headers: {'Context-Type': 'application/json; charset=utf-8'},
      body: body).timeout(
      const Duration(seconds: 10), onTimeout: () {
    throw TimeoutException('The connection has timed out, Please try again!');
  }
  );

  Map<String, dynamic> jsonResponse = jsonDecode(response.body);
  // print(response);
  print(jsonResponse);

  /// if under a line occur any kind of error, then check login http server
  if (jsonResponse.containsKey('success')) {
    print("http post 성공!");
    return true;
  }

  print("http post 실패");
  return false;
}



Future<bool> getAccountRequestHttp(
    ) async {
  String host = "192.168.0.79";
  String port = "5000";
  /// url
  Uri url = Uri.parse("http://$host:$port/get?animal=tester&human=tester");

  ///Http get
  http.Response response = await http.get(
      url,
  );
  print("http get animal + human 성공!");

  Map<String, dynamic> jsonResponse = jsonDecode(response.body);
  var temp = response.body;
  print(response);
  print(response.body);
  print(jsonResponse);

  return true;
}


Future<bool> getAccountRequestDio() async {
  /// url
  String host = "192.168.0.79";
  String port = "5000";

  var dio = Dio();
  Response response = await dio.get("http://$host:$port/get?animal=tester&human=tester");
  // Response response2 = await dio.get("http://$host:$port/get?human=tester");
  // print(response);
  print(response.data);
  // print(response.data);
  // print(response.data2);

  print("Dio get 성공!");
  return true;
}

Future<bool> postAccountRequestDio() async{
  /// url
  String host = "192.168.0.79";
  String port = "5000";

  var dio = Dio();

  Map<String, dynamic> body = {"animal": "dog", "human":"human1"};
  var formData = FormData.fromMap(body);

  Response response = await dio.post("http://$host:$port/post", data: formData);
  // print(response);
  print(response.data);

  print("Dio post 성공!");
  return true;
}


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;




  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() async {
  // void _incrementCounter() {
    /// async test(동기 비동기)

    // await postAccountRequestHttp();
    // await getAccountRequestHttp();   //프린트는 되는데 타입에러.......

    // await postAccountRequestDio();
    await getAccountRequestDio();


    setState(() {
      _counter++;
    });
    print("increase!");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
