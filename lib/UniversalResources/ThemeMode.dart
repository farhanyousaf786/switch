import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SwitchThemeArea extends StatefulWidget {
  @override
  _SwitchThemeAreaState createState() => _SwitchThemeAreaState();
}

class _SwitchThemeAreaState extends State<SwitchThemeArea> {
  static late String theme;


  @override
  void initState() {
    super.initState();

    getThemeData();
  }

  getThemeData() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (prefs.getString("themeMood") != null) {
      if (prefs.getString("themeMood") == 'dark') {
        prefs.setString("themeMood", "dark");
        print(prefs.getString("themeMood"));
      } else {
        prefs.setString("themeMood", "light");

        print(prefs.getString("themeMood"));
      }
    } else {
      prefs.setString("themeMood", "light");

      print(prefs.getString("themeMood"));
    }


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Container(
          child: GestureDetector(
              onTap: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();

                if (prefs.getString("themeMood") != null) {
                  if (prefs.getString("themeMood") == 'dark') {
                    prefs.setString("themeMood", "dark");
                    print(prefs.getString("themeMood"));
                  } else {
                    prefs.setString("themeMood", "light");

                    print(prefs.getString("themeMood"));
                  }
                } else {
                  prefs.setString("themeMood", "light");

                  print("null =  ${prefs.getString("themeMood")}");
                }
              },
              child: Text(


                  "Change Theme")),
        ));
  }
}
