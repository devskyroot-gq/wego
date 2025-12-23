import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String? id;
  final String name;
  final String surname;
  final String phone;
  final String? email;
  final String username;
  final String password;
  final String? imageUrl;
  final String? userTYpe;

  
  const UserModel( {
    this.id,
    required this.name,
    required this.surname,
    required this.phone,
    this.email,
    required this.username,
    required this.password,
    this.imageUrl, 
    this.userTYpe,
  });

  toJson(){
    return {
      "FirstName": name,
      "LastName": surname,
      "PhoneNumber": phone,
      "Email": email,
      "Username": username,
      "Password": password,
      "ImageUrl": imageUrl,
      "UserType": userTYpe
    };
  }

  //empty construcctor
  factory UserModel.empty() => UserModel(
    name: "",
    surname: "",
    phone: "",
    username: "",
    password: "",
    imageUrl: "",
    userTYpe: ""
  );

  //setting data from firebase to the model
  factory UserModel.fromFirestore(Map<String, dynamic> data){
    return UserModel(
      name: data["FirstName"] ?? "",
      surname: data["LastName"] ?? "",
      phone: data["PhoneNumber"] ?? "",
      email: data["Email"] ?? "",
      username: data["Username"] ?? "",
      password: data["Password"] ?? "",
      imageUrl: data["ImageUrl"] ?? "",
      userTYpe: data["UserType"] ?? ""
    );
  }



}