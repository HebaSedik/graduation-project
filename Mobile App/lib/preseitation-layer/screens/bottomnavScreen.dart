import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_home_app/business-layer/bloc/cubit.dart';
import 'package:smart_home_app/business-layer/bloc/statas.dart';
import 'package:smart_home_app/abdullah/home.dart';

import 'package:smart_home_app/preseitation-layer/screens/homescreen.dart';
import 'package:smart_home_app/preseitation-layer/screens/safteyscreen.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class BottomNaveScreen extends StatelessWidget {
  List<dynamic> screens = [
    // ProfilScreen(),
    HomeScreen(),
    SecurityScreen(),
    //Home(),
  ];
  var date = DateFormat('dd/MM/yyyy').format(DateTime.now());
  var time = DateFormat('KK:mm:ss a').format(DateTime.now());

  IconData iconlight = Icons.light_mode_outlined;
  IconData iconDark = Icons.dark_mode_outlined;

  DatabaseReference ref = FirebaseDatabase.instance.ref();

  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocConsumer<iotCubit, iotStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFF4D6689), Color(0xFF1D1930)])),
            child: Scaffold(
              backgroundColor: Colors.transparent,
              body: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Welcome',
                                style: TextStyle(
                                    fontSize: 26,
                                    color: Colors.white,
                                    fontFamily: "Poppins",
                                    fontStyle: FontStyle.italic,
                                    fontWeight: FontWeight.w600),
                              ),
                              Text(
                                '$date',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Color(0xFFB0AFAF),
                                  fontStyle: FontStyle.italic,
                                  fontFamily: "Poppins",
                                ),
                              ),
                              // Text('${time}',style: GoogleFonts.aclonica(
                              //   fontSize: 20,
                              //     fontWeight: FontWeight.bold
                              // ),),
                            ],
                          ),
                          Spacer(),
                          IconButton(
                            onPressed: () {
                              iotCubit.get(context).Thememode();
                            },
                            icon: Icon(
                              iotCubit.get(context).themmode
                                  ? iconDark
                                  : iconlight,
                            ),
                            iconSize: 35,
                          )
                        ],
                      ),
                    ),
                    // SizedBox(
                    //   height: MediaQuery.of(context).size.height / 40,
                    // ),
                    screens[iotCubit.get(context).curntscreen],
                    // SizedBox(
                    //   child:iotCubit.get(context).alanVoiceAssistant() ,
                    // )
                  ],
                ),
              ),
              bottomNavigationBar: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0), // Adjust the radius as needed
                  topRight: Radius.circular(20.0),
                ), // Adjust the radius as needed

                child: BottomNavigationBar(
                  backgroundColor: Colors.transparent.withOpacity(0.5),
                  currentIndex: iotCubit.get(context).curntscreen,
                  onTap: (index) {
                    iotCubit.get(context).changebottomvav(index);
                  },
                  type: BottomNavigationBarType.fixed,
                  items: [
                    // BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile',),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.home), label: 'Home'),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.security), label: 'Safety'),
                    // BottomNavigationBarItem(
                    //     icon: Icon(Icons.record_voice_over_outlined),
                    //     label: 'Alan'),
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
