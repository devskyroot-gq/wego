import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_pss/core/theme/app_colors.dart';
import 'package:demo_pss/data/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
/*
   *
   * Perform database operations from firebase
   * 
*/
//allow to call this class across this instance any place
ValueNotifier<UserRepository> authService = ValueNotifier(UserRepository());

class UserRepository extends GetxController {
  //firebase auth instance
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  //repository instance
  static UserRepository get instance => Get.find();
  //current user 
  User? get currentUser => firebaseAuth.currentUser;
  //state
  Stream<User?> get authStateChanges => firebaseAuth.authStateChanges();

  final db = FirebaseFirestore.instance;

  //set user type
  Future<void> setUserType(String userType) async{
    try {
      User? user = firebaseAuth.currentUser;
      await db.collection("Users").doc(user?.uid)
        .set(({
          "UserType": userType
        }), 
        SetOptions(merge: true)
        );
        print("User type set successfully: $userType");
    } catch (e) {
      print("ERROR: $e");
    }
  }


  //create account
  Future<User?> signUp(UserModel userModel) async{
    try {
      //creating user in firebase auth
      UserCredential userCredential = await firebaseAuth.createUserWithEmailAndPassword(email: userModel.email!, password: userModel.password);
      User? user = userCredential.user;
      //store data if user creation succeed
      if(user != null){
        await db.collection("Users").doc(user.uid).set(
          userModel.toJson()
        );
      }
      return user;
    } on FirebaseAuthException catch (e) {
      print("ERROR: ${e.code} ${e.message}");
      return null;
    }
  }

  //sign with custom email and password
  Future<void> signIn({
    required String email,
    required String password
  }) async{
    await firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
  }

    //get the current user data from firestore
  Future<UserModel> getCurrentUserData() async{
    try {
      User? user = firebaseAuth.currentUser;
      DocumentSnapshot snapshot =
          await db.collection("Users").doc(user?.uid).get();
      if (snapshot.exists) {
        return UserModel.fromFirestore(snapshot.data() as Map<String, dynamic>);
      } else {
        return UserModel.empty();
      }
    } catch (e) {
      print("ERROR: $e");
      return UserModel.empty();
    }
  }

  //get user stream: for real time updates
  Stream<Map<String, dynamic>?> userStream() {
    final user = firebaseAuth.currentUser;
    if (user == null) return const Stream.empty();

    return db
        .collection("Users")
        .doc(user.uid)
        .snapshots()
        .map((snapshot) => snapshot.data());
  }

  //get the current user data from firestore
  Future<UserModel> signByPhoneAndPassword(String phone, String password) async{
    try {
      final snapshot =
          await db.collection("Users").where("PhoneNumber", isEqualTo: phone).where("Password", isEqualTo: password).get();
      
      if (snapshot.docs.isNotEmpty) {
        return UserModel.fromFirestore(snapshot.docs.first.data());
      } else {
        return UserModel.empty();
      }
    } catch (e) {
      print("ERROR: $e");
      return UserModel.empty();
    }
  }


}