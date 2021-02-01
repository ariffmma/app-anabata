import 'dart:convert';

import 'package:blogapp/chat/utils/custom_shared_preferences.dart';
import 'package:flutter/material.dart';

class User {
  String id;
  String name;
  String username;
  String company;
  String email;
  String phone;
  String age;
  String domicile;
  String chatId;

  User({
    @required this.id,
    @required this.name,
    @required this.username,
    @required this.company,
    @required this.email,
    @required this.phone,
    @required this.age,
    @required this.domicile,
    this.chatId,
  });

  User.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    name = json['name'];
    username = json['username'];
    company = json['company'];
    email = json['email'];
    phone = json['phone'];
    age = json['age'];
    domicile = json['domicile'];
    chatId = json['chatId'];
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'username': username,
      'company': company,
      'email': email,
      'phone': phone,
      'age': age,
      'domicile': domicile,
    };
  }

  User.fromLocalDatabaseMap(Map<String, dynamic> json) {
    id = json['_id'];
    name = json['name'];
    username = json['username'];
    company = json['company'];
    email = json['email'];
    phone = json['phone'];
    age = json['age'];
    domicile = json['domicile'];
  }

  Map<String, dynamic> toLocalDatabaseMap() {
    Map<String, dynamic> map = {};
    map['_id'] = id;
    map['name'] = name;
    map['username'] = username;
    map['company'] = company;
    map['email'] = email;
    map['phone'] = phone;
    map['age'] = age;
    map['domicile'] = domicile;
    return map;
  }

  @override
  String toString() {
    return '{"_id":"$id","name":"$name","username":"$username","company":"$company","email":"$email","phone":"$phone","age":"$age","domicile":"$domicile"}';
  }
}
