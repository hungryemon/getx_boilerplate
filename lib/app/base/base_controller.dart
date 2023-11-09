// ignore_for_file: depend_on_referenced_packages

import 'dart:async';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import '../model/page_state.dart';
import '/network/exceptions/api_exception.dart';
import '/network/exceptions/app_exception.dart';
import '/network/exceptions/json_format_exception.dart';
import '/network/exceptions/network_exception.dart';
import '/network/exceptions/not_found_exception.dart';
import '/network/exceptions/service_unavailable_exception.dart';
import '/network/exceptions/unauthorize_exception.dart';
import '/flavors/build_config.dart';

abstract class BaseController extends SuperController {
  final Logger logger = BuildConfig.instance.config.logger;

  final logoutController = false.obs;

  //Reload the page
  final _refreshController = false.obs;

  refreshPage(bool refresh) => _refreshController(refresh);

  //Controls page state
  final _pageSateController = PageState.DEFAULT.obs;

  PageState get pageState => _pageSateController.value;

  updatePageState(PageState state) => _pageSateController(state);

  resetPageState() => _pageSateController(PageState.DEFAULT);

  showLoading() => updatePageState(PageState.LOADING);

  hideLoading() => resetPageState();

  final _messageController = ''.obs;

  String get message => _messageController.value;

  showMessage(String msg) => _messageController(msg);

  final _errorMessageController = ''.obs;

  String get errorMessage => _errorMessageController.value;

  showErrorMessage(String msg) {
    _errorMessageController(msg);
  }

  final _successMessageController = ''.obs;

  String get successMessage => _messageController.value;

  showSuccessMessage(String msg) => _successMessageController(msg);

  // ignore: long-parameter-list
  dynamic callDataService<T>(
    Future<T> future, {
    Function(Exception exception, String message)? onError,
    Function(T response)? onSuccess,
    Function? onStart,
    Function? onComplete,
    Function(Exception? exception)? onComplete2,
    bool hideLoader = false,
    bool showErrorToast = true,
  }) async {
    Exception? ex;
    _errorMessageController('');
    String msg = "";

    onStart != null
        ? onStart()
        : !hideLoader
            ? showLoading()
            : () {};

    try {
      final T response = await future;

      if (onSuccess != null) onSuccess(response);

      onComplete == null ? hideLoading() : onComplete();
      onComplete2 == null ? hideLoading() : onComplete2(null);

      return response;
    } on ServiceUnavailableException catch (exception) {
      ex = exception;
      msg = exception.message;
    } on UnauthorizedException catch (exception) {
      ex = exception;
      msg = exception.message;
    } on TimeoutException catch (exception) {
      ex = exception;
      msg = exception.message ?? 'Timeout exception';
    } on NetworkException catch (exception) {
      ex = exception;
      msg = exception.message;
    } on JsonFormatException catch (exception) {
      ex = exception;
      msg = exception.message;
    } on NotFoundException catch (exception) {
      ex = exception;
      msg = exception.message;
    } on ApiException catch (exception) {
      ex = exception;
      msg = exception.message;
    } on AppException catch (exception) {
      ex = exception;
      msg = exception.message;
    } catch (error, stacktrace) {
      ex = AppException(message: "$error");
      msg = "Unknown error occured";
      logger.e("Controller>>>>>> error $error");
      logger.e("Controller>>>>>> stacktrace $stacktrace");
    }

    if (showErrorToast) showErrorMessage(msg);

    if (onError != null) onError(ex, msg);

    onComplete == null ? hideLoading() : onComplete();
    onComplete2 == null ? hideLoading() : onComplete2(ex);
  }

  @override
  void onClose() {
    _messageController.close();
    _refreshController.close();
    _pageSateController.close();
    super.onClose();
  }
}
