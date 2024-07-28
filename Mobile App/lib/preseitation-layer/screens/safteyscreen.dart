import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_home_app/business-layer/bloc/cubit.dart';
import 'package:smart_home_app/business-layer/bloc/statas.dart';
import 'package:smart_home_app/data-layer/custemshard/shard.dart';

// ignore: must_be_immutable
class SecurityScreen extends StatelessWidget {
  DatabaseReference ref = FirebaseDatabase.instance.ref();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<iotCubit, iotStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SafteyItem(context,
                  text: 'Close All Doors',
                  value: iotCubit.get(context).doors, fun: () async {
                iotCubit.get(context).closedoors();
                await ref.update({
                  "HomeDoor": {"Switch": iotCubit.get(context).door}
                });
                await ref.update({
                  "WindowDoor": {"Switch": iotCubit.get(context).wendo},
                });
                await ref.update({
                  "GarageDoor": {"Switch": iotCubit.get(context).garagedoor},
                });
              }),
              SafteyItem(context,
                  text: 'Turn Off All Electrical Devices',
                  value: iotCubit.get(context).electric, fun: () async {
                iotCubit.get(context).closeAllelecric();
                await ref.update({
                  "Homelightred": {"Switch": iotCubit.get(context).lamp1},
                });
                await ref.update({
                  "Homelightyellow": {"Switch": iotCubit.get(context).lamp2},
                });
                await ref.update({
                  "FanState": {"Switch": iotCubit.get(context).fan},
                });
                await ref.update({
                  "Gardenlight": {"Switch": iotCubit.get(context).gardenlamp},
                });
                await ref.update({
                  "GarageLight": {"Switch": iotCubit.get(context).garagelamp},
                });
              }),
              // SafteyItem(
              // text: 'Close All Windoes',
              // value:iotCubit.get(context).doors ,
              // fun: (){
              //   // iotCubit.get(context).closedoors();
              // }
              // ),
              SafteyItem(context,
                  text: 'Close All Home',
                  value: iotCubit.get(context).allhome, fun: () async {
                iotCubit.get(context).closeAllHome();
                await ref.update({
                  "HomeDoor": {"Switch": iotCubit.get(context).door}
                });
                await ref.update({
                  "WindowDoor": {"Switch": iotCubit.get(context).wendo},
                });
                await ref.update({
                  "GarageDoor": {"Switch": iotCubit.get(context).garagedoor},
                });
                await ref.update({
                  "Homelightred": {"Switch": iotCubit.get(context).lamp1},
                });
                await ref.update({
                  "Homelightyellow": {"Switch": iotCubit.get(context).lamp2},
                });
                await ref.update({
                  "FanState": {"Switch": iotCubit.get(context).fan},
                });
                await ref.update({
                  "Gardenlight": {"Switch": iotCubit.get(context).gardenlamp},
                });
                await ref.update({
                  "GarageLight": {"Switch": iotCubit.get(context).garagelamp},
                });
              })
            ],
          ),
        );
      },
    );
  }
}
