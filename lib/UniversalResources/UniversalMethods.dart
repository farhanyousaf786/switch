import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:switchapp/Models/Constans.dart';

import '../MainPages/Profile/memeProfile/Meme-profile.dart';
import 'DataBaseRefrences.dart';

class UniversalMethods {
  List posts = [];

  Future<List> getUserPostRtd(String uid, int limit) async {
    List followingList = [];

    userFollowingRtd.child(uid).once().then((DataSnapshot dataSnapshot) {
      if (dataSnapshot.value != null) {
        Map data = dataSnapshot.value;
        Map data2;

        data.forEach(
            (index, data) => followingList.add({"key": index, ...data}));

        for (int i = 0; i <= followingList.length; i++) {
          postsRtd
              .child("${followingList[i]['followingId']}")
              .child("usersPost")
              .orderByChild("timestamp")
              .limitToLast(limit)
              .once()
              .then((DataSnapshot dataSnapshot) {
            if (dataSnapshot.value != null) {
              data2 = dataSnapshot.value;

              data2
                  .forEach((index, data) => posts.add({"key": index, ...data}));

              posts.sort((a, b) {
                return a["timestamp"].compareTo(b["timestamp"]);
              });
            }
          });
        }

        return posts;
      } else {
        print("There is no post");
        return posts;
      }
    });
    return posts;
  }

  String shortNumberGenrator(num) {
    if (num > 999 && num < 99999) {
      return "${(num / 1000).toStringAsFixed(1)} K";
    } else if (num > 99999 && num < 999999) {
      return "${(num / 1000).toStringAsFixed(0)} K";
    } else if (num > 999999 && num < 999999999) {
      return "${(num / 1000000).toStringAsFixed(1)} M";
    } else if (num > 999999999) {
      return "${(num / 1000000000).toStringAsFixed(1)} B";
    } else {
      return num.toString();
    }
  }

