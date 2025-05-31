import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class GetIp {
  final String url = 'http://ip-api.com/json';
  String timezone='none';
  String countryCode='none';


  Future<void> getIp() async {
    try {
      http.Response response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        Map<String, dynamic> ipData = jsonDecode(response.body);

        this.countryCode=ipData['countryCode'];
        this.timezone=ipData['timezone'];
        print('Timezone: $timezone');
      } else {
        print('Failed to fetch data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }
}
