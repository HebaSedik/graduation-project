abstract class iotLoginStates{}

class iotLoginInitialState extends iotLoginStates{}

class visiblitystate extends iotLoginStates{}

class iotLoginLodingState extends iotLoginStates{}

class iotLoginsuccessState extends iotLoginStates{
   final String? uid;
   iotLoginsuccessState(this.uid);
   }

class iotLoginerrorState extends iotLoginStates{}

