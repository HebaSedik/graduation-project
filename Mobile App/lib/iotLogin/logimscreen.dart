import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_home_app/iotLogin/bloc/cubit.dart';
import 'package:smart_home_app/iotLogin/bloc/states.dart';
import 'package:smart_home_app/iotregister/registerscreen.dart';
import 'package:smart_home_app/preseitation-layer/screens/bottomnavScreen.dart';
import 'package:smart_home_app/data-layer/shardprefresnses/shardprefrenses.dart';

import '../data-layer/custemshard/shard.dart';

// ignore: must_be_immutable
class LoginScreen extends StatelessWidget {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  // bool isVisible = true;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<iotLoginCubit>(
      create: (context) => iotLoginCubit(),
      child: BlocConsumer<iotLoginCubit, iotLoginStates>(
        listener: (context, state) {
          if (state is iotLoginerrorState) {
            AwesomeDialog(
              context: context,
              dialogType: DialogType.error,
              animType: AnimType.leftSlide,
              title: 'Error',
              desc: 'No user found for that email',
              btnOkOnPress: () {},
            ).show();
          }
          if (state is iotLoginsuccessState) {
            ChachHelper.saveData(
              key: 'uid',
              value: state.uid,
            ).then((value) {
              navigateAndFinish(context, BottomNaveScreen());
            });
          }
        },
        builder: (context, state) {
          return SafeArea(
            child: Scaffold(
              body: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Login",
                        style: GoogleFonts.aclonica(
                          fontSize: MediaQuery.of(context).size.height / 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Welcome To Smart Home",
                        style: GoogleFonts.aclonica(
                            fontSize: MediaQuery.of(context).size.height / 30,
                            color: Colors.blue),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 30,
                      ),
                      defaultFormField(
                          controller: emailController,
                          label: "Email",
                          type: TextInputType.emailAddress,
                          suffixIcon: Icons.email_outlined),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 45,
                      ),
                      defaultFormField(
                          controller: passwordController,
                          visibility: iotLoginCubit.get(context).ispassword,
                          label: "Password",
                          type: TextInputType.visiblePassword,
                          suffixIcon: iotLoginCubit.get(context).ispassword
                              ? Icons.visibility
                              : Icons.visibility_off,
                          onTape: () {
                            iotLoginCubit.get(context).passwordvisiblity();
                          }),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 30,
                      ),
                      ConditionalBuilder(
                          condition: State is! iotLoginLodingState,
                          builder: (context) => defaultButton(
                              text: "login",
                              function: () {
                                if (formKey.currentState!.validate()) {
                                  iotLoginCubit.get(context).userLogin(
                                        email: emailController.text,
                                        password: passwordController.text,
                                      );
                                }
                              }),
                          fallback: (context) =>
                              Center(child: CircularProgressIndicator())),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Don/'t have an account ",
                            style: GoogleFonts.aclonica(
                              fontSize: MediaQuery.of(context).size.height / 60,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              navigateTo(context, RegisterScreen());
                            },
                            child: Text(
                              "Register",
                              style: GoogleFonts.aclonica(
                                fontSize:
                                    MediaQuery.of(context).size.height / 50,
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
