import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_home_app/iotregister/bloc/states.dart';
import 'package:smart_home_app/models/usermodel.dart';

class ioRegiserCubit extends Cubit<iotRegisterStates> {
  ioRegiserCubit() : super(iotRegisterInitialState());

  static ioRegiserCubit get(context) => BlocProvider.of(context);

  Future<void> userRegister({
    // required String name,
    // required String phone,
    required String email,
    required String password,
  }) async {
    print("object");
    emit(iotRegisterLodingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      usercreat(
        // name: name,
        // phone: phone,
        email: email,
        uid: value.user!.uid,
      );
      print(value.user);
      // emit(iotRegistersuccessState());
    }).catchError((Error) {
      print(Error.toString());
      emit(iotRegistererrorState());
    });
  }

  Future<void> usercreat({
    // required String name,
    // required String phone,
    required String email,
    required String uid,
  }) async {
    UserModel? usermodel = UserModel(
      // name: name,
      // phone: phone,
      email: email,
      uid: uid,
      // image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRoXSUxysVdmnP4CmDE3ENtI0AawOW_ysx4SQ&usqp=CAU'
    );

    FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .set(usermodel.toMap())
        .then((value) {
      emit(iotcreatsuccessState());
    }).catchError((Error) {
      emit(iotcreaterrorState());
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool ispassword = true;
  void passwordvisiblity() {
    ispassword = !ispassword;
    suffix =
        ispassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(passwordstate());
  }
}
