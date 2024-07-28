// import 'package:alan_voice/alan_voice.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_home_app/business-layer/bloc/cubit.dart';
import 'package:smart_home_app/business-layer/bloc/statas.dart';
import 'package:smart_home_app/data-layer/custemshard/shard.dart';

// ignore: must_be_immutable
class FirstFloorPage extends StatelessWidget {
  DatabaseReference ref = FirebaseDatabase.instance.ref();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<iotCubit, iotStates>(
        listener: (context, state) {},
        builder: (context, state) {
          // Use StreamBuilder to listen to changes in Firebase
          return StreamBuilder(
            stream: ref.onValue,
            builder: (context, snapshot) {
              // Check if snapshot has data
              if (snapshot.hasData) {
                // Get the value from the snapshot
                Map<dynamic, dynamic>? firebaseData =
                    snapshot.data!.snapshot.value as Map<dynamic, dynamic>?;

                // Update the state of electric items based on the values from Firebase
                if (firebaseData != null &&
                    firebaseData['Homelightred'] != null) {
                  iotCubit.get(context).Lamp1State(
                      fromshard: firebaseData['Homelightred']!['Switch']);
                }

                if (firebaseData != null && firebaseData['HomeDoor'] != null) {
                  iotCubit
                      .get(context)
                      .Doorstate(fromshard: firebaseData['HomeDoor']['Switch']);
                }

                if (firebaseData != null && firebaseData['FanState'] != null) {
                  iotCubit
                      .get(context)
                      .Fanstate(fromshard: firebaseData['FanState']['Switch']);
                }

                if (firebaseData != null &&
                    firebaseData['Homelightyellow'] != null) {
                  iotCubit.get(context).Lamp2state(
                      fromshard: firebaseData['Homelightyellow']['Switch']);
                }
                if (firebaseData != null &&
                    firebaseData['WindowDoor'] != null) {
                  iotCubit.get(context).Wendostate(
                      fromshard: firebaseData['WindowDoor']['Switch']);
                }
              }

              // Build the UI
              return Column(
                children: [
                  // SizedBox(
                  //   child: _MyHomePageState(),
                  // ),
                  Row(
                    children: [
                      ElectricItem(context,
                          imagoff: "assets/lampoff.png",
                          imagon: "assets/lampon.png",
                          nam: "Living",
                          value: iotCubit.get(context).lamp1, fun: () async {
                        iotCubit.get(context).Lamp1State();
                        await ref.update({
                          "Homelightred": {
                            "Switch": iotCubit.get(context).lamp1
                          },
                        });
                      }),
                      Spacer(),
                      ElectricItem(context,
                          imagoff: "assets/dooroff.png",
                          imagon: "assets/dooron.png",
                          nam: "Door",
                          value: iotCubit.get(context).door, fun: () async {
                        print(iotCubit.get(context).door);
                        iotCubit.get(context).Doorstate();
                        // iotCubit.get(context).handleCommand("")
                        await ref.update({
                          "HomeDoor": {"Switch": iotCubit.get(context).door}
                        });
                      }),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 40,
                  ),
                  Row(
                    children: [
                      ElectricItem(context,
                          imagoff: "assets/fanoff.png",
                          imagon: "assets/fanon.png",
                          nam: "Fan",
                          value: iotCubit.get(context).fan, fun: () async {
                        iotCubit.get(context).Fanstate();
                        await ref.update({
                          "FanState": {"Switch": iotCubit.get(context).fan},
                        });
                      }),
                      Spacer(),
                      ElectricItem(context,
                          imagoff: "assets/lampoff.png",
                          imagon: "assets/lampon.png",
                          nam: "Bathroom",
                          value: iotCubit.get(context).lamp2, fun: () async {
                        iotCubit.get(context).Lamp2state();
                        await ref.update({
                          "Homelightyellow": {
                            "Switch": iotCubit.get(context).lamp2
                          },
                        });
                      }),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 40,
                  ),
                  ElectricItem(context,
                      imagoff: "assets/windooff.png",
                      imagon: "assets/windoon.png",
                      nam: "Window",
                      value: iotCubit.get(context).wendo, fun: () async {
                    print(iotCubit.get(context).wendo);
                    iotCubit.get(context).Wendostate();
                    await ref.update({
                      "WindowDoor": {"Switch": iotCubit.get(context).wendo},
                    });
                  }),
                ],
              );
            },
          );
        });
  }
}



//=================================================================

// // ignore: must_be_immutable
// class FirstFloorPage extends StatelessWidget {
//   DatabaseReference ref = FirebaseDatabase.instance.ref();

//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<iotCubit, iotStates>(
//       listener: (context, state) {},
//       builder: (context, state) {
//         // Access the current state of the lamp1 from the iotCubit
//         bool lamp1State = iotCubit.get(context).lamp1;

//         // Use StreamBuilder to listen to changes in Firebase
//         return StreamBuilder(
//           stream: ref.child("Homelightred/Switch").onValue,
//           builder: (context, snapshot) {
//             // Check if snapshot has data
//             if (snapshot.hasData) {
//               // Get the value from the snapshot
//               bool? firebaseValue = snapshot.data!.snapshot.value as bool?;

//               // Update the state of the lamp1 based on the value from Firebase
//               iotCubit.get(context).Lamp1State(fromshard: firebaseValue);
//             }

//             // Build the UI
//             return Column(
//               children: [
//                 Row(
//                   children: [
//                     ElectricItem(
//                       context,
//                       imagoff: "assets/lampoff.png",
//                       imagon: "assets/lampon.png",
//                       nam: "Living",
//                       value: lamp1State,
//                       fun: () async {
//                         // Toggle the state of the lamp1 and update Firebase
//                         iotCubit.get(context).Lamp1State();
//                         await ref.update({
//                           "Homelightred": {"Switch": lamp1State},
//                         });
//                       },
//                     ),
//                     Spacer(),
//                     // Add more ElectricItems here if needed
//                   ],
//                 ),
//               ],
//             );
//           },
//         );
//       },
//     );
//   }
// }


//****************************************************** */

// // ignore: must_be_immutable
// class FirstFloorPage extends StatelessWidget {
//   DatabaseReference ref = FirebaseDatabase.instance.ref();

//   // _MyHomePageState() {
//   //   /// Init Alan Button with project key from Alan Studio
//   //   AlanVoice.addButton(
//   //       "b0f4baae50d1033ab6d8f9ca0e8d979b2e956eca572e1d8b807a3e2338fdd0dc/stage",
//   //       buttonAlign: AlanVoice.BUTTON_ALIGN_LEFT);

//   //   /// Handle commands from Alan Studio
//   //   AlanVoice.onCommand.add((command) => handleCommand(command.data));
//   // }

//   // void handleCommand(dynamic command) {
//   //   switch (command["command"]) {
//   //     case "open the door":
//   //       print('dddddddddddd');
//   //       iotCubit.get(command).Doorstate();
//   //       print('ssssssssssssssssssss');
//   //       break;
//   //     case "close the door":
//   //       iotCubit.get(command).Doorstate();
//   //       break;
//   //     default:
//   //     // debugPrint("UnKnown command");
//   //   }
//   // }

//   Widget build(BuildContext context) {
//     return BlocConsumer<iotCubit, iotStates>(
//       listener: (context, state) {},
//       builder: (context, state) {
//         return Column(
//           children: [
//             // SizedBox(
//             //   child: _MyHomePageState(),
//             // ),
//             Row(
//               children: [
//                 ElectricItem(context,
//                     imagoff: "assets/lampoff.png",
//                     imagon: "assets/lampon.png",
//                     nam: "Living",
//                     value: iotCubit.get(context).lamp1, fun: () async {
//                   iotCubit.get(context).Lamp1State();
//                   await ref.update({
//                     "Homelightred": {"Switch": iotCubit.get(context).lamp1},
//                   });
//                 }),
//                 Spacer(),
//                 ElectricItem(context,
//                     imagoff: "assets/dooroff.png",
//                     imagon: "assets/dooron.png",
//                     nam: "Door",
//                     value: iotCubit.get(context).door, fun: () async {
//                   print(iotCubit.get(context).door);
//                   iotCubit.get(context).Doorstate();
//                   // iotCubit.get(context).handleCommand("")
//                   await ref.update({
//                     "HomeDoor": {"Switch": iotCubit.get(context).door}
//                   });
//                 }),
//               ],
//             ),
//             SizedBox(
//               height: MediaQuery.of(context).size.height / 40,
//             ),
//             Row(
//               children: [
//                 ElectricItem(context,
//                     imagoff: "assets/fanoff.png",
//                     imagon: "assets/fanon.png",
//                     nam: "Fan",
//                     value: iotCubit.get(context).fan, fun: () async {
//                   iotCubit.get(context).Fanstate();
//                   await ref.update({
//                     "FanState": {"Switch": iotCubit.get(context).fan},
//                   });
//                 }),
//                 Spacer(),
//                 ElectricItem(context,
//                     imagoff: "assets/lampoff.png",
//                     imagon: "assets/lampon.png",
//                     nam: "Bathroom",
//                     value: iotCubit.get(context).lamp2, fun: () async {
//                   iotCubit.get(context).Lamp2state();
//                   await ref.update({
//                     "Homelightyellow": {"Switch": iotCubit.get(context).lamp2},
//                   });
//                 }),
//               ],
//             ),
//             SizedBox(
//               height: MediaQuery.of(context).size.height / 40,
//             ),
//             ElectricItem(context,
//                 imagoff: "assets/windooff.png",
//                 imagon: "assets/windoon.png",
//                 nam: "Window",
//                 value: iotCubit.get(context).wendo, fun: () async {
//               print(iotCubit.get(context).wendo);
//               iotCubit.get(context).Wendostate();
//               await ref.update({
//                 "WindowDoor": {"Switch": iotCubit.get(context).wendo},
//               });
//             }),
//           ],
//         );
//       },
//     );
//   }
// }
