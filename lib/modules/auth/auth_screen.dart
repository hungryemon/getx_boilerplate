import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_boilerplate/app/base/base_view.dart';
import 'package:getx_boilerplate/helper/custom_navigation.dart';

import '../../routes/routes.dart';
import '../../shared/shared.dart';
import 'auth_controller.dart';

// ignore: must_be_immutable
class AuthScreen extends BaseView<AuthController> {
  AuthScreen({super.key});

  @override
  Widget body(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Center(
          child: _buildItems(context),
        ),
      ),
    );
  }

  Widget _buildItems(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      children: [
        Icon(
          Icons.home,
          size: SizeConfig().screenWidth * 0.26,
          color: Colors.blueGrey,
        ),
        const SizedBox(height: 20.0),
        Text(
          'Welcome',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: CommonConstants.largeText,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).textTheme.titleLarge!.color,
          ),
        ),
        const SizedBox(height: 10.0),
        Text(
          'Let\'s start now!',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: CommonConstants.normalText,
            color: Theme.of(context).textTheme.titleMedium!.color,
          ),
        ),
        const SizedBox(height: 50.0),
        GradientButton(
          text: 'Sign In',
          onPressed: () {
            Get.toNamed(AppRoutes.AUTH + AppRoutes.LOGIN, arguments: controller);
          },
        ),
        const SizedBox(height: 20.0),
        BorderButton(
          text: 'Sign Up',
          onPressed: () {
            goToNamed(AppRoutes.AUTH + AppRoutes.REGISTER, arguments: controller);
          },
        ),
        const SizedBox(height: 62.0),
        Text(
          'This is a demo only used for test.',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: CommonConstants.smallText,
            color: ColorConstants.tipColor,
          ),
        ),
      ],
    );
  }

  @override
  PreferredSizeWidget? appBar(BuildContext context) {
    return null;
  }
}
