import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shopapp/main.dart';
import 'package:shopapp/widgets/subtitle_text.dart';
import 'package:shopapp/widgets/title_text.dart';

class OrderDoneSplash extends StatelessWidget {
  const OrderDoneSplash({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Lottie.asset(
              'assets/animation/orderdone.json',
              height: 200,
              width: 200,
              repeat: false,
              frameRate: FrameRate.max,
            ),
          ),
          const TitleTextWidget(
            label: "Success!",
            fontSize: 25,
          ),
          const SubTitleTextWidget(label: "Your order will delivered soon"),
          const SubTitleTextWidget(label: "Thank you! for choosing our app"),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) {
                  return const MyApp();
                },
              ));
            },
            child: const TitleTextWidget(label: "Continue Shopping"),
          ),
        ],
      ),
    );
  }
}
