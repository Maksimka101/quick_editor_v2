import 'package:bloc/bloc.dart';
import 'package:quick_editor_v2/utils/log.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  @override
  AuthState get initialState => AuthInitial();

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    switch (event.runtimeType) {
      case AuthStarted:
        yield* _mapAuthStartedToState();
        break;
      default:
        Log.warning("Uncknown event ${event.runtimeType}");
        break;
    }
  }

  Stream<AuthState> _mapAuthStartedToState() async* {
    yield Authenticated();
  }
}

abstract class AuthEvent {}

class AuthStarted extends AuthEvent {}

abstract class AuthState {}

abstract class AuthUiState extends AuthState {}

class AuthInitial extends AuthUiState {}

class Authenticated extends AuthUiState {}

class Unauthenticated extends AuthUiState {}

class Uninitialized extends AuthUiState {}
