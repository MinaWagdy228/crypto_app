import 'package:crypto_app/data/model/UserModel.dart';
import 'package:crypto_app/data/repository/AuthRepo.dart';
import 'package:crypto_app/features/auth/cubit/UserStates.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserCubit extends Cubit<UserStates> {
  static UserCubit get(context) => BlocProvider.of(context);
  final AuthRepo authRepo;

  UserCubit(this.authRepo) : super(UserInitialState());

  Future<void> signUp(UserModel user) async {
    emit(UserLoadingState());
    try {
      await authRepo.signUp(user);
      emit(UserSignUpSuccessState());
    } catch (e) {
      emit(UserErrorState(e.toString()));
    }
  }

  Future<void> signInWithEmail(String email, String password) async {
    emit(UserLoadingState());
    try {
      final bool success = await authRepo.loginUserByEmail(email, password);
      if (success) {
        emit(UserLoginSuccessState());
      } else {
        emit(UserErrorState("Invalid email or password"));
      }
    } catch (e) {
      emit(UserErrorState(e.toString()));
    }
  }

  Future<void> signInWithPhoneNumber(
    String phoneNumber,
    String password,
  ) async {
    emit(UserLoadingState());

    try {
      final bool success = await authRepo.loginUserByPhoneNumber(
        phoneNumber,
        password,
      );
      if (success) {
        emit(UserLoginSuccessState());
      } else {
        emit(UserErrorState("Invalid phone number or password"));
      }
    } catch (e) {
      emit(UserErrorState(e.toString()));
    }
  }

  // Future<void> logout() async {
  //   emit(UserLoadingState());
  //   try {
  //     await authRepo.logoutUser();
  //     emit(UserInitialState());
  //   } catch (e) {
  //     emit(UserErrorState(e.toString()));
  //   }
  // }

  Future<void> fetchCurrentUser() async {
    emit(UserLoadingState());
    try {
      final user = await authRepo.getCurrentUser();
      if (user != null) {
        emit(UserLoadedState(user));
      } else {
        emit(UserErrorState("Could not load user profile."));
      }
    } catch (e) {
      emit(UserErrorState(e.toString()));
    }
  }

  Future<void> updateProfile(UserModel updatedUser) async {
    emit(UserLoadingState());
    try {
      await authRepo.updateUser(updatedUser);
      emit(UserProfileUpdateSuccessState());
      emit(UserLoadedState(updatedUser));
    } catch (e) {
      emit(UserErrorState(e.toString()));
    }
  }


  Future<void> checkAuthStatus() async {
    await Future.delayed(const Duration(milliseconds: 2000));

    try {
      final isLoggedIn = await authRepo.isLoggedIn();
      if (isLoggedIn) {
        emit(UserAuthenticatedState());
      } else {
        emit(UserUnauthenticatedState());
      }
    } catch (e) {
      emit(UserUnauthenticatedState());
    }
  }
}
