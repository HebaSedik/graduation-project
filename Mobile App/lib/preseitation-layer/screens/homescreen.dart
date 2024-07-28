import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_home_app/business-layer/bloc/cubit.dart';
import 'package:smart_home_app/business-layer/bloc/statas.dart';
import 'package:smart_home_app/preseitation-layer/pages/GaragePage.dart';
import 'package:smart_home_app/preseitation-layer/pages/firstfloorpage.dart';
import 'package:smart_home_app/preseitation-layer/pages/gardenpage.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import '../../data-layer/custemshard/shard.dart';

// ignore: must_be_immutable
class HomeScreen extends StatelessWidget {
  List<dynamic> items = [
    "First Floor",
    "Garden",
    "Garage",
  ];

  List<dynamic> pages = [
    FirstFloorPage(),
    GardenPage(),
    GaragePage(),
  ];

// final ref = FirebaseDatabase.instance.ref().child("DHT11part1");
//   final ref2 = FirebaseDatabase.instance.ref().child("DHT11part2");

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<iotCubit, iotStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                Container(
                  width: 343,
                  height: 226,
                  decoration: BoxDecoration(
                      color: Colors.transparent.withOpacity(0.4),
                      borderRadius: BorderRadius.circular(22)),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Home Temperature',
                          style: TextStyle(
                              fontSize: 24,
                              color: Color(0xFFE1E1E1),
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 50,
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              Expanded(
                                child: FirebaseAnimatedList(
                                  query: iotCubit.get(context).ref,
                                  itemBuilder:
                                      (context, snapshot, animation, index) {
                                    return SleekCircularSlider(
                                      appearance: CircularSliderAppearance(
                                          customWidths: CustomSliderWidths(
                                              trackWidth: 4,
                                              progressBarWidth: 20,
                                              shadowWidth: 40),
                                          customColors: CustomSliderColors(
                                              trackColor: HexColor('##ea1010'),
                                              progressBarColor:
                                                  HexColor('##ea1010'),
                                              shadowColor: HexColor('##ea1010'),
                                              shadowMaxOpacity: 0.5, //);
                                              shadowStep: 20),
                                          infoProperties: InfoProperties(
                                              bottomLabelStyle: TextStyle(
                                                  fontSize: 15,
                                                  color: Color(0xFFE1E1E1),
                                                  fontFamily: "Poppins",
                                                  fontWeight: FontWeight.w600),
                                              bottomLabelText: 'Temp',
                                              mainLabelStyle: TextStyle(
                                                  fontSize: 24,
                                                  color: Color(0xFFE1E1E1),
                                                  fontFamily: "Poppins",
                                                  fontWeight: FontWeight.w600),
                                              modifier: (double value) {
                                                return '${snapshot.value.toString()} ˚C';
                                              }),
                                          startAngle: 90,
                                          angleRange: 360,
                                          size: 150.0,
                                          animationEnabled: true),
                                      min: 0,
                                      max: 100,
                                      initialValue: double.parse(
                                          snapshot.value.toString()),
                                    );
                                  },
                                ),
                              ),
                              Expanded(
                                child: FirebaseAnimatedList(
                                    query: iotCubit.get(context).ref2,
                                    itemBuilder:
                                        (context, snapshot, animation, index) {
                                      return SleekCircularSlider(
                                        appearance: CircularSliderAppearance(
                                            customWidths: CustomSliderWidths(
                                                trackWidth: 4,
                                                progressBarWidth: 20,
                                                shadowWidth: 40),
                                            customColors: CustomSliderColors(
                                                trackColor: HexColor('#0277bd'),
                                                progressBarColor:
                                                    HexColor('#4FC3F7'),
                                                shadowColor:
                                                    HexColor('#B2EBF2'),
                                                shadowMaxOpacity: 0.5, //);
                                                shadowStep: 20),
                                            infoProperties: InfoProperties(
                                                bottomLabelStyle: TextStyle(
                                                    fontSize: 15,
                                                    color: Color(0xFFE1E1E1),
                                                    fontFamily: "Poppins",
                                                    fontWeight:
                                                        FontWeight.w600),
                                                bottomLabelText: 'Humidity',
                                                mainLabelStyle: TextStyle(
                                                    fontSize: 24,
                                                    color: Color(0xFFE1E1E1),
                                                    fontFamily: "Poppins",
                                                    fontWeight:
                                                        FontWeight.w600),
                                                modifier: (double value) {
                                                  return '${snapshot.value.toString()} %';
                                                }),
                                            startAngle: 90,
                                            angleRange: 360,
                                            size: 150.0,
                                            animationEnabled: true),
                                        min: 0,
                                        max: 100,
                                        initialValue: double.parse(
                                            snapshot.value.toString()),
                                      );
                                    }),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 9,
                  width: double.infinity,
                  //علشان اعرض الايتم بشكل تلقائي
                  child: ListView.builder(
                      physics: BouncingScrollPhysics(),
                      itemCount: items.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            //علشان اقدر ادوس عليها
                            GestureDetector(
                              onTap: () {
                                iotCubit.get(context).changepages(index);
                              },
                              //دا الشكل الي انا استلمت فيه الايتم من اللست
                              child: Container(
                                margin: EdgeInsets.symmetric(
                                    vertical: 12,
                                    horizontal:
                                        MediaQuery.of(context).size.width / 32),
                                width: MediaQuery.of(context).size.width / 4,
                                height: MediaQuery.of(context).size.height / 16,
                                decoration: BoxDecoration(
                                    color: iotCubit.get(context).curntindex ==
                                            index
                                        ? Color(0xFF589AFF)
                                        : Colors.transparent.withOpacity(.5),
                                    borderRadius:
                                        iotCubit.get(context).curntindex ==
                                                index
                                            ? BorderRadius.circular(15)
                                            : BorderRadius.circular(15),
                                    //داالبوردر الخارجي للكونتينر
                                    border: iotCubit.get(context).curntindex ==
                                            index
                                        ? Border.all(
                                            color: Colors.black, width: 2)
                                        : null),
                                child: Center(
                                  child: Text(
                                    items[index],
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: Color(0xFFF5F5F5),
                                        fontFamily: "Poppins",
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ),
                            ),
                            //هنا علشان اعمل النقطه الي تحت الكونتينر
                            Visibility(
                                visible:
                                    iotCubit.get(context).curntindex == index,
                                child: Container(
                                  width: 5,
                                  height: 5,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.grey,
                                  ),
                                ))
                          ],
                        );
                      }),
                ),
                //دا بقي الكونتينر الي انا بستلم فيه الصفح بتاع كل ايتم
                Container(
                  margin: EdgeInsets.only(top: 30),
                  width: double.infinity,
                  height: 700,
                  child: pages[iotCubit.get(context).curntindex],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
