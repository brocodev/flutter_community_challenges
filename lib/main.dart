import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_community_challenges/boats_challenge/main.dart';
import 'package:flutter_community_challenges/coffee_challenge/coffee_app.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.light,
  ));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hispanic Community Challenges',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ChallengePage(),
    );
  }
}

class ChallengePage extends StatelessWidget {
  const ChallengePage({Key? key}) : super(key: key);

  void _openApp(BuildContext context, Widget app) {
    final route = MaterialPageRoute(builder: (context) => app);
    Navigator.push(context, route);
  }

  @override
  Widget build(BuildContext context) {
    final apps = const [
      CoffeeChallengeApp(),
      BoatsChallengeApp(),
    ];
    final appsTitle = const [
      'Coffee Challenge',
      'Boats Challenge',
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Community Challenges'),
      ),
      body: Center(
        child: ListView.builder(
          itemCount: apps.length,
          padding: const EdgeInsets.all(20.0),
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextButton(
                onPressed: () => _openApp(context, apps[index]),
                style: TextButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                ),
                child: Text(
                  appsTitle[index],
                  style: TextStyle(color: Colors.white),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
