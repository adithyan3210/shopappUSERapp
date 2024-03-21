import 'package:flutter/material.dart';
import 'package:shopapp/widgets/subtitle_text.dart';
import 'package:shopapp/widgets/title_text.dart';

class SingleDeliveryItem extends StatelessWidget {
  final String? name;
  final String? mobileNumber;
  final String? alternateNumber;
  final String? pincode;
  final String? state;
  final String? addressMain;
  final String? locality;
  final String? city;
  final String? addressType;

  const SingleDeliveryItem({
    super.key,
    this.name,
    this.mobileNumber,
    this.alternateNumber,
    this.pincode,
    this.state,
    this.addressMain,
    this.locality,
    this.city,
    this.addressType,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, top: 10, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TitleTextWidget(label: name!),
              Container(
                width: 60,
                height: 20,
                padding: const EdgeInsets.all(1),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Center(
                  child: Text(
                    "Home",
                    style: TextStyle(fontSize: 12, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          SubTitleTextWidget(label: addressMain!, fontSize: 15),
          SubTitleTextWidget(label: locality!, fontSize: 15),
          Row(children: [
            SubTitleTextWidget(label: city!, fontSize: 15),
            SubTitleTextWidget(label: state!, fontSize: 15),
          ]),
          SubTitleTextWidget(label: pincode!, fontSize: 15),
          const SizedBox(height: 5),
          SubTitleTextWidget(
              label: "Mobile:${mobileNumber!},${alternateNumber!}",
              fontSize: 15),
        ],
      ),
    );
  }
}
