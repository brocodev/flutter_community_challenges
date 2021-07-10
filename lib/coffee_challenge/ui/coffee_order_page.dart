import 'package:flutter_community_challenges/coffee_challenge/model/coffee.dart';
import 'package:flutter_community_challenges/coffee_challenge/ui/widgets/coffee_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

enum CoffeeSize { Small, Medium, Big }

class CoffeeOrderPage extends StatefulWidget {
  const CoffeeOrderPage({Key? key, required this.coffee}) : super(key: key);
  final Coffee coffee;

  @override
  _CoffeeOrderPageState createState() => _CoffeeOrderPageState();
}

class _CoffeeOrderPageState extends State<CoffeeOrderPage> {
  late CoffeeSize _selectedCoffeeSize;
  late PageController _pageController;

  @override
  void initState() {
    _selectedCoffeeSize = CoffeeSize.Medium;
    _pageController = PageController(initialPage: 1);
    super.initState();
  }

  void _changeCoffeeSize(CoffeeSize coffeeSize) {
    _pageController.animateToPage(
      coffeeSize.index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.fastOutSlowIn,
    );
    setState(() {
      _selectedCoffeeSize = coffeeSize;
    });
  }

  double _getSizePricePercent(CoffeeSize coffeeSize) {
    switch (coffeeSize) {
      case CoffeeSize.Small:
        return 0.8;
      case CoffeeSize.Medium:
        return 1.0;
      case CoffeeSize.Big:
        return 1.2;
      default:
        return 1.0;
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        children: [
          const CoffeeAppBar(),
          //------------------------
          // Coffee name
          //------------------------
          SizedBox(
            width: size.width * .65,
            child: Hero(
              tag: widget.coffee.name + "title",
              child: Text(
                widget.coffee.name,
                style: Theme.of(context).textTheme.headline5,
                maxLines: 2,
                textAlign: TextAlign.center,
              ),
            ),
          ),
          //------------------------
          // Coffee Image
          //------------------------
          Expanded(
            flex: 4,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Positioned.fill(
                  child: Hero(
                    tag: widget.coffee.name,
                    child: PageView(
                      controller: _pageController,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 80),
                          child: Image.asset(widget.coffee.pathImage),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 40),
                          child: Image.asset(widget.coffee.pathImage),
                        ),
                        Image.asset(widget.coffee.pathImage),
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment(-.7, .8),
                  //-----------------------------
                  // Text price animated
                  //-----------------------------
                  child: TweenAnimationBuilder<double>(
                    duration: const Duration(milliseconds: 600),
                    tween: Tween(begin: 1.0, end: 0.0),
                    curve: Curves.fastOutSlowIn,
                    builder: (context, value, child) {
                      return Transform.translate(
                        offset: Offset(-(size.width * .5) * value,
                            (size.height * .4) * value),
                        child: child,
                      );
                    },
                    //------------------------------
                    // Change Price Animation
                    //------------------------------
                    child: TweenAnimationBuilder<double>(
                        duration: const Duration(milliseconds: 600),
                        tween: Tween(
                          begin: 0.0,
                          end: _getSizePricePercent(_selectedCoffeeSize),
                        ),
                        curve: Curves.fastOutSlowIn,
                        builder: (context, value, _) {
                          return Transform.scale(
                            scale: value,
                            child: Text(
                              "${(widget.coffee.price * value).toStringAsFixed(1)}\$",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline2!
                                  .copyWith(
                                color: Colors.white,
                                shadows: [
                                  Shadow(
                                    color: Colors.black54,
                                    blurRadius: 30,
                                  )
                                ],
                              ),
                            ),
                          );
                        }),
                  ),
                ),
                Align(
                  alignment: Alignment(.7, -.7),
                  //-----------------------------
                  // Add Button Animated
                  //-----------------------------
                  child: TweenAnimationBuilder<double>(
                    duration: const Duration(milliseconds: 600),
                    tween: Tween(begin: 1.0, end: 0.0),
                    curve: Curves.fastOutSlowIn,
                    builder: (context, value, child) {
                      return Transform.translate(
                        offset: Offset((size.width * .3) * value, 0),
                        child: Transform.rotate(
                          angle: 4.28 * value,
                          child: child,
                        ),
                      );
                    },
                    child: FloatingActionButton(
                      onPressed: () {},
                      mini: true,
                      elevation: 10,
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.brown[700],
                      child: Icon(Icons.add),
                    ),
                  ),
                )
              ],
            ),
          ),
          //------------------------
          // Coffee Sizes
          //------------------------
          Expanded(
            child: TweenAnimationBuilder<double>(
              duration: const Duration(milliseconds: 600),
              tween: Tween(begin: 1.0, end: 0.0),
              curve: Curves.fastOutSlowIn,
              builder: (context, value, child) {
                return Transform.translate(
                  offset: Offset(0, (size.height * .2) * value),
                  child: child,
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(CoffeeSize.values.length, (index) {
                  final coffeeSize = CoffeeSize.values[index];
                  //----------------------------
                  // Coffee Size Option
                  //----------------------------
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: _CoffeeSizeOption(
                        isSelected: (coffeeSize == _selectedCoffeeSize),
                        coffeeSize: coffeeSize,
                        onTap: () => _changeCoffeeSize(coffeeSize)),
                  );
                }),
              ),
            ),
          ),
          //------------------------
          // Coffee temperatures
          //------------------------
          Expanded(
            child: TweenAnimationBuilder<double>(
              duration: const Duration(milliseconds: 600),
              tween: Tween(begin: 1.0, end: 0.0),
              curve: Curves.fastOutSlowIn,
              builder: (context, value, child) {
                return Transform.translate(
                  offset: Offset(0, (size.height * .2) * value),
                  child: child,
                );
              },
              child: const _CoffeeTemperatures(),
            ),
          ),
        ],
      ),
    );
  }
}

class _CoffeeTemperatures extends StatelessWidget {
  const _CoffeeTemperatures({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(color: Colors.white, boxShadow: [
              BoxShadow(
                  color: Colors.black12, blurRadius: 10, offset: Offset(3, 10))
            ]),
            child: Text(
              'Hot | Warm',
              style: Theme.of(context)
                  .textTheme
                  .subtitle1!
                  .copyWith(color: Colors.brown[700]),
            ),
          ),
        ),
        Expanded(
          child: Container(
            alignment: Alignment.center,
            child: Text(
              'Cold | Ice',
              style: Theme.of(context)
                  .textTheme
                  .subtitle1!
                  .copyWith(color: Colors.grey[400]),
            ),
          ),
        ),
      ],
    );
  }
}

class _CoffeeSizeOption extends StatelessWidget {
  const _CoffeeSizeOption({
    Key? key,
    required this.isSelected,
    required this.coffeeSize,
    required this.onTap,
  }) : super(key: key);

  final bool isSelected;
  final CoffeeSize coffeeSize;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final labelSize = coffeeSize.toString().split('.')[1][0].toLowerCase();
    return InkWell(
      onTap: onTap,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: ShaderMask(
        shaderCallback: (bounds) => LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: isSelected
              ? [Colors.brown, Colors.orange]
              : [Colors.grey[300]!, Colors.grey[300]!],
        ).createShader(bounds),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              "assets/coffee_challenge/svg/$labelSize-coffee-cup.svg",
              width: 45.0,
              color: Colors.white,
            ),
            Text(
              labelSize.toUpperCase(),
              style: Theme.of(context).textTheme.headline6!.copyWith(
                    color: Colors.white,
                  ),
            )
          ],
        ),
      ),
    );
  }
}
