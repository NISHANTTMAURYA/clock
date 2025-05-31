import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:clock_app/services/anim_clock_with_loader.dart';
import 'package:clock_app/services/clock.dart';
import 'package:clock_app/services/get_ip.dart';
import 'package:clock_app/services/flag.dart';
import 'package:animated_analog_clock/animated_analog_clock.dart';
import 'package:cached_network_image/cached_network_image.dart';

class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  String timezone='none';
  String date='none';
  String day='none';
  String time='none';
  String countryCode='';
  String timezone_prefix = '';
  String timezone_suffix = '';
  String url = '';

  void setupWorldTime() async{
    WorldTime instance = WorldTime(timezone_prefix: timezone_prefix,timezone_suffix:timezone_suffix);
    await instance.getTime();
    setState(() {

      date = instance.date;
      day = instance.day;
      time = instance.time;
    });


}
void setupFlag() async{

}
  void get_country_code() async{
    GetIp userData =  GetIp();
    await userData.getIp();
    timezone=userData.timezone;
    countryCode=userData.countryCode.toLowerCase();
    Flag flag = Flag(countryCode: countryCode);
    String flag_urll = await flag.flag_url();
    setState(() {
      print(flag_urll);
      url=flag_urll;

    });
    List<String> parts = timezone.split('/');


    timezone_prefix = parts.length > 0 ? parts[0] : 'none';
    timezone_suffix = parts.length > 1 ? parts[1] : 'none';
    setupWorldTime();


  }
  @override
  void initState() {
    super.initState();
    get_country_code();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "WORLD CLOCK ",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 40,
            fontFamily: 'freedom',
            letterSpacing: 2,
          ),
        ),
        backgroundColor: Colors.lightBlue,
        elevation: 4.0,
      ),
      backgroundColor: Colors.grey[100],
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.max,
            children: [
              Card(
                elevation: 4.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Flexible(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            AutoSizeText(
                              "TIMEZONE",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 30,
                                fontFamily: 'freedom',
                                letterSpacing: 2,
                              ),
                              textAlign: TextAlign.center,
                              maxLines: 1,
                            ),
                            SizedBox(height: 8),
                            AutoSizeText(
                              timezone,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 40,
                                letterSpacing: 1,
                                fontFamily: 'freedom',
                                height: 0.9,
                              ),
                              textAlign: TextAlign.center,
                              maxLines: 2,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 16),
                      url.isNotEmpty
                          ? ClockWithCachedImage(imageUrl: url)
                          : SizedBox(
                        width: 100,
                        height: 100,
                        child: Image.asset('assets/loader.gif'),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 24),
              Card(
                elevation: 4.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      AutoSizeText(
                        'Current Date - $date',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 40,
                          letterSpacing: 1,
                          fontFamily: 'freedom',
                          height: 1,
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 1,
                      ),
                      SizedBox(height: 16),
                      AutoSizeText(
                        'Current Day - $day',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 40,
                          letterSpacing: 1,
                          fontFamily: 'freedom',
                          height: 1,
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 1,
                      ),
                      SizedBox(height: 16),
                      AutoSizeText(
                        'Current time - $time',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 40,
                          letterSpacing: 1,
                          fontFamily: 'freedom',
                          height: 1,
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 1,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}




