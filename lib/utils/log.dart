import 'package:quick_log/quick_log.dart';

class Log {
  static const Logger _logger = Logger("Main app logger");

  Log() {
    Logger.writer = const ConsolePrinter();
  }

  static void error(String message, [String extraMessage]) =>
      _logger.error("$message${extraMessage != null ? '$extraMessage' : ''}");

  static void info(String message, [String extraMessage]) =>
      _logger.info("$message${extraMessage != null ? '$extraMessage' : ''}");

  static void debug(String message, [String extraMessage]) =>
      _logger.debug("$message${extraMessage != null ? '$extraMessage' : ''}");

  static void warning(String message, [String extraMessage]) =>
      _logger.warning("$message${extraMessage != null ? '$extraMessage' : ''}");

  static void fine(String message, [String extraMessage]) =>
      _logger.fine("$message${extraMessage != null ? '$extraMessage' : ''}");
}
