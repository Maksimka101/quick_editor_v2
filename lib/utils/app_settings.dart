import 'package:flutter/foundation.dart';

class App {
  static const appName = "Quick editor v2";
  static const settings = _AppSettings();
}

class _AppSettings {
  const _AppSettings();

  /// use Thanos effect on delete
  bool get useSnapOnDelete {
    if (kReleaseMode) {
      return true;
    } else {
      return false;
    }
  }
}
