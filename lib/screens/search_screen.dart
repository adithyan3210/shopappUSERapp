import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/models/product_model.dart';
import 'package:shopapp/providers/products_provider.dart';
import 'package:shopapp/services/asset_manager.dart';
import 'package:shopapp/widgets/products/products_widget.dart';
import 'package:shopapp/widgets/title_text.dart';
import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';

class SearchScreen extends StatefulWidget {
  static const routeName = '/SearchScreen';
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late TextEditingController searchTextController;

  @override
  void initState() {
    searchTextController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    searchTextController.dispose();
    super.dispose();
  }

//add a list for search
  List<ProductModel> productListSearch = [];

  @override
  Widget build(BuildContext context) {
    final productsProvider =
        Provider.of<ProductsProvider>(context, listen: false);
    String? passedCategory =
        ModalRoute.of(context)!.settings.arguments as String?;
    List<ProductModel> productList = passedCategory == null
        ? productsProvider.products
        : productsProvider.findByCategory(categoryName: passedCategory);

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(AssetsManager.logoImage),
          ),
          title: TitleTextWidget(label: passedCategory ?? "Search Products"),
        ),
        body: productList.isEmpty
            ? const Center(child: TitleTextWidget(label: "no product found"))
            : StreamBuilder<List<ProductModel>>(
                stream: productsProvider.fetchProductStream(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                  } else if (snapshot.hasError) {
                    return Center(
                      child: SelectableText(
                        snapshot.error.toString(),
                      ),
                    );
                  } else if (snapshot.data == null) {
                    return const Center(
                      child: SelectableText(
                        "No products has been added",
                      ),
                    );
                  }
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        TextField(
                          controller: searchTextController,
                          decoration: InputDecoration(
                            hintText: "Search",
                            prefixIcon: const Icon(Icons.search),
                            suffixIcon: GestureDetector(
                              onTap: () {
                                // setState(() {
                                FocusScope.of(context).unfocus();
                                searchTextController.clear();
                                // });
                              },
                              child: const Icon(
                                Icons.clear,
                                color: Colors.red,
                              ),
                            ),
                          ),
                          onChanged: (value) {
                            //search function add to search screen
                            setState(() {
                              productListSearch = productsProvider.searchQuery(
                                  searchText: searchTextController.text,
                                  passedList: productList);
                            });
                          },
                          onSubmitted: (value) {
                            //search function add to search screen
                            setState(() {
                              productListSearch = productsProvider.searchQuery(
                                  searchText: searchTextController.text,
                                  passedList: productList);
                            });
                          },
                        ),
                        const SizedBox(height: 15),
                        if (searchTextController.text.isNotEmpty &&
                            productListSearch.isEmpty) ...[
                          const Center(
                              child:
                                  TitleTextWidget(label: "No products Found"))
                        ],
                        Expanded(
                          child: DynamicHeightGridView(
                            itemCount: searchTextController.text.isNotEmpty
                                ? productListSearch.length
                                : productList.length,
                            crossAxisCount: 2,
                            mainAxisSpacing: 12,
                            crossAxisSpacing: 12,
                            builder: (context, index) {
                              return ProductWidget(
                                  productId:
                                      searchTextController.text.isNotEmpty
                                          ? productListSearch[index].productId
                                          : productList[index].productId);
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                }),
      ),
    );
  }
}
