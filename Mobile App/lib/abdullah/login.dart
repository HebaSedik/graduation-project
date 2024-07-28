import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smart_home_app/preseitation-layer/screens/bottomnavScreen.dart';

class LogIn extends StatefulWidget {
  const LogIn({Key? key}) : super(key: key);

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  final formKey = GlobalKey<FormState>();

  TextEditingController secretKeyController = TextEditingController();
  String email = 'iotflutterteam@gmail.com', secretKey = '123456';

  Future logIn() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();

      try {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => BottomNaveScreen(),
        ));
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          print('No user found for that email.');

          AwesomeDialog(
            context: context,
            dialogType: DialogType.error,
            animType: AnimType.leftSlide,
            title: 'Error',
            desc: 'No user found for that email',
            btnOkOnPress: () {},
          ).show();
        } else if (e.code == 'wrong-password') {
          print('Wrong password provided for that user.');
          AwesomeDialog(
            context: context,
            dialogType: DialogType.info,
            animType: AnimType.leftSlide,
            title: 'Information',
            desc: 'Wrong password provided for that user',
            btnOkOnPress: () {},
          ).show();
        }
      }
    } else {
      print('Invalid');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 60),

                // Password
                customTextField(
                    label: 'Enter Secret Key',
                    onsave: (val) {
                      secretKey = val;
                    },
                    obscure: true,
                    validator: (val) {
                      print(val);
                      if (val!.isEmpty) {
                        return 'Password Can\'t be Empty';
                      } else {
                        return null;
                      }
                    },
                    controller: secretKeyController),
                const SizedBox(height: 40),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton.icon(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.indigo)),
                    onPressed: () {
                      logIn();
                    },
                    icon: const Icon(Icons.login),
                    label: const Text('Connect'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget customTextField(
      {required String label,
      required Function validator,
      required TextEditingController controller,
      required bool obscure,
      required Function onsave}) {
    return TextFormField(
      controller: controller,
      onSaved: (val) => onsave(val),
      validator: (val) => validator(val),
      obscureText: obscure,
      decoration: InputDecoration(
        filled: true,
        label: Text(label),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: Colors.redAccent, width: 2),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: Colors.black, width: 2),
        ),
      ),
    );
  }
}
