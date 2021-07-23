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

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late PageController _pageController;
  late int _indexPage;
  late int _currentIndex;
  late bool _enableAddCreditCard;
  double _blueBgTranslatePercent = 1.0;
  double _blueBgTransitionPercent = 1.0;
  bool _hideByVelocity = false;

  // Data
  late final BankClient currentUser;
  late final List<BankAccount> userAccounts;
  late AccountTransaction selectedLastTransaction;

  @override
  void initState() {
    _pageController = PageController(viewportFraction: .85, initialPage: 1)
      ..addListener(_pageListener);
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 600));
    _indexPage = 1;
    _currentIndex = 1;
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
    }
    setState(() {});
  }

  void _onPageChange(int value) {
    _currentIndex = value;
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

  void _onVerticalDragUpdate(DragUpdateDetails details) {
    if (_currentIndex > 0) {
      if (details.primaryDelta! > 0.0) {
        _controller.value += 0.004;
      } else {
        _controller.value -= 0.004;
      }

      if (details.primaryDelta! > -1.5) {
        _hideByVelocity = false;
      } else {
        _hideByVelocity = true;
        _controller.reverse();
      }
    }
    setState(() {});
  }

  void _onVerticalDragEnd(DragEndDetails details) {
    if (_currentIndex >= 0) {
      if (_controller.value < 0.2 || _hideByVelocity) {
        _controller.reverse();
      } else {
        _controller.forward();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: AnimatedBuilder(
            animation: _controller,
            builder: (_, __) {
              final value = _controller.value;
              return GestureDetector(
                onVerticalDragUpdate: _onVerticalDragUpdate,
                onVerticalDragEnd: _onVerticalDragEnd,
                child: Container(
                  color: Colors.transparent,
                  child: Column(
                    children: [
                      //-------------------------------------
                      // Header Home Page Widget
                      //-------------------------------------
                      Expanded(
                        flex: 4,
                        child: HeaderHomePage(
                          expandedFactor: 1 - value,
                        ),
                      ),
                      Expanded(
                        flex: 10,
                        child: LayoutBuilder(builder: (context, constraints) {
                          final widthBlueCard = constraints.maxWidth - 60;
                          final heightBlueCard = constraints.maxHeight - 40;
                          return Transform.translate(
                            offset:
                                Offset(0, (constraints.maxHeight * 2) * value),
                            child: Stack(
                              children: [
                                //-------------------------------------
                                // Add Credit Card Background
                                //-------------------------------------
                                Transform.translate(
                                  offset: Offset(
                                      -widthBlueCard *
                                          (_blueBgTranslatePercent - 1),
                                      0),
                                  child: AddCreditCardContainer(
                                    percent: _blueBgTransitionPercent,
                                    height: heightBlueCard,
                                    width: widthBlueCard,
                                    showItems: _enableAddCreditCard,
                                  ),
                                ),
                                //-------------------------------------
                                // Account Cards Page View
                                //-------------------------------------
                                Transform(
                                  transform: Matrix4.identity()
                                    ..translate(
                                        100.0 * (1 - _blueBgTransitionPercent)),
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
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10),
                                          child: AccountCard(account: account),
                                        );
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                      ),
                      //-------------------------------------
                      // Animated Transaction Widget
                      //-------------------------------------
                      Expanded(
                        flex: 2,
                        child: LayoutBuilder(builder: (context, constraints) {
                          return Transform.translate(
                            offset:
                                Offset(0, (constraints.maxHeight * 4) * value),
                            child: Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(30, 30, 30, 10),
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
                          );
                        }),
                      ),
                    ],
                  ),
                ),
              );
            }),
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
