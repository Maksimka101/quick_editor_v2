import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quick_editor_v2/bloc/tables_bloc.dart';
import 'package:quick_editor_v2/ui/widget/error.dart';
import 'package:quick_editor_v2/utils/log.dart';

class TablesScreen extends StatefulWidget {
  @override
  _TablesScreenState createState() => _TablesScreenState();
}

class _TablesScreenState extends State<TablesScreen> {
  @override
  void initState() {
    BlocProvider.of<TablesBloc>(context).add(LoadTables());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: BlocBuilder<TablesBloc, TablesState>(
      builder: (context, state) {
        switch (state.runtimeType) {
          default:
            Log.warning("Uncknow state: $state");
            return const ErrorMessage();
            break;
        }
      },
    ));
  }
}
