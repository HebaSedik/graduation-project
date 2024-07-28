class UserModel{
  String? name;
  String? email;
  String? phone;
  String? uid;
  String? image;


  UserModel({
     this.email,
     this.name,
     this.phone,
     this.uid,
     this.image
  });


UserModel.fromJson(Map<String,dynamic>json){
  email=json['email'];
  name=json['name'];
  phone=json['phone'];
  uid=json['uid'];
  image=json['image'];
}

Map<String,dynamic> toMap(){
  return{
    'email':email,
    'name':name,
    'phone':phone,
    'uid':uid,
    'image':image,
  };
}


}