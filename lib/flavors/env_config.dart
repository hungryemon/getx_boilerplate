// ignore_for_file: depend_on_referenced_packages

import 'package:logger/logger.dart';
import '/helper/constants/value_constants.dart';

class EnvConfig {
  final String appName;
  final String baseUrl;
  final bool shouldCollectLog;

  late final Logger logger;

  EnvConfig({
    required this.appName,
    required this.baseUrl,
    this.shouldCollectLog = false,
  }) {
    logger = Logger(
      printer: PrettyPrinter(
          methodCount: ValueConstants.loggerMethodCount,
          // number of method calls to be displayed
          errorMethodCount: ValueConstants.loggerErrorMethodCount,
          // number of method calls if stacktrace is provided
          lineLength: ValueConstants.loggerLineLength,
          // width of the output
          colors: true,
          // Colorful log messages
          printEmojis: true,
          // Print an emoji for each log message
          printTime: false // Should each log print contain a timestamp
          ),
    );
  }
}
