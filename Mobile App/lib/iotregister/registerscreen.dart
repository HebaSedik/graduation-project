import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_home_app/preseitation-layer/screens/bottomnavScreen.dart';
import 'package:smart_home_app/data-layer/custemshard/shard.dart';

import 'bloc/cubit.dart';
import 'bloc/states.dart';

// ignore: must_be_immutable
class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  bool isVisible = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ioRegiserCubit(),
      child: BlocConsumer<ioRegiserCubit, iotRegisterStates>(
        listener: (context, state) {
          if (state is iotcreatsuccessState) {
            navigateAndFinish(context, BottomNaveScreen());
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                "Register",
                style: GoogleFonts.aclonica(),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    defaultFormField(
                        controller: emailController,
                        label: "Email",
                        type: TextInputType.emailAddress,
                        suffixIcon: Icons.email_outlined),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 25,
                    ),
                    defaultFormField(
                        controller: passwordController,
                        label: "Password",
                        type: TextInputType.visiblePassword,
                        visibility: ioRegiserCubit.get(context).ispassword,
                        suffixIcon: ioRegiserCubit.get(context).ispassword
                            ? Icons.visibility
                            : Icons.visibility_off,
                        onTape: () {
                          ioRegiserCubit.get(context).passwordvisiblity();
                        }),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 25,
                    ),
                    // defaultFormField(
                    //   controller: nameController,
                    //   label: "name",
                    //   type: TextInputType.name,
                    // ),
                    // SizedBox(
                    //   height: MediaQuery.of(context).size.height / 25,
                    // ),
                    // defaultFormField(
                    //   controller: phoneController,
                    //   label: "phone",
                    //   type: TextInputType.phone,
                    //   suffixIcon: Icons.phone,
                    // ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 35,
                    ),
                    ConditionalBuilder(
                        condition: State is! iotRegisterLodingState,
                        builder: (context) => defaultButton(
                            text: "Register",
                            isUpper: true,
                            function: () {
                              if (formKey.currentState!.validate()) {
                                ioRegiserCubit.get(context).userRegister(
                                    // name: nameController.text,
                                    // phone: phoneController.text,
                                    email: emailController.text,
                                    password: passwordController.text);
                              }
                            }),
                        fallback: (context) =>
                            Center(child: CircularProgressIndicator()))
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
