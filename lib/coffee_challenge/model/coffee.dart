class Coffee {
  final String name;
  final String pathImage;
  final double price;

  const Coffee(this.name, this.pathImage, this.price);

  static const coffeeList = [
    Coffee('Vietnamese Style Iced Coffee', 'assets/coffee_challenge/img/9.png', 4.2),
    Coffee('Classic Irish Coffee', 'assets/coffee_challenge/img/11.png', 4.3),
    Coffee('Americano', 'assets/coffee_challenge/img/8.png', 3.3),
    Coffee('Caramel Macchiato', 'assets/coffee_challenge/img/1.png', 3.2),
    Coffee('Toffee Nut Iced Latte', 'assets/coffee_challenge/img/7.png', 4.0),
    Coffee('Caramelized Pecan Latte', 'assets/coffee_challenge/img/4.png', 3.5),
    Coffee('Toffee Nut Latte', 'assets/coffee_challenge/img/5.png', 3.9),
    Coffee('Iced Coffe Mocha', 'assets/coffee_challenge/img/3.png', 3.2),
    Coffee('Capuchino', 'assets/coffee_challenge/img/6.png', 3.1),
    Coffee('Caramel Cold Drink', 'assets/coffee_challenge/img/2.png', 3.2),
    Coffee('Black Tea Latte', 'assets/coffee_challenge/img/10.png', 4.3),
    Coffee('Toffee Nut Crunch Latte', 'assets/coffee_challenge/img/12.png', 3.7),
  ];
}
