// ignore_for_file: depend_on_referenced_packages

import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import '../../shared/shared.dart';
import 'base_custom_controller.dart';
import '/app/model/page_state.dart';
import '/flavors/build_config.dart';

// ignore: must_be_immutable
abstract class BaseView<Controller extends BaseCustomController>
    extends GetView<Controller> {
  final GlobalKey<ScaffoldState> globalKey = GlobalKey<ScaffoldState>();

  final Logger logger = BuildConfig.instance.config.logger;

  BaseView({Key? key}) : super(key: key);

  Widget body(
    BuildContext context,
  );

  PreferredSizeWidget? appBar(BuildContext context);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Stack(
        children: [
          annotatedRegion(context),
          Obx(() => controller.pageState == PageState.LOADING
              ? _showLoading()
              : Container()),
          Obx(() => controller.errorMessage.isNotEmpty
              ? showErrorSnackBar(controller.errorMessage)
              : Container()),
          Container(),
        ],
      ),
    );
  }

  Widget annotatedRegion(BuildContext context) {
    return AnnotatedRegion(
      value: SystemUiOverlayStyle(
        //Status bar color for android
        statusBarColor: statusBarColor(context),
        systemNavigationBarColor: Theme.of(context).scaffoldBackgroundColor,
        statusBarIconBrightness:
            Get.isDarkMode ? Brightness.light : Brightness.dark,
        systemNavigationBarIconBrightness:
            Get.isDarkMode ? Brightness.light : Brightness.dark,
        statusBarBrightness:
            Get.isDarkMode ? Brightness.dark : Brightness.light,
      ),
      child: pageSafeArea(context),
    );
  }

  Widget pageSafeArea(BuildContext context) {
    return Material(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: SafeArea(
        child: pageScaffold(context),
      ),
    );
  }

  pageScaffold(BuildContext context) {
    return LayoutBuilder(builder: (contextLay, constraints) {
      return Scaffold(
        //sets ios status bar color
        extendBody: true,
        backgroundColor: pageBackgroundColor(context),
        key: globalKey,
        appBar: appBar(context),
        floatingActionButton: floatingActionButton(context),
        floatingActionButtonLocation: floatingActionButtonLocation,
        body: pageContent(context),
        bottomNavigationBar: bottomNavigationBar(context),
        drawer: drawer(context),
        endDrawer: Padding(
            padding: Platform.isIOS
                ? const EdgeInsets.fromLTRB(16, 24, 16, 8)
                : const EdgeInsets.fromLTRB(16, 8, 16, 8),
            child: endDrawer(context)),
      );
    });
  }

  Widget pageContent(BuildContext context) {
    return body(context);
  }

  Widget showErrorSnackBar(String message) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      CommonWidget.toast(message,);
    });

    return Container();
  }

  Color pageBackgroundColor(BuildContext context) {
    return Theme.of(context).scaffoldBackgroundColor;
  }

  Color statusBarColor(BuildContext context) {
    return Theme.of(context).colorScheme.background;
  }

  Widget? floatingActionButton(BuildContext context) {
    return null;
  }

  FloatingActionButtonLocation? floatingActionButtonLocation;

  Widget? bottomNavigationBar(BuildContext context) {
    return null;
  }

  Widget? endDrawer(BuildContext context) {
    return null;
  }

  Widget? drawer(BuildContext context) {
    return null;
  }

  Widget _showLoading() {
    return const SizedBox(
      height: 60,
      width: 60,
      child: CircularProgressIndicator(color: Colors.purple, ));
  }
}
