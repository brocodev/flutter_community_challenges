import 'package:flutter/material.dart';
import 'package:flutter_community_challenges/bank_challenge/ui/home_page.dart';
import 'package:google_fonts/google_fonts.dart';

class BankChallengeApp extends StatelessWidget {
  const BankChallengeApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
       scaffoldBackgroundColor: Colors.grey[50],
        textTheme: GoogleFonts.montserratTextTheme()
      ),
      home: const HomePage(),
    );
  }
}
