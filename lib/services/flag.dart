import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Flag{
  String countryCode='none';
  Flag({required this.countryCode});
  Future<String> flag_url() async{

    return 'https://flagcdn.com/w320/$countryCode.png';
  }
}