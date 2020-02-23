import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quick_editor_v2/bloc/auth_bloc.dart';
import 'package:quick_editor_v2/ui/screen/error_screen.dart';
import 'package:quick_editor_v2/ui/screen/intro_loading_screen.dart';
import 'package:quick_editor_v2/ui/screen/tables_screen.dart';

class StartApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        switch (state.runtimeType) {
          case AuthInitial:
            BlocProvider.of<AuthBloc>(context).add(AuthStarted());
            return IntroLoadingScreen();
            break;
          case Authenticated:
            return TablesScreen();
            break;
          default:
            return ErrorScreen();
            break;
        }
      },
    );
  }
}
