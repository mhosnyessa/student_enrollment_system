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
    on<LoginButtonPressed>(_loginButtonPressed);
  }

  // FutureOr<void> _mapwrapper(
  //     LoginSignupEvent event, Emitter<LoginSignupState> emit) {
  // mapEventToState(event, emit);
  // }

  // Stream<LoginSignupState> mapEventToState(
  //     LoginSignupEvent event, Emitter<LoginSignupState> emit) async* {
  //   if (event is LoginButtonPressed) {
  //     yield LoginSignupLoading();
  //     try {
  //       final user = await _authenticationRepository.login(
  //         email: event.email,
  //         password: event.password,
  //       );
  //       yield LoginSignupSuccess(user: user);
  //     } catch (error) {
  //       yield LoginSignupFailure(error: error.toString());
  //     }
  //   } else if (event is SignupButtonPressed) {
  //     yield LoginSignupLoading();
  //     try {
  //       final UserModel user = await _authenticationRepository.signup(
  //         email: event.email,
  //         password: event.password,
  //       );
  //       await _userRepository.createNewUser(user,
  //           email: '', fullName: '', password: '', phoneNumber: '');
  //       yield LoginSignupSuccess(user: user);
  //     } catch (error) {
  //       yield LoginSignupFailure(error: error.toString());
  //     }
  //   }
  // }

  Future<FutureOr<void>> _loginButtonPressed(
      LoginButtonPressed event, Emitter<LoginSignupState> emit) async {
    emit(LoginSignupLoading());
    final UserModel user = await _authenticationRepository.login(
        email: event.email, password: event.password);
    print('user returned : $user');
    if (user == UserModel.empty) {
      emit(const LoginSignupFailure(error: "An error occurred."));
    } else {
      emit(LoginSignupSuccess(user: user));
    }
  }
}


// class AppBloc extends Bloc<AppEvent, AppState> {
//   AppBloc({required AuthenticationRepository authenticationRepository})
//       : _authenticationRepository = authenticationRepository,
//         super(
//           authenticationRepository.currentUser.isNotEmpty
//               ? AppState.authenticated(authenticationRepository.currentUser)
//               : const AppState.unauthenticated(),
//         ) {
//     on<_AppUserChanged>(_onUserChanged);
//     on<AppLogoutRequested>(_onLogoutRequested);
//     _userSubscription = _authenticationRepository.user.listen(
//       (user) => add(_AppUserChanged(user)),
//     );
//   }

//   final AuthenticationRepository _authenticationRepository;
//   late final StreamSubscription<User> _userSubscription;

//   void _onUserChanged(_AppUserChanged event, Emitter<AppState> emit) {
//     emit(
//       event.user.isNotEmpty
//           ? AppState.authenticated(event.user)
//           : const AppState.unauthenticated(),
//     );
//   }

//   void _onLogoutRequested(AppLogoutRequested event, Emitter<AppState> emit) {
//     unawaited(_authenticationRepository.logOut());
//   }

//   @override
//   Future<void> close() {
//     _userSubscription.cancel();
//     return super.close();
//   }
// }
