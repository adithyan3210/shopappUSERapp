import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/models/orders_model.dart';
import 'package:shopapp/providers/order_provider.dart';
import 'package:shopapp/screens/inner_screen/orders/orders_widget.dart';
import 'package:shopapp/services/asset_manager.dart';
import 'package:shopapp/widgets/empty_cart.dart';
import 'package:shopapp/widgets/title_text.dart';

class OrderScreenFree extends StatefulWidget {
  static const routeName = '/OrderScreen';
  const OrderScreenFree({Key? key}) : super(key: key);

  @override
  State<OrderScreenFree> createState() => _OrderScreenFreeState();
}

class _OrderScreenFreeState extends State<OrderScreenFree> {
  @override
  Widget build(BuildContext context) {
    final ordersProvider = Provider.of<OrderProvider>(context);
    return Scaffold(
        appBar: AppBar(
          title: const TitleTextWidget(
            label: 'My Orders',
          ),
        ),
        body: FutureBuilder<List<OrderModelAdvanced>>(
          future: ordersProvider.fetchOrders(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: SelectableText(snapshot.error.toString()),
              );
            } else if (!snapshot.hasData || ordersProvider.getOrders.isEmpty) {
              return EmptyBagWidget(
                imagePath: AssetsManager.noorder,
                title: "No orders has been placed yet",
                subTitle: "",
                buttonText: "Shop now",
              );
            }
            return ListView.separated(
              itemCount: snapshot.data!.length,
              itemBuilder: (ctx, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 2,
                    vertical: 6,
                  ),
                  child: OrderWidgetFree(
                      orderModelAdvanced:
                          ordersProvider.getOrders.toList()[index]),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return const Divider();
              },
            );
          },
        ));
  }
}
