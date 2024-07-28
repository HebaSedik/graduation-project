import 'package:flutter/material.dart';
// import 'package:alan_voice/alan_voice.dart';
import 'package:firebase_database/firebase_database.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
//   alanVoiceAssistant() {
//     /// Init Alan Button with project key from Alan Studio
//     AlanVoice.addButton(
//         "14623d78ce416b678efdfa60c34a1d4a2e956eca572e1d8b807a3e2338fdd0dc/stage",
//         buttonAlign: AlanVoice.BUTTON_ALIGN_LEFT);

//     /// Handle commands from Alan Studio
//     AlanVoice.onCommand.add((command) => _handleCommand(command.data));
//   }

  void _handleCommand(Map<String, dynamic> command) {
    switch (command['command']) {
      case "open the door":
        homeDoorAsyncState();
        break;
      case "close the door":
        homeDoorAsyncState();
        break;
      case "open the window":
        windowDoorAsyncState();
        break;
      case "close the window":
        windowDoorAsyncState();
        break;
      case "open garden light":
        gardenLightAsyncState();
        break;
      case "close garden light":
        gardenLightAsyncState();
        break;
      default:
        debugPrint('********************************');
    }
  }

  DatabaseReference ref = FirebaseDatabase.instance.ref();

  bool homeDoor = false;
  void homeDoorState() {
    // setState(() {
    //   homeDoor = !homeDoor;
    // });
  }

  void homeDoorAsyncState() async {
    await ref.update({
      "HomeDoor": {"Switch": !homeDoor},
    });
    homeDoorState();
  }

  bool windowDoor = false;
  void windowDoorState() {
    // setState(() {
    //   windowDoor = !windowDoor;
    // });
  }

  void windowDoorAsyncState() async {
    await ref.update({
      "WindowDoor": {"Switch": !windowDoor},
    });
    windowDoorState();
  }

  bool gardenLight = false;
  void gardenLightState() {
    // setState(() {
    //   gardenLight = !gardenLight;
    // });
  }

  void gardenLightAsyncState() async {
    await ref.update({
      "Gardenlight": {"Switch": !gardenLight},
    });
    gardenLightState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(35),
              child: Column(
                children: [
                  Column(
                    children: [
                      Text("Door Alan Switch"),
                      Switch(
                        value: homeDoor,
                        onChanged: (value) {
                          homeDoorAsyncState();
                        },
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text("Window Alan Switch"),
                      Switch(
                        value: windowDoor,
                        onChanged: (value) {
                          windowDoorAsyncState();
                        },
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text("Garden Light"),
                      Switch(
                        value: gardenLight,
                        onChanged: (value) {
                          gardenLightAsyncState();
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // SizedBox(
            //   child: alanVoiceAssistant(),
            // ),
          ],
        ),
      ),
    );
  }
}
