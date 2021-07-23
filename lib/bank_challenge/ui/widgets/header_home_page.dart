import 'package:flutter/material.dart';
import 'package:flutter_community_challenges/bank_challenge/model/bank_models.dart';
import 'package:flutter_community_challenges/bank_challenge/utils/colors.dart';

class HeaderHomePage extends StatelessWidget {
  const HeaderHomePage({
    Key? key,
    required this.expandedFactor,
  }) : super(key: key);

  final double expandedFactor;

  @override
  Widget build(BuildContext context) {
    final user = BankClient.currentUser;
    final size = MediaQuery.of(context).size;

    return OverflowBox(
      maxHeight: size.height,
      maxWidth: size.width,
      alignment: Alignment.topCenter,
      child: Stack(
        children: [
          Positioned(
            top: 0,
            left: 30 * expandedFactor,
            right: 30 * expandedFactor,
            bottom: (size.height * .8) * expandedFactor,
            child: Container(
              padding: const EdgeInsets.all(20),
              alignment: Alignment.topCenter,
              decoration: BoxDecoration(
                color: Colors.blueGrey[50],
                borderRadius: BorderRadius.circular(30 * expandedFactor),
              ),
            ),
          ),
          // Hide Animated items
          Positioned(
            left: 30,
            right: 30,
            top: 30,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(20 * expandedFactor),
                  child: _GreetingWidget(user: user),
                ),
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 400),
                  child: (expandedFactor < .2)
                      ? Column(
                          children: const [
                            SizedBox(height: 40),
                            SizedBox(height: 120, child: _BankUserList()),
                            SizedBox(height: 20),
                            _HolidayGoalWidget(),
                            SizedBox(height: 20),
                            _PlayServicesCard()
                          ],
                        )
                      : const SizedBox(),
                ),
              ],
            ),
          ),
          //-------------------
          // Separator
          //-------------------
          // Container(
          //   height: 8,
          //   width: 60,
          //   margin: const EdgeInsets.symmetric(vertical: 15),
          //   decoration: BoxDecoration(
          //     color: Colors.blueGrey[50],
          //     borderRadius: BorderRadius.circular(30),
          //   ),
          // )
        ],
      ),
    );
  }
}

class _PlayServicesCard extends StatelessWidget {
  const _PlayServicesCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0),
      ),
    );
  }
}

class _HolidayGoalWidget extends StatelessWidget {
  const _HolidayGoalWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      decoration: BoxDecoration(
        color: Colors.blue[100],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15.0)),
            ),
          ),
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                Chip(
                  label: Text('Holiday goal'),
                  labelStyle: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  backgroundColor: Colors.blue[200],
                ),
                Text.rich(
                    TextSpan(text: '\$ 100.00', children: [
                      TextSpan(
                        text: '  \$ 5000.00',
                        style: TextStyle(
                          color: Colors.blueGrey[400],
                        ),
                      )
                    ]),
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.blueGrey[900],
                      fontWeight: FontWeight.bold,
                    )),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _BankUserList extends StatelessWidget {
  const _BankUserList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      itemCount: BankClient.users.length,
      itemExtent: 90,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        final bankUser = BankClient.users[index];
        return Column(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundImage: AssetImage(bankUser.pathImage),
            ),
            Text('${bankUser.name.split(' ').first}'),
          ],
        );
      },
    );
  }
}

class _GreetingWidget extends StatelessWidget {
  const _GreetingWidget({
    Key? key,
    required this.user,
  }) : super(key: key);

  final BankClient user;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
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
    );
  }
}
