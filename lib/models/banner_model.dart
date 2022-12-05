class BannerModel {
  final String assetImage;
  final String name;

  BannerModel({required this.assetImage, required this.name});

  static List<BannerModel> banners = [
    BannerModel(assetImage: 'assets/images/bedroom.png', name: 'Bedroom'),
    BannerModel(
        assetImage: 'assets/images/family_room.png', name: 'Family Room'),
  ];
}
