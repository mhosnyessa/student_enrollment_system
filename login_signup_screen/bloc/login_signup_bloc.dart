import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:gui_db/authentication_repository.dart';
import 'package:gui_db/user_repository.dart';
import '../../user_model.dart';
import 'login_signup_event.dart';
import 'login_signup_state.dart';

class LoginSignupBloc extends Bloc<LoginSignupEvent, LoginSignupState> {
  final AuthenticationRepository _authenticationRepository;
  final UserRepository _userRepository;

  LoginSignupBloc(
      {required AuthenticationRepository authenticationRepository,
      required UserRepository userRepository})
      : _authenticationRepository = authenticationRepository,
        _userRepository = userRepository,
        super(LoginSignupInitial()) {
    on<LoginSignupEvent>(_mapwrapper);
  }

  FutureOr<void> _mapwrapper(
      LoginSignupEvent event, Emitter<LoginSignupState> emit) {
    mapEventToState(event, emit);
  }

  Stream<LoginSignupState> mapEventToState(
      LoginSignupEvent event, Emitter<LoginSignupState> emit) async* {
    if (event is LoginButtonPressed) {
      yield LoginSignupLoading();
      try {
        final user = await _authenticationRepository.login(
          email: event.email,
          password: event.password,
        );
        yield LoginSignupSuccess(user: user);
      } catch (error) {
        yield LoginSignupFailure(error: error.toString());
      }
    } else if (event is SignupButtonPressed) {
      yield LoginSignupLoading();
      try {
        final UserModel user = await _authenticationRepository.signup(
          email: event.email,
          password: event.password,
        );
        await _userRepository.createNewUser(user,
            email: '', fullName: '', password: '', phoneNumber: '');
        yield LoginSignupSuccess(user: user);
      } catch (error) {
        yield LoginSignupFailure(error: error.toString());
      }
    }
  }
}
