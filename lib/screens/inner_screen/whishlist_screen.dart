import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/providers/wishlist_provider.dart';
import 'package:shopapp/services/asset_manager.dart';
import 'package:shopapp/services/my_app_functions.dart';
import 'package:shopapp/widgets/empty_cart.dart';
import 'package:shopapp/widgets/products/products_widget.dart';
import 'package:shopapp/widgets/title_text.dart';

class WhishlistScreen extends StatelessWidget {
  static const routeName = "/WhishlistScreen";
  const WhishlistScreen({super.key});
  final bool isEmpty = true;
  @override
  Widget build(BuildContext context) {
    final wishlistProvider = Provider.of<WishlistProvider>(context);

    return wishlistProvider.getWishlistItems.isEmpty
        ? Scaffold(
            body: EmptyBagWidget(
              imagePath: AssetsManager.bagWish,
              title: "No In Your Whishlist Yet",
              subTitle:
                  "look Like Your Cart Is Empty Add Something And Make me Happy",
              buttonText: "Shop Now",
            ),
          )
        : Scaffold(
            appBar: AppBar(
              title: TitleTextWidget(
                  label:
                      "Whishlist(${wishlistProvider.getWishlistItems.length})"),
              actions: [
                IconButton(
                  onPressed: () {
                    MyAppFunctions.showErrorOrWarningDialog(
                      isError: false,
                      context: context,
                      subtitle: "Clear All?",
                      fct: () async {
                        await wishlistProvider.clearWishlistFromFirebase();
                        wishlistProvider.clearLocalWishlist();
                      },
                    );
                  },
                  icon: const Icon(Icons.delete_forever_rounded),
                )
              ],
            ),
            body: DynamicHeightGridView(
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                builder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ProductWidget(
                      productId: wishlistProvider.getWishlistItems.values
                          .toList()[index]
                          .productId,
                    ),
                  );
                },
                itemCount: wishlistProvider.getWishlistItems.length,
                crossAxisCount: 2),
          );
  }
}
