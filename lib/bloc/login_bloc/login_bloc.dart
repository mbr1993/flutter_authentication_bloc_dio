import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../repository/repositories.dart';
import '../auth_bloc/auth_bloc.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepository userRepository;
  final AuthBloc authBloc;

  LoginBloc({required this.userRepository, required this.authBloc}) : super(LoginInitial()) {
    on<LoginButtonPressed>((event, emit) async {
      emit(LoginLoading());
      try {
        final String token = await userRepository.login(event.email, event.password);
        authBloc.add(LoggedIn(token: token));
        emit(LoginInitial());
      } catch (e) {
        emit(LoginFailure(error: e.toString()));
      }
    });
  }
}
