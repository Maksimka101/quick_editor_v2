import 'package:flutter/material.dart';
import 'package:quick_editor_v2/ui/widget/start_app/start_app.dart';

class AppInitialization extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(),
      home: _RepositoryInitialization(),
    );
  }
}

class _RepositoryInitialization extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _BlocInitialization();
  }
}

class _BlocInitialization extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StartApp();
  }
}
