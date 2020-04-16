import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:quick_editor_v2/model/hive/counter.dart';
import 'package:quick_editor_v2/model/hive/counter_item.dart';
import 'package:quick_editor_v2/model/hive/table.dart';

class HiveUtils {
  static const TABLES_BOX = 'tables_box';

  static final HiveUtils instance = HiveUtils._();

  HiveUtils._();

  var _initialized = false;

  bool get isInitialized => _initialized;

  Future<void> init() async {
    if (!_initialized) {
      if (Platform.isAndroid || Platform.isIOS || kIsWeb) {
        // todo: test it
        Hive.init(Directory.current.path);
      } else {
        Hive.init(Directory.current.path);
      }
      Hive.registerAdapter(CounterItemHiveImplAdapter());
      Hive.registerAdapter(IntCounterHiveImplAdapter());
      Hive.registerAdapter(TableHiveImplAdapter());
      _initialized = true;
    }
  }
}
