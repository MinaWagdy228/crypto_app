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
}
