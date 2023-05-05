import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:gui_db/authentication_repository.dart';
import 'package:gui_db/program_model.dart';
import 'package:gui_db/user_repository.dart';
import '../../data_repository.dart';
import '../../user_model.dart';
import 'program_detail_event.dart';
import 'program_detail_state.dart';

class ProgramDetailBloc extends Bloc<ProgramDetailEvent, ProgramDetailState> {
  final DataRepository _dataRepo;

  ProgramDetailBloc(
      {required DataRepository dataRepository,
      required UserRepository userRepository})
      : _dataRepo = dataRepository,
        super(ProgramDetailInitial()) {
    // _loadData();
    // on<ProgramDetailEvent>(_loadData);
    on<ProgramDetailRequested>(_loadData);
  }

  FutureOr<void> _loadData(
      ProgramDetailEvent event, Emitter<ProgramDetailState> emit) async {
    print('_loaddata was called');
    emit(ProgramDetailLoading());
    List<ProgramModel> programs = await _dataRepo.getPrograms();
    if (programs.isEmpty) {
      emit(const ProgramDetailFailure(error: ProgramDetailError.empty));
    } else {
      emit(ProgramDetailSuccess(programs: programs));
    }
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
