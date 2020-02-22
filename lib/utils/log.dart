import 'package:quick_log/quick_log.dart';

class Log {
  Logger _logger;

  Log() {
    _logger = const Logger("Main app logger");
    Logger.writer = const ConsolePrinter();
  }

  void error(String message, [String extraMessage]) =>
      _logger.error("$message${extraMessage != null ? '\n$extraMessage' : ''}");

  void info(String message, [String extraMessage]) =>
      _logger.info("$message${extraMessage != null ? '\n$extraMessage' : ''}");

  void debug(String message, [String extraMessage]) =>
      _logger.debug("$message${extraMessage != null ? '\n$extraMessage' : ''}");

  void warning(String message, [String extraMessage]) => _logger
      .warning("$message${extraMessage != null ? '\n$extraMessage' : ''}");

  void fine(String message, [String extraMessage]) =>
      _logger.fine("$message${extraMessage != null ? '\n$extraMessage' : ''}");
}
