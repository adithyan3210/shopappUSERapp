import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/consts/app_constants.dart';
import 'package:shopapp/providers/products_provider.dart';
import 'package:shopapp/services/asset_manager.dart';
import 'package:shopapp/widgets/appname_text.dart';
import 'package:shopapp/widgets/products/ctgry_rounded_widget.dart';
import 'package:shopapp/widgets/products/latest_arrival.dart';
import 'package:shopapp/widgets/title_text.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final productsProvider = Provider.of<ProductsProvider>(context);

    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(AssetsManager.logoImage),
          ),
          title: const AppNameText(fontSize: 25),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 5),
                SizedBox(
                  height: size.height * 0.25,
                  child: ClipRRect(
                    child: Swiper(
                      autoplay: true,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            switch (index) {
                              case 0:
                                Navigator.pushNamed(
                                  context, '/SearchScreen',
                                  //arguments: {'category': 'Clothes'}
                                );
                                break;
                              case 1:
                                Navigator.pushNamed(
                                  context, '/SearchScreen',
                                  //arguments: {'category': 'Watches'}
                                );
                                break;
                              case 2:
                                Navigator.pushNamed(
                                  context, '/SearchScreen',
                                  //arguments: {'category': 'Phones'}
                                );
                              case 3:
                                Navigator.pushNamed(
                                  context, '/SearchScreen',
                                  //arguments: {'category': 'Phones'}
                                );
                                break;
                            }
                          },
                          child: Image.asset(
                            AppConstants.bannerImages[index],
                            fit: BoxFit.fill,
                          ),
                        );
                      },
                      itemCount: AppConstants.bannerImages.length,
                      pagination: const SwiperPagination(
                          builder: DotSwiperPaginationBuilder(
                        activeColor: Colors.red,
                      )),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                Visibility(
                  visible: productsProvider.getProducts.isNotEmpty,
                  child: const TitleTextWidget(
                    label: "Latest Arrival",
                  ),
                ),
                const SizedBox(height: 10),
                Visibility(
                  visible: productsProvider.getProducts.isNotEmpty,
                  child: SizedBox(
                    height: size.height * 0.18,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: productsProvider.getProducts.length < 10
                          ? productsProvider.getProducts.length
                          : 10,
                      itemBuilder: (context, index) {
                        return ChangeNotifierProvider.value(
                          value: productsProvider.getProducts[index],
                          child: const LatestArrivalProductsWidget(),
                        );
                      },
                    ),
                  ),
                ),
                const TitleTextWidget(
                  label: "Categories",
                ),
                const SizedBox(height: 10),
                GridView.count(
                  childAspectRatio: 10 / 8,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 3,
                  children: List.generate(AppConstants.categoriesList.length,
                      (index) {
                    return CategoryRoundedWidget(
                      image: AppConstants.categoriesList[index].image,
                      name: AppConstants.categoriesList[index].name,
                    );
                  }),
                ),
              ],
            ),
          ),
        ));
  }
}
