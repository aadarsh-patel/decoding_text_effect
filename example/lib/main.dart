// Copyright (c) 2020, Aadarsh Patel
// All rights reserved.
// This source code is licensed under the BSD-style license found in the LICENSE file in the root directory of this source tree. 

import 'package:flutter/material.dart';
import 'package:decoding_text_effect/decoding_text_effect.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int index = 0;

  List<String> myText = [
    'Decoding Text\nEffect',
    'Welcome to\nthe Dart Side!',
    'I have 50\nwatermelons',
    'Quick Maths,\n2 + 2 = 4'
  ];

  void changeText() {
    setState(() {
      index++;
      if (index == myText.length) index = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Decoding Text Effect Example'),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 50),
              Text(
                'decodeEffect: DecodeEffect.fromStart',
                style: TextStyle(fontSize: 21),
              ),
              SizedBox(height: 8),
              Container(
                height: 200,
                width: 350,
                color: Colors.pink[100],
                padding: EdgeInsets.all(50),
                child: DecodingTextEffect(
                  myText[index],
                  decodeEffect: DecodeEffect.fromStart,
                  textStyle: TextStyle(fontSize: 30),
                ),
              ),
              SizedBox(height: 100),
              Text(
                'decodeEffect: DecodeEffect.fromEnd',
                style: TextStyle(fontSize: 21),
              ),
              SizedBox(height: 8),
              Container(
                height: 200,
                width: 350,
                color: Colors.yellow[100],
                padding: EdgeInsets.all(50),
                child: DecodingTextEffect(
                  myText[index],
                  decodeEffect: DecodeEffect.fromEnd,
                  textStyle: TextStyle(fontSize: 30),
                ),
              ),
              SizedBox(height: 100),
              Text(
                'decodeEffect: DecodeEffect.toMiddle',
                style: TextStyle(fontSize: 21),
              ),
              SizedBox(height: 8),
              Container(
                height: 200,
                width: 350,
                color: Colors.green[100],
                padding: EdgeInsets.all(50),
                child: DecodingTextEffect(
                  myText[index],
                  decodeEffect: DecodeEffect.toMiddle,
                  textStyle: TextStyle(fontSize: 30),
                ),
              ),
              SizedBox(height: 100),
              Text(
                'decodeEffect: DecodeEffect.random',
                style: TextStyle(fontSize: 21),
              ),
              SizedBox(height: 8),
              Container(
                height: 200,
                width: 350,
                color: Colors.purple[100],
                padding: EdgeInsets.all(50),
                child: DecodingTextEffect(
                  myText[index],
                  decodeEffect: DecodeEffect.random,
                  textStyle: TextStyle(fontSize: 30),
                ),
              ),
              SizedBox(height: 100),
              Text(
                'decodeEffect: DecodeEffect.all',
                style: TextStyle(fontSize: 21),
              ),
              SizedBox(height: 8),
              Container(
                height: 200,
                width: 350,
                color: Colors.blue[100],
                padding: EdgeInsets.all(50),
                child: DecodingTextEffect(
                  myText[index],
                  decodeEffect: DecodeEffect.all,
                  textStyle: TextStyle(fontSize: 30),
                ),
              ),
              SizedBox(height: 100),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.refresh),
        onPressed: changeText,
      ),
    );
  }
}
