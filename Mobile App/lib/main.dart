import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_home_app/business-layer/bloc/cubit.dart';
import 'package:smart_home_app/business-layer/bloc/statas.dart';
import 'firebase_options.dart';
import 'package:smart_home_app/iotLogin/logimscreen.dart';
import 'package:smart_home_app/preseitation-layer/screens/bottomnavScreen.dart';
import 'package:smart_home_app/data-layer/custemshard/shard.dart';
import 'package:smart_home_app/data-layer/shardprefresnses/shardprefrenses.dart';
import 'package:smart_home_app/preseitation-layer/screens/splashscreen.dart';
import 'package:showcaseview/showcaseview.dart';

bool isLoggedIn = false;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ChachHelper.init();
  //  await DioHelper.init();
  await Firebase.initializeApp(
    // name: 'name-here-to-solve-error',
    options: DefaultFirebaseOptions.currentPlatform,
  );

  Widget widget;
  bool? lamp1 = ChachHelper.getData(key: "lamp1state");
  bool? lamp2 = ChachHelper.getData(key: "lamp2State");
  bool? wendo = ChachHelper.getData(key: "wendoState");
  bool? door = ChachHelper.getData(key: "doorState");
  bool? fan = ChachHelper.getData(key: "fanState");
  bool? themmode = ChachHelper.getData(key: "isDark");
  bool? garagelamp = ChachHelper.getData(key: "GarageLampState");
  bool? garagedoor = ChachHelper.getData(key: "GarageDoorState");
  bool? gardenlamp = ChachHelper.getData(key: "GardenLampState");
  // bool? gardencover = ChachHelper.getData(key: "gardencoverstate");

  uid = ChachHelper.Data(key: "uid");

  if (uid != null) {
    widget = BottomNaveScreen();
  } else {
    widget = LoginScreen();
  }

  // if (FirebaseAuth.instance.currentUser != null) {
  //   print('User id : ${FirebaseAuth.instance.currentUser!.uid}');
  //   isLoggedIn = true;
  // } else {
  //   isLoggedIn = false;
  // }
  runApp(MyApp(lamp1, lamp2, fan, door, wendo, themmode, garagelamp, widget,
      gardenlamp, garagedoor));
}

// door,,
class MyApp extends StatelessWidget {
  final bool? lamp1;
  final bool? fan;
  final bool? lamp2;
  final bool? wendo;
  final bool? door;
  final bool? themmode;
  final bool? garagedoor;
  final bool? garagelamp;
  final Widget? startwidget;
  final bool? gardenlamp;
  // final bool? gardencover;

  MyApp(
    this.lamp1,
    this.lamp2,
    this.fan,
    this.door,
    this.wendo,
    this.themmode,
    this.garagelamp,
    this.startwidget,
    // this.gardencover,
    this.gardenlamp,
    this.garagedoor,
  );

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => iotCubit()
              ..Lamp2state(fromshard: lamp2)
              ..Lamp1State(fromshard: lamp1)
              ..Fanstate(fromshard: fan)
              ..Doorstate(fromshard: door)
              ..Wendostate(fromshard: wendo)
              ..Thememode(isDark: themmode)
              ..GarageLamp(GarageLampState: garagelamp)
              // ..Gardencover(gardencoverstate: gardencover)
              ..GardenLamp(GardenLampState: gardenlamp)
              // ..gettemp()
              ..GarageDoor(GarageDoorState: garagedoor)),
      ],
      child: BlocConsumer<iotCubit, iotStates>(
        listener: (context, state) {},
        builder: (context, state) => MaterialApp(
          title: 'IotFlutterTeam',
          debugShowCheckedModeBanner: false,
          theme: MyTheme.ligttheme,
          darkTheme: MyTheme.darktheme,
          themeMode:
              iotCubit.get(context).themmode ? ThemeMode.dark : ThemeMode.light,
          home: ShowCaseWidget(
            builder: Builder(
              //builder: (context) => LoginScreen(),
              builder: (context) => SplashScreen(),
            ),
          ),
        ),
      ),
    );
  }
}
