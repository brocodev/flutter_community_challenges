import 'package:flutter/material.dart';

class CoffeeAppBar extends StatelessWidget {
  const CoffeeAppBar({
    Key? key,
    this.brightness = Brightness.dark,
    this.onTapBack,
  }) : super(key: key);
  final Brightness brightness;
  final VoidCallback? onTapBack;

  @override
  Widget build(BuildContext context) {
    final _isDarkBrightness = (brightness == Brightness.dark);
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              color: _isDarkBrightness ? Colors.black : Colors.white,
              icon: Icon(Icons.arrow_back_ios),
              onPressed: onTapBack ??
                  () {
                    if (Navigator.canPop(context)) Navigator.pop(context);
                  },
            ),
            Stack(
              children: [
                IconButton(
                  iconSize: 32,
                  color: _isDarkBrightness ? Colors.black : Colors.white,
                  icon: Icon(Icons.shopping_bag_outlined),
                  onPressed: () {},
                ),
                Positioned(
                  bottom: 8,
                  right: 8,
                  child: Container(
                    height: 14,
                    width: 14,
                    decoration: BoxDecoration(
                      color: _isDarkBrightness ? Colors.orange : Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: FittedBox(
                      child: Text(
                        '1',
                        style: Theme.of(context).textTheme.caption!.copyWith(
                              color: _isDarkBrightness
                                  ? Colors.white
                                  : Colors.brown[700],
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
