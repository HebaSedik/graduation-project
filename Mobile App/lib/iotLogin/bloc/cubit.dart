import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_home_app/iotLogin/bloc/states.dart';

class iotLoginCubit extends Cubit<iotLoginStates> {
  iotLoginCubit() : super(iotLoginInitialState());

  static iotLoginCubit get(context) => BlocProvider.of(context);

  IconData suffix = Icons.visibility_outlined;
  bool ispassword = true;
  void passwordvisiblity() {
    ispassword = !ispassword;
    suffix =
        ispassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(visiblitystate());
  }

  Future<void> userLogin({
    required String email,
    required String password,
  }) async {
    emit(iotLoginLodingState());
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) {
      print(value.user);
      emit(iotLoginsuccessState(value.user!.uid));
    }).catchError((Error) {
      emit(iotLoginerrorState());

      print("the error${Error.toString()}");
    });
  }
}
