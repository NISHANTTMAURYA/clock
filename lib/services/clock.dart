import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class WorldTime {
  String timezone_prefix = '';
  String timezone_suffix = '';
  String timezone='none';
  String date='none';
  String day='none';
  String time='none';
  String get url {
    return 'https://timeapi.io/api/time/current/zone?timeZone=$timezone_prefix%2F$timezone_suffix';
  }
WorldTime({required this.timezone_prefix, required this.timezone_suffix});
  Future<void> getTime() async {
    try {
      http.Response response = await http.get(Uri.parse(url));
      Map time_data = jsonDecode(response.body);

      
      this.date = time_data['date'];
      this.day = time_data['dayOfWeek'];
      this.time = time_data['time'];
    } catch (e) {
      print(e);
    }
  }
}
