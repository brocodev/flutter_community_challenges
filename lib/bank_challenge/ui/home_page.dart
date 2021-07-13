import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_community_challenges/bank_challenge/model/bank_models.dart';
import 'package:flutter_community_challenges/bank_challenge/ui/widgets/add_credit_card_container.dart';
import 'package:flutter_community_challenges/bank_challenge/ui/widgets/account_card.dart';
import 'package:flutter_community_challenges/bank_challenge/ui/widgets/header_home_page.dart';
import 'package:flutter_community_challenges/bank_challenge/utils/colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late PageController _pageController;
  late int _indexPage;
  late double _blueBgTranslatePercent;
  late double _blueBgTransitionPercent;
  late bool _enableAddCreditCard;

  // Data
  late final BankClient currentUser;
  late final List<BankAccount> userAccounts;
  late AccountTransaction selectedLastTransaction;

  @override
  void initState() {
    _pageController = PageController(viewportFraction: .85, initialPage: 1)
      ..addListener(_pageListener);
    _indexPage = 1;
    _blueBgTranslatePercent = 1.0;
    _blueBgTransitionPercent = 1.0;
    _enableAddCreditCard = false;
    // Data
    currentUser = BankClient.currentUser;
    userAccounts = currentUser.accounts;
    selectedLastTransaction = userAccounts.first.lastTransaction;
    super.initState();
  }

  void _pageListener() {
    if (_pageController.page! > 1) {
      _blueBgTranslatePercent = _pageController.page!;
    } else {
      _blueBgTransitionPercent = _pageController.page!;
      _enableAddCreditCard = (_blueBgTransitionPercent < .1);
      // print(_blueBgTransitionPercent);
    }
    setState(() {});
  }

  void _onPageChange(int value) {
    setState(() {
      _indexPage = (value == 0) ? 0 : value - 1;
      selectedLastTransaction = userAccounts[_indexPage].lastTransaction;
    });
  }

  // Custom transition builder for the bottom AnimatedSwitch
  Widget _transitionBuilder(child, animation) {
    return FadeTransition(
      opacity: animation,
      child: SlideTransition(
        position: Tween(
          begin: Offset(0, 1),
          end: Offset(0, 0),
        ).animate(animation),
        child: child,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            //-------------------------------------
            // Header Home Page Widget
            //-------------------------------------
            Expanded(
              flex: 4,
              child: const HeaderHomePage(),
            ),
            Expanded(
              flex: 10,
              child: Stack(
                children: [
                  //-------------------------------------
                  // Add Credit Card Background
                  //-------------------------------------
                  LayoutBuilder(builder: (context, constraints) {
                    final widthBlueCard = constraints.maxWidth - 60;
                    final heightBlueCard = constraints.maxHeight - 40;
                    return Transform.translate(
                      offset: Offset(
                          -widthBlueCard * (_blueBgTranslatePercent - 1), 0),
                      child: AddCreditCardContainer(
                        percent: _blueBgTransitionPercent,
                        height: heightBlueCard,
                        width: widthBlueCard,
                        showItems: _enableAddCreditCard,
                      ),
                    );
                  }),
                  //-------------------------------------
                  // Account Cards Page View
                  //-------------------------------------
                  Transform(
                    transform: Matrix4.identity()
                      ..translate(100.0 * (1 - _blueBgTransitionPercent))
                      ..rotateZ(.05 * (1 - _blueBgTransitionPercent)),
                    child: PageView.builder(
                      onPageChanged: _onPageChange,
                      itemCount: userAccounts.length + 1,
                      physics: const BouncingScrollPhysics(),
                      controller: _pageController,
                      itemBuilder: (context, index) {
                        if (index == 0) {
                          return const SizedBox();
                        } else {
                          final account = userAccounts[index - 1];
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: AccountCard(account: account),
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
            //-------------------------------------
            // Animated Transaction Widget
            //-------------------------------------
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(30, 30, 30, 10),
                child: Opacity(
                  opacity: _blueBgTransitionPercent,
                  child: AnimatedSwitcher(
                    duration: kThemeChangeDuration,
                    transitionBuilder: _transitionBuilder,
                    child: _TransactionRow(
                      key: Key(_indexPage.toString()),
                      transaction: selectedLastTransaction,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TransactionRow extends StatelessWidget {
  const _TransactionRow({
    Key? key,
    required this.transaction,
  }) : super(key: key);

  final AccountTransaction transaction;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AspectRatio(
          aspectRatio: 1,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.asset(
              transaction.srcImage,
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(width: 20),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                transaction.header,
                style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                transaction.concept,
                style: TextStyle(
                  color: BankColors.kTextColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
        Text(
          '\$${transaction.money}',
          style: TextStyle(
            color: BankColors.kTextColor,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        )
      ],
    );
  }
}
