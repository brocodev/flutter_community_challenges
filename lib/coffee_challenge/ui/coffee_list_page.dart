import 'package:flutter_community_challenges/coffee_challenge/model/coffee.dart';
import 'package:flutter_community_challenges/coffee_challenge/ui/coffee_order_page.dart';
import 'package:flutter_community_challenges/coffee_challenge/ui/widgets/coffee_app_bar.dart';
import 'package:flutter_community_challenges/coffee_challenge/ui/widgets/coffee_carousel.dart';
import 'package:flutter/material.dart';

enum SliderAction {
  Next,
  Previous,
  None,
}

class CoffeeListPage extends StatefulWidget {
  const CoffeeListPage({
    Key? key,
    required this.initialAction,
  }) : super(key: key);

  final SliderAction initialAction;

  @override
  _CoffeeListPageState createState() => _CoffeeListPageState();
}

class _CoffeeListPageState extends State<CoffeeListPage> {
  late PageController _sliderPageController;
  late PageController _titlePageController;
  late int _index;
  late double _percent;

  @override
  void initState() {
    _index = 2;
    _sliderPageController = PageController(initialPage: _index);
    _titlePageController = PageController(initialPage: _index);
    _percent = 0.0;
    _sliderPageController.addListener(_pageListener);

    Future.delayed(const Duration(milliseconds: 400), () {
      _initialAction(widget.initialAction);
    });

    super.initState();
  }

  @override
  void dispose() {
    _sliderPageController.removeListener(_pageListener);
    _sliderPageController.dispose();
    _titlePageController.dispose();
    super.dispose();
  }

  void _pageListener() {
    _index = _sliderPageController.page!.floor();
    _percent = (_sliderPageController.page! - _index).abs();
    setState(() {});
  }

  void _openOrderPage(BuildContext context, Coffee coffee) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) {
          return FadeTransition(
            opacity: animation,
            child: CoffeeOrderPage(
              coffee: coffee,
            ),
          );
        },
      ),
    );
  }

  void _initialAction(SliderAction sliderAction) {
    switch (sliderAction) {
      case SliderAction.None:
        break;
      case SliderAction.Next:
        _sliderPageController.nextPage(
            duration: const Duration(milliseconds: 800),
            curve: Curves.fastOutSlowIn);
        break;
      case SliderAction.Previous:
        _sliderPageController.previousPage(
            duration: const Duration(milliseconds: 800),
            curve: Curves.fastOutSlowIn);
        break;
    }
  }

  void _onBackPage(BuildContext context) async {
    await _sliderPageController.animateToPage(2,
        duration: const Duration(milliseconds: 800),
        curve: Curves.fastOutSlowIn);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final coffeeList = Coffee.coffeeList;
    return Scaffold(
      body: Column(
        children: [
          CoffeeAppBar(
            onTapBack: () => _onBackPage(context),
          ),
          //------------------------
          // Coffee names
          //------------------------
          SizedBox(
            height: MediaQuery.of(context).size.height * .17,
            child: PageView.builder(
              itemCount: coffeeList.length,
              physics: const NeverScrollableScrollPhysics(),
              controller: _titlePageController,
              itemBuilder: (context, index) {
                return _TitleCoffee(coffee: coffeeList[index]);
              },
            ),
          ),
          Expanded(
            child: Stack(
              children: [
                //------------------------------
                // Gradient background
                //------------------------------
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: [0.75, 1.0],
                      colors: [
                        Colors.white,
                        Color(0xFFbf7840),
                      ],
                    )),
                  ),
                ),
                //--------------------------------
                // Animated Coffee Images
                //--------------------------------
                CoffeeCarousel(
                  percent: _percent,
                  coffeeList: coffeeList,
                  index: _index,
                ),
                //--------------------------------
                // Void page view
                //--------------------------------
                PageView.builder(
                  controller: _sliderPageController,
                  onPageChanged: (value) {
                    _titlePageController.animateToPage(value,
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.fastOutSlowIn);
                  },
                  itemCount: coffeeList.length,
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () => _openOrderPage(context, coffeeList[_index]),
                    );
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _TitleCoffee extends StatelessWidget {
  const _TitleCoffee({
    Key? key,
    required this.coffee,
  }) : super(key: key);

  final Coffee coffee;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * .65,
          child: Hero(
            tag: coffee.name + "title",
            child: Text(
              coffee.name,
              style: Theme.of(context).textTheme.headline5,
              maxLines: 2,
              textAlign: TextAlign.center,
            ),
          ),
        ),
        Text(
          "${coffee.price} €",
          style: Theme.of(context).textTheme.headline6!.copyWith(
                color: Colors.brown[400],
              ),
        ),
      ],
    );
  }
}
