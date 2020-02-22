import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quick_editor_v2/bloc/bloc_delegate.dart';
import 'package:quick_editor_v2/ui/widget/start_app/start_app.dart';
import 'package:quick_editor_v2/utils/log.dart';

class AppInitialization extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(),
      home: StartApp(),
    );
  }
}

class RepositoryInitialization extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<Log>(
      create: (BuildContext context) => Log(),
      child: BlocInitialization(),
    );
  }
}

class BlocInitialization extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    BlocSupervisor.delegate =
        CustomBlocDelegate(RepositoryProvider.of<Log>(context));
    return AppInitialization();
  }
}
