import 'dart:ui';

import 'package:flutter_community_challenges/coffee_challenge/model/coffee.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CoffeeCarousel extends StatelessWidget {
  const CoffeeCarousel({
    Key? key,
    required double percent,
    required this.coffeeList,
    required int index,
  })  : _percent = percent,
        _index = index,
        super(key: key);

  final double _percent;
  final List<Coffee> coffeeList;
  final int _index;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final height = constraints.maxHeight;
        return Stack(
          alignment: Alignment.center,
          children: [
            // Third coffee
            if (_index > 1)
              _CoffeeTransforms(
                coffee: coffeeList[_index - 2],
                scale: lerpDouble(.3, 0, _percent)!,
                opacity: lerpDouble(0.5, 0.0, _percent)!,
              ),

            // Second coffee
            if (_index > 0)
              _CoffeeTransforms(
                coffee: coffeeList[_index - 1],
                displacement: lerpDouble((height * .1), 0, _percent)!,
                scale: lerpDouble(.6, .3, _percent)!,
                opacity: lerpDouble(0.8, 0.5, _percent)!,
              ),

            // First coffee
            _CoffeeTransforms(
              coffee: coffeeList[_index],
              displacement: lerpDouble((height * .25), (height * .1), _percent)!,
              scale: lerpDouble(1.0, .6, _percent)!,
              opacity: lerpDouble(1.0, 0.8, _percent)!,
            ),

            // Hide bottom coffee
            if (_index < coffeeList.length - 1)
              _CoffeeTransforms(
                coffee: coffeeList[_index + 1],
                displacement: lerpDouble(height, (height * .25), _percent)!,
                scale: lerpDouble(2.0, 1.0, _percent)!,
              ),
          ],
        );
      },
    );
  }
}

class _CoffeeTransforms extends StatelessWidget {
  const _CoffeeTransforms(
      {Key? key,
      required this.coffee,
      this.displacement = 0.0,
      this.scale = 1.0,
      this.opacity = 1.0})
      : super(key: key);

  final double displacement;
  final double scale;
  final double opacity;
  final Coffee coffee;

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset(0, displacement),
      child: Transform.scale(
        alignment: Alignment.topCenter,
        scale: scale,
        child: Opacity(
          opacity: opacity,
          child: _CoffeeImage(
            coffee: coffee,
          ),
        ),
      ),
    );
  }
}
class _CoffeeImage extends StatelessWidget {
  const _CoffeeImage({
    Key? key,
    required this.coffee,
  }) : super(key: key);
  final Coffee coffee;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: AspectRatio(
        aspectRatio: 0.85,
        child: Hero(
          tag: coffee.name,
          child: Image.asset(
            coffee.pathImage,
          ),
        ),
      ),
    );
  }
}
