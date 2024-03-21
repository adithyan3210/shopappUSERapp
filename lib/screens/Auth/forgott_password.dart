import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:shopapp/consts/validator.dart';
import 'package:shopapp/services/asset_manager.dart';
import 'package:shopapp/widgets/appname_text.dart';
import 'package:shopapp/widgets/subtitle_text.dart';
import 'package:shopapp/widgets/title_text.dart';

class ForgottPassordScreen extends StatefulWidget {
  static const routeName = '/ForgottPassordScreen';
  const ForgottPassordScreen({super.key});

  @override
  State<ForgottPassordScreen> createState() => _ForgottPassordScreenState();
}

class _ForgottPassordScreenState extends State<ForgottPassordScreen> {
  late final TextEditingController _emailController;
  late final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    _emailController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    if (mounted) {}
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _forgottPassFCT() async {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (isValid) {}
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Image.asset(AssetsManager.shoppingCart),
        ),
        title: const AppNameText(fontSize: 25),
      ),
      body: GestureDetector(
        onTap: () {},
        child: SafeArea(
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            physics: const BouncingScrollPhysics(),
            children: [
              Image.asset(
                AssetsManager.forgotPassword,
                width: size.width * 0.6,
                height: size.width * 0.6,
              ),
              const SizedBox(height: 10),
              const TitleTextWidget(
                label: "Forgott Password",
                fontSize: 22,
              ),
              const SubTitleTextWidget(
                label:
                    "Please enter the email address you\r like your password reset information sent to",
                fontSize: 14,
              ),
              const SizedBox(height: 40),
              Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _emailController,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          hintText: 'youremail.email.com',
                          prefixIcon: Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Icon(IconlyLight.message),
                          ),
                          filled: true,
                        ),
                        validator: (value) {
                          return MyValidator.emailValidator(value);
                        },
                      ),
                      const SizedBox(height: 15),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.all(12),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10))),
                          icon: const Icon(IconlyBold.send),
                          label: const Text('Request Link'),
                          onPressed: () async {
                            _forgottPassFCT();
                          },
                        ),
                      ),
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