  Column prizeDistribution() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    "LEVEL ZERO",
                    style: TextStyle(
                      fontSize: 15,
                      fontFamily: 'cute',
                    ),
                  ),
                  SizedBox(
                    child: Lottie.asset(
                      "images/level_images/level_zero.json",
                    ),
                    height: 40,
                    width: 40,
                  ),
                ],
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8),
          child: Row(
            children: [
              Container(
                child: Flexible(
                  child: Text(
                    "Monthly Prize for Level ZERO & Rank # 1 = 1000 pkr",
                    style: TextStyle(
                        color: Colors.grey, fontFamily: 'cute', fontSize: 10),
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8),
          child: Row(
            children: [
              Container(
                child: Flexible(
                  child: Text(
                    "Monthly Prize for Level ZERO & Rank # 2 = 600 pkr",
                    style: TextStyle(
                        color: Colors.grey, fontFamily: 'cute', fontSize: 10),
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8),
          child: Row(
            children: [
              Container(
                child: Flexible(
                  child: Text(
                    "Monthly Prize for Level ZERO & Rank # 3 = 400 pkr",
                    style: TextStyle(
                        color: Colors.grey, fontFamily: 'cute', fontSize: 10),
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    "LEVEL PLANET",
                    style: TextStyle(
                      fontSize: 15,
                      fontFamily: 'cute',
                    ),
                  ),
                  SizedBox(
                    child: Lottie.asset(
                      "images/level_images/level_planet.json",
                    ),
                    height: 40,
                    width: 40,
                  ),
                ],
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8),
          child: Row(
            children: [
              Container(
                child: Flexible(
                  child: Text(
                    "Monthly Prize for Level PLANET & Rank # 1 = 2000 pkr",
                    style: TextStyle(
                        color: Colors.grey, fontFamily: 'cute', fontSize: 10),
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8),
          child: Row(
            children: [
              Container(
                child: Flexible(
                  child: Text(
                    "Monthly Prize for Level PLANET & Rank # 2 = 1200 pkr",
                    style: TextStyle(
                        color: Colors.grey, fontFamily: 'cute', fontSize: 10),
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8),
          child: Row(
            children: [
              Container(
                child: Flexible(
                  child: Text(
                    "Monthly Prize for Level PLANET & Rank # 3 = 800 pkr",
                    style: TextStyle(
                        color: Colors.grey, fontFamily: 'cute', fontSize: 10),
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    "LEVEL SOLAR",
                    style: TextStyle(
                      fontSize: 15,
                      fontFamily: 'cute',
                    ),
                  ),
                  SizedBox(
                    child: Lottie.asset(
                      "images/level_images/solar_level.json",
                    ),
                    height: 40,
                    width: 40,
                  ),
                ],
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8),
          child: Row(
            children: [
              Container(
                child: Flexible(
                  child: Text(
                    "Monthly Prize for Level SOLAR & Rank # 1 = 3000 pkr",
                    style: TextStyle(
                        color: Colors.grey, fontFamily: 'cute', fontSize: 10),
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8),
          child: Row(
            children: [
              Container(
                child: Flexible(
                  child: Text(
                    "Monthly Prize for Level SOLAR & Rank # 2 = 1800 pkr",
                    style: TextStyle(
                        color: Colors.grey, fontFamily: 'cute', fontSize: 10),
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8),
          child: Row(
            children: [
              Container(
                child: Flexible(
                  child: Text(
                    "Monthly Prize for Level SOLAR & Rank # 3 = 1200 pkr",
                    style: TextStyle(
                        color: Colors.grey, fontFamily: 'cute', fontSize: 10),
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    "LEVEL GALAXY",
                    style: TextStyle(
                      fontSize: 15,
                      fontFamily: 'cute',
                    ),
                  ),
                  SizedBox(
                    child: Lottie.asset(
                      "images/level_images/galaxy_level.json",
                    ),
                    height: 40,
                    width: 40,
                  ),
                ],
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8),
          child: Row(
            children: [
              Container(
                child: Flexible(
                  child: Text(
                    "Monthly Prize for Level GALAXY & Rank # 1 = 4000 pkr",
                    style: TextStyle(
                        color: Colors.grey, fontFamily: 'cute', fontSize: 10),
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8),
          child: Row(
            children: [
              Container(
                child: Flexible(
                  child: Text(
                    "Monthly Prize for Level GALAXY & Rank # 2 = 2500 pkr",
                    style: TextStyle(
                        color: Colors.grey, fontFamily: 'cute', fontSize: 10),
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8),
          child: Row(
            children: [
              Container(
                child: Flexible(
                  child: Text(
                    "Monthly Prize for Level GALAXY & Rank # 3 = 2000 pkr",
                    style: TextStyle(
                        color: Colors.grey, fontFamily: 'cute', fontSize: 10),
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Note: Currently, Memers can withdraw prize money through JAZZCASH. Top 3 Memers will be announce every month on front page of Switch App. Memers are Ranked through number of following. So, this is simple formula for Rankings for now.",
            style: TextStyle(
              fontSize: 10,
              fontFamily: 'cutes',
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Future bottomSheetForMemerLevel(BuildContext context) {
    return showModalBottomSheet(
        useRootNavigator: true,
        isScrollControlled: true,
        barrierColor: Colors.red.withOpacity(0.2),
        elevation: 0,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        context: context,
        builder: (context) {
          return Container(
              height: MediaQuery.of(context).size.height / 1.3,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.linear_scale_sharp,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                      color: Colors.blue,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Memer Levels",
                        style: TextStyle(
                          fontSize: 22,
                          fontFamily: 'cute',
                          color: Colors.blue,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "1 - 100 followers = ",
                            style: TextStyle(
                              fontSize: 15,
                              fontFamily: 'cute',
                              color: Colors.blue,
                            ),
                          ),
                          Text(
                            "LEVEL ZERO.",
                            style: TextStyle(
                              fontSize: 12,
                              fontFamily: 'cute',
                              color: Constants.isDark == "true"
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "101 - 1000 followers = ",
                            style: TextStyle(
                              fontSize: 15,
                              fontFamily: 'cute',
                              color: Colors.blue,
                            ),
                          ),
                          Text(
                            "LEVEL PLANET.",
                            style: TextStyle(
                              fontSize: 12,
                              fontFamily: 'cute',
                              color: Constants.isDark == "true"
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "1001 - 10,000 followers = ",
                            style: TextStyle(
                              fontSize: 15,
                              fontFamily: 'cute',
                              color: Colors.blue,
                            ),
                          ),
                          Text(
                            "LEVEL SOLAR.",
                            style: TextStyle(
                              fontSize: 12,
                              fontFamily: 'cute',
                              color: Constants.isDark == "true"
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "10,001 - 100,000 followers = ",
                            style: TextStyle(
                              fontSize: 15,
                              fontFamily: 'cute',
                              color: Colors.blue,
                            ),
                          ),
                          Text(
                            "LEVEL GALAXY.",
                            style: TextStyle(
                              fontSize: 12,
                              fontFamily: 'cute',
                              color: Constants.isDark == "true"
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text(
                        "Monthly Prize Scheme",
                        style: TextStyle(
                            fontSize: 21,
                            fontFamily: 'cute',
                            color: Colors.blue),
                      ),
                    ),
                    universalMethods.prizeDistribution()
                  ],
                ),
              ));
        });
  }

  Future whatsNew(BuildContext context) {
    return showModalBottomSheet(
        useRootNavigator: true,
        isScrollControlled: true,
        barrierColor: Colors.red.withOpacity(0.2),
        elevation: 0,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        context: context,
        builder: (context) {
          return Container(
            height: MediaQuery.of(context).size.height / 2,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.linear_scale_sharp,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                    color: Colors.blue,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Whats New?",
                      style: TextStyle(
                          fontSize: 20,
                          fontFamily: "cute",
                          color: Colors.green.shade700),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8, bottom: 5, top: 5),
                    child: Row(
                      children: [
                        Container(
                            child: Flexible(
                                child: Text(
                          "MEMER's level added:",
                          style: TextStyle(
                              color: Colors.blue,
                              fontFamily: 'cute',
                              fontSize: 17),
                        ))),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Row(
                      children: [
                        Container(
                            child: Flexible(
                                child: Text(
                          "Better levels means better monthly prize.",
                          style: TextStyle(
                              color: Colors.blue.shade700,
                              fontFamily: 'cutes',
                              fontSize: 13),
                        ))),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8, bottom: 5, top: 5),
                    child: Row(
                      children: [
                        Container(
                            child: Flexible(
                                child: Text(
                          "Meme Competition:",
                          style: TextStyle(
                              color: Colors.blue,
                              fontFamily: 'cute',
                              fontSize: 17),
                        ))),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Row(
                      children: [
                        Container(
                          child: Flexible(
                            child: Text(
                              "Now, every user can participate in meme competition, Directly.",
                              style: TextStyle(
                                  color: Colors.blue.shade700,
                                  fontFamily: 'cutes',
                                  fontSize: 13),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8, bottom: 5, top: 5),
                    child: Row(
                      children: [
                        Container(
                            child: Flexible(
                                child: Text(
                          "Monthly prize for top 3 Memers:",
                          style: TextStyle(
                              color: Colors.blue,
                              fontFamily: 'cute',
                              fontSize: 17),
                        ))),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Row(
                      children: [
                        Container(
                            child: Flexible(
                                child: Text(
                          "You can earn monthly prize up to 1500 pkr if you held one of top 3 slot in Switch App as a Memer.",
                          style: TextStyle(
                              color: Colors.blue.shade700,
                              fontFamily: 'cutes',
                              fontSize: 13),
                        ))),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Text(
                        "Version 1.2",
                        style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                            fontSize: 9,
                            fontFamily: 'cutes'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
