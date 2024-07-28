// import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:smart_home_app/bloc/cubit.dart';
// import 'package:smart_home_app/bloc/statas.dart';
// import 'package:smart_home_app/models/usermodel.dart';
// import 'package:smart_home_app/shard/shard.dart';

// class ProfilScreen extends StatelessWidget {
//   TextEditingController passwordController = TextEditingController();
//   TextEditingController nameController = TextEditingController();
//   TextEditingController phoneController = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<iotCubit,iotStates>(
//       listener: (context, state) {
        
//       },
//       builder: (context, state) {
//         var Profilimage = iotCubit.get(context).Profilimage;
//         // var models = iotCubit.get(context).userModel;
        

//         // nameController.text = models!.name!;
//         // phoneController.text = models.phone!;

//         return ConditionalBuilder(
//           condition: models!=null,
//           builder: (context) => Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             SizedBox(height: 90,),
//             Center(
//                 child: Stack(
//                   alignment: Alignment.bottomRight,
//                  children: [
//                    CircleAvatar(
//                     radius: 70,
//                     backgroundImage:Profilimage==null? NetworkImage("${models!.image}"):FileImage(Profilimage) as ImageProvider,
//                           ),
//                     CircleAvatar(
//                       child: IconButton(
//                       onPressed: (){
//                         iotCubit.get(context).getImage();
//                       },
//                        icon: Icon(Icons.camera_alt_outlined)
//                        ),
//                     ),
//                  ],
//                 ),
//             ),
//              SizedBox(height: 30,),
//             defaultFormField(
//               controller: nameController, 
//               label: 'name', 
//               type: TextInputType.name
//               ),
//               SizedBox(height: 30,),
//             defaultFormField(
//               controller: phoneController, 
//               label: 'Phone', 
//               type: TextInputType.phone
//               ),
//                SizedBox(height: 30,),
//             // defaultFormField(
//             //   controller: passwordController, 
//             //   label: 'Password', 
//             //   type: TextInputType.number
//             //   ),
        
//             defaultButton(
//               text: 'Update', 
//               function: (){
//                 iotCubit.get(context).updateuser(nameController.text, phoneController.text);
//               }
//               )
//           ],
//               ),
//           fallback: (context) => Center(child: CircularProgressIndicator()), 
//         );
//       },
       
//     );
//   }
// }