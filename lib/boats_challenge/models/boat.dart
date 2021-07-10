class Boat {
  const Boat({
    required this.model,
    required this.owner,
    required this.description,
    required this.specs,
    required this.gallery,
    required this.imagePath,
  });

  final String model;
  final String owner;
  final String description;
  final Map<String, String> specs;
  final List<String> gallery;
  final String imagePath;


  static const _description = "Cum agripeta cantare, omnes humani generises transferre fatalis, gratis gloses.";
  static const _gallery = [
    "assets/boats_challenge/img/gallery1.jpg",
    "assets/boats_challenge/img/gallery2.jpg",
    "assets/boats_challenge/img/gallery3.jpg",
    "assets/boats_challenge/img/gallery4.jpg",
    "assets/boats_challenge/img/gallery5.jpg",
  ];
  static const _specs = {
    "Boat Length": "24'2",
    "Beam": "102'",
    "Weight": "2765 KG",
    "Fuel Capacity": "322 L"
  };
  static const listBoats = [
    Boat(
        model: "XCLR8 Speed",
        owner: "Tennison",
        imagePath: "assets/boats_challenge/img/boat1.png",
        description: _description,
        gallery: _gallery,
        specs: _specs),

    Boat(
        model: "X-FORCE",
        owner: "W - Wilson",
        imagePath: "assets/boats_challenge/img/boat2.png",
        description: _description,
        gallery: _gallery,
        specs: _specs),

    Boat(
        model: "X12 Force",
        owner: "Mastercraft",
        imagePath: "assets/boats_challenge/img/boat3.png",
        description: _description,
        gallery: _gallery,
        specs: _specs),

    Boat(
        model: "X21 Strength",
        owner: "NeoCraft",
        imagePath: "assets/boats_challenge/img/boat4.png",
        description: _description,
        gallery: _gallery,
        specs: _specs),
  ];
}
