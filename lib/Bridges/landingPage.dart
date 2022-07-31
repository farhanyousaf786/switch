import 'dart:io';

import 'package:delayed_display/delayed_display.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:rive/rive.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:switchapp/Authentication/Auth.dart';
import 'package:switchapp/Authentication/SignIn/SignInPage.dart';
import 'package:switchapp/Authentication/SignUp/emailVerification.dart';
import 'package:switchapp/Bridges/bridgeToNavgation.dart';
import 'package:switchapp/Bridges/bridgeToSetEmailVerification.dart';
import 'package:switchapp/MainPages/NavigationBar/NavigationBar.dart';
import 'package:switchapp/Models/Constans.dart';
import 'package:switchapp/Models/need_help/need_help_page.dart';
import 'package:switchapp/UniversalResources/DataBaseRefrences.dart';

import '../Authentication/userAgreementPage.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();

    _setNotificationCounter();

    intro();
  }

  intro() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    /// this intro is for main feed page
    if (prefs.getInt("intro") == null) {
      prefs.setInt("intro", 0);

      print("intro: ${prefs.getInt("intro")}");

      Constants.isIntro = "true";
    } else {
      if (prefs.getInt("intro")! <= 0) {
        print("intro: ${prefs.getInt("intro")}");
        Constants.isIntro = "true";
      } else {
        print("intro: ${prefs.getInt("intro")}");
        Constants.isIntro = "false";
      }
      //  followSwitchId();
      // bottomSheetForFollowing();
    }

    /// this intro is for Meme Profile page
    if (prefs.getInt("introForMemeProfile") == null) {
      prefs.setInt("introForMemeProfile", 0);

      print("introForMemeProfile: ${prefs.getInt("introForMemeProfile")}");

      Constants.isIntroForMemeProfile = "true";
    } else {
      if (prefs.getInt("introForMemeProfile")! <= 0) {
        print("introForMemeProfile: ${prefs.getInt("introForMemeProfile")}");
        Constants.isIntroForMemeProfile = "true";
      } else {
        print("introForMemeProfile: ${prefs.getInt("introForMemeProfile")}");
        Constants.isIntroForMemeProfile = "false";
      }
      //  followSwitchId();
      // bottomSheetForFollowing();
    }

    /// this intro is for ChatList page
    if (prefs.getInt("chatListIntro") == null) {
      prefs.setInt("chatListIntro", 0);

      print("chatListIntro: ${prefs.getInt("chatListIntro")}");

      Constants.introForChatListPage = "true";
    } else {
      if (prefs.getInt("chatListIntro")! <= 0) {
        print("chatListIntro: ${prefs.getInt("chatListIntro")}");
        Constants.introForChatListPage = "true";
      } else {
        print("chatListIntro: ${prefs.getInt("chatListIntro")}");
        Constants.introForChatListPage = "false";
      }
      //  followSwitchId();
      // bottomSheetForFollowing();
    }
  }

  _setNotificationCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("notifyCounter", "0");
    setState(() {
      Constants.notifyBell = true;
      // Constants.messageIconActive = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    /// auth for checking that user is signIn or Not
    final auth = Provider.of<AuthBase>(context, listen: false);

    return StreamBuilder<User?>(
        stream: auth.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            User? user = snapshot.data;

            if (user == null) {
              return HomeLanding();
            } else if (!user.emailVerified) {
              ///Main page take us to transation to one to another page through Navigation bar

              return BridgeToSetEmailVerification();
            } else {
              print(user.uid);

              return Provider<User>.value(
                value: user,
                child: BridgeToNavigationPage(
                  user: user,
                ),
              );
            }
          } else {
            return Scaffold(
              backgroundColor: Colors.white,
              body: Center(
                child: CircularProgressIndicator(
                  color: Colors.blue,
                ),
              ),
            );
          }
        });
  }
}

class HomeLanding extends StatefulWidget {
  @override
  _HomeLandingState createState() => _HomeLandingState();
}

class _HomeLandingState extends State<HomeLanding> {
  Future<void> _signInWithGoogle() async {
    final auth = Provider.of<AuthBase>(context, listen: false);

    try {
      await auth.signInWithGoogle();
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => LandingPage(),
        ),
        (route) => false,
      );
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        elevation: 0,
      ),
      backgroundColor: Colors.lightBlue,
      body: Container(
        height: MediaQuery.of(context).size.height,
        color: Colors.lightBlue,
        child: DelayedDisplay(
          delay: Duration(microseconds: 100),
          slidingBeginOffset: Offset(0, 1),
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  Container(
                    height: 150,
                    width: 200,
                    child: RiveAnimation.asset(
                      'images/authLogo.riv',
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 25, top: 0),
                    child: Text(
                      "Double Slit World",
                      style: TextStyle(
                        fontFamily: "Cute",
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width / 1.5,
                      child: Material(
                        borderRadius: BorderRadius.circular(10),
                        child: TextButton(
                          onPressed: () => {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SignInPage(),
                              ),
                            ),
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Sign with email ",
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontFamily: 'cute',
                                    fontSize: 17),
                              ),
                              SizedBox(
                                child: Lottie.asset(
                                  "images/emailLogo.json",
                                ),
                                height: 32,
                                width: 32,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "OR",
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'cute',
                          fontSize: 15),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width / 1.5,
                      child: Material(
                        borderRadius: BorderRadius.circular(10),
                        child: TextButton(
                          onPressed: () => _signInWithGoogle(),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Sign with Google ",
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontFamily: 'cute',
                                    fontSize: 17),
                              ),
                              Container(
                                clipBehavior: Clip.antiAlias,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(22)),
                                child: Lottie.asset(
                                  "images/googleLogo.json",
                                ),
                                height: 32,
                                width: 32,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),


                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () => {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => UserAgreementPage(),
                          ),
                        ),
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                          child: Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                    text: "By signing in you agree to our ",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: Colors.white,
                                      fontFamily: 'cutes',
                                    )),
                                TextSpan(
                                  text: 'Terms & Conditions.',
                                  style: TextStyle(
                                    fontSize: 10,
                                    decoration: TextDecoration.underline,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'cutes',
                                    color: Colors.blue.shade900,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextButton(
                      onPressed: () => {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => NeedHelpPageForSigninPage(
                            ),
                          ),
                        ),
                      },
                      child: Text(
                        "Need Help?",
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'cute',
                            fontSize: 15),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
