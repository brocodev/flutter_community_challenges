import 'package:flutter/material.dart';
import 'package:flutter_community_challenges/bank_challenge/model/bank_models.dart';
import 'package:flutter_community_challenges/bank_challenge/utils/colors.dart';

class HeaderHomePage extends StatelessWidget {
  const HeaderHomePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = BankClient.currentUser;
    return Column(
      children: [
        Expanded(
          child: Container(
            margin: const EdgeInsets.fromLTRB(30, 30, 30, 0),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.blueGrey[50],
              borderRadius: BorderRadius.circular(30),
            ),
            child: Row(
              children: [
                Text.rich(
                  TextSpan(
                    text: 'Hello',
                    children: [
                      TextSpan(
                          text: ' ${user.name.split(' ').first}',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                  style: TextStyle(fontSize: 30, color: BankColors.kTextColor),
                ),
                const Spacer(),
                Align(
                  widthFactor: .2,
                  child: CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage(user.pathImage),
                  ),
                ),
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  child: Icon(
                    Icons.credit_card,
                    color: BankColors.kLessDarkBlue,
                  ),
                )
              ],
            ),
          ),
        ),
        //-------------------
        // Separator
        //-------------------
        Container(
          height: 8,
          width: 60,
          margin: const EdgeInsets.symmetric(vertical: 15),
          decoration: BoxDecoration(
            color: Colors.blueGrey[50],
            borderRadius: BorderRadius.circular(30),
          ),
        )
      ],
    );
  }
}
