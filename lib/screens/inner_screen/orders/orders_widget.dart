import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:shopapp/models/orders_model.dart';
import 'package:shopapp/widgets/subtitle_text.dart';
import 'package:shopapp/widgets/title_text.dart';

class OrderWidgetFree extends StatefulWidget {
  const OrderWidgetFree({super.key, required this.orderModelAdvanced});
  final OrderModelAdvanced orderModelAdvanced;

  @override
  State<OrderWidgetFree> createState() => _OrderWidgetFreeState();
}

class _OrderWidgetFreeState extends State<OrderWidgetFree> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: FancyShimmerImage(
              imageUrl: widget.orderModelAdvanced.imageUrl,
              height: size.width * 0.25,
              width: size.width * 0.25,
            ),
          ),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: TitleTextWidget(
                            fontSize: 15,
                            maxLines: 2,
                            label: widget.orderModelAdvanced.productTitle),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const TitleTextWidget(
                        label: "Price:",
                        maxLines: 2,
                        fontSize: 15,
                      ),
                      Flexible(
                        child: SubTitleTextWidget(
                          label: "₹ ${widget.orderModelAdvanced.price}",
                          fontSize: 15,
                          color: Colors.blue,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 10),
                  SubTitleTextWidget(
                    label: "QTY:${widget.orderModelAdvanced.quantity}",
                    fontSize: 15,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
