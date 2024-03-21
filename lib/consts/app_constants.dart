import 'package:shopapp/models/categories_model.dart';
import 'package:shopapp/services/asset_manager.dart';

class AppConstants {
  static const String imageUrl =
      'http://i.ibb.co/8r1Ny2n/20-Nike-Air-Force-1-07.png';

  static List<String> bannerImages = [
    AssetsManager.banner1,
    AssetsManager.banner2,
    AssetsManager.banner3,
    AssetsManager.banner4,
  ];
  static List<CategoriesModel> categoriesList = [
    CategoriesModel(
      id: AssetsManager.mobiles,
      name: "Phones",
      image: AssetsManager.mobiles,
    ),
    CategoriesModel(
      id: AssetsManager.mobiles,
      name: "Laptops",
      image: AssetsManager.pc,
    ),
    // CategoriesModel(
    //   id: AssetsManager.mobiles,
    //   name: "Electronics",
    //   image: AssetsManager.electronics,
    // ),
    CategoriesModel(
      id: AssetsManager.mobiles,
      name: "Watches",
      image: AssetsManager.watch,
    ),
    CategoriesModel(
      id: AssetsManager.mobiles,
      name: "Clothes",
      image: AssetsManager.clothes,
    ),
    CategoriesModel(
      id: AssetsManager.mobiles,
      name: "Shoes",
      image: AssetsManager.shoes,
    ),
    // CategoriesModel(
    //   id: AssetsManager.mobiles,
    //   name: "Books",
    //   image: AssetsManager.bookImg,
    // ),
    CategoriesModel(
      id: AssetsManager.mobiles,
      name: "Cosmetics",
      image: AssetsManager.cosmetics,
    ),
  ];
}
