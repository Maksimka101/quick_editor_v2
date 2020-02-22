import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quick_editor_v2/bloc/auth_bloc.dart';
import 'package:quick_editor_v2/bloc/bloc_delegate.dart';
import 'package:quick_editor_v2/bloc/tables_bloc.dart';
import 'package:quick_editor_v2/ui/widget/start_app/start_app.dart';

class AppInitialization extends StatefulWidget {
  @override
  _AppInitializationState createState() => _AppInitializationState();
}

class _AppInitializationState extends State<AppInitialization> {
  @override
  void initState() {
    BlocSupervisor.delegate = CustomBlocDelegate();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(),
      home: MultiRepositoryProvider(
        providers: [],
        child: Builder(
          builder: (repositoryContext) => MultiBlocProvider(
            providers: [
              BlocProvider<AuthBloc>(
                create: (_) => AuthBloc(),
              ),
              BlocProvider<TablesBloc>(
                create: (_) => TablesBloc(),
              )
            ],
            child: Builder(
              builder: (blocContext) => StartApp(),
            ),
          ),
        ),
      ),
    );
  }
}
