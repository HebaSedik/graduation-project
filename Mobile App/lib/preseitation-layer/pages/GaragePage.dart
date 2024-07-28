import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_home_app/business-layer/bloc/cubit.dart';
import 'package:smart_home_app/business-layer/bloc/statas.dart';
import '../../data-layer/custemshard/shard.dart';

// ignore: must_be_immutable
class GaragePage extends StatelessWidget {
  @override
  // ignore: override_on_non_overriding_member
  DatabaseReference ref = FirebaseDatabase.instance.ref();

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
              if (firebaseData != null && firebaseData['GarageLight'] != null) {
                iotCubit.get(context).GarageLamp(
                    GarageLampState: firebaseData['GarageLight']!['Switch']);
              }

              if (firebaseData != null && firebaseData['GarageDoor'] != null) {
                iotCubit.get(context).GarageDoor(
                    GarageDoorState: firebaseData['GarageDoor']['Switch']);
              }
            }

            // Build the UI
            return Column(
              children: [
                Row(
                  children: [
                    ElectricItem(context,
                        imagoff: "assets/lampoff.png",
                        imagon: "assets/lampon.png",
                        nam: "Lights",
                        value: iotCubit.get(context).garagelamp, fun: () async {
                      iotCubit.get(context).GarageLamp();
                      await ref.update({
                        "GarageLight": {
                          "Switch": iotCubit.get(context).garagelamp
                        },
                      });
                    }),
                    Spacer(),
                    ElectricItem(context,
                        imagoff: "assets/garageoff.png",
                        imagon: "assets/garageon.png",
                        nam: "Door",
                        value: iotCubit.get(context).garagedoor, fun: () async {
                      print(iotCubit.get(context).garagedoor);
                      iotCubit.get(context).GarageDoor();
                      await ref.update({
                        "GarageDoor": {
                          "Switch": iotCubit.get(context).garagedoor
                        },
                      });
                    }),
                  ],
                ),
              ],
            );
          },
        );
      },
    );
  }
}
