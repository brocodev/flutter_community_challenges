import 'package:flutter/material.dart';
import 'package:flutter_community_challenges/boats_challenge/ui/boat_list_page.dart';

class BoatsChallengeApp extends StatelessWidget {
  const BoatsChallengeApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        textTheme: TextTheme(
          headline4: TextStyle(
            fontSize: 32,
            color: Colors.grey[800],
          ),
          bodyText2: TextStyle(
            fontSize: 16,
          ),
        ),
      ),
      home: const BoatListPage(),
    );
  }
}
