// /*
//
// This class will handle user to get their email verification
//
//  */
//
// import 'dart:async';
//
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:provider/provider.dart';
// import 'package:rive/rive.dart';
// import 'package:switchapp/Authentication/Auth.dart';
// import 'package:switchapp/Authentication/SignIn/SignInPage.dart';
// import 'package:switchapp/Authentication/SignUp/SetUserData.dart';
// import 'package:switchapp/Bridges/bridgeToSetEmailVerification.dart';
// import 'package:switchapp/Models/Constans.dart';
// import 'package:switchapp/UniversalResources/DataBaseRefrences.dart';
//
// class EmailVerification extends StatefulWidget {
//   // This is object of class User and we passed it as parameter, it has basic info of our user
//   final User user;
//
//   EmailVerification({
//     required this.user,
//   });
//
//   @override
//   _EmailVerificationState createState() => _EmailVerificationState();
// }
//
// class _EmailVerificationState extends State<EmailVerification> {
//   // Firebase auth instant object to check
//   // if user verified by email or not
//
//   final auth = FirebaseAuth.instance;
//
//   late User user;
//
//   late Timer timer;
//
//   String countryName = 'Select Country';
//
//   // this function will always run one time
//   // when we came to this class
//   @override
//   void initState() {
//     super.initState();
//     user = auth.currentUser!;
//     user.sendEmailVerification();
//     defaultUserInfo();
//   }
//
//   // this information will store to firebase as soon as a user tap our Switch button from sign up page
//   // after tap our app lead our user to this page and for security we will store this info at very first
//   // moment as default info. We did it because may be user exit the app or may be he close app accidently
//   // after tap on switch button from signup class. So we make sure that the user with that email has his
//   // store in database. So we can use this and make our decision on the basis of this info so that user
//   // can set his/her own info when he start application
//
//   defaultUserInfo() async {
//     final user = Provider.of<User>(context, listen: false);
//     userRefRTD.child(user.uid).set({
//       "username": "",
//       "androidNotificationToken": "",
//       "ownerId": user.uid,
//       "firstName": "",
//       "secondName": "",
//       "timestamp": DateTime.now().millisecondsSinceEpoch.toString(),
//       "email": user.email,
//       "dob": "01/01/2000",
//       "country": countryName,
//       'isBan': "false",
//       'postId': "N/A",
//       'url':
//           "https://firebasestorage.googleapis.com/v0/b/double-slit-world.appspot.com/o/StaticFiles%2Flogo.png?alt=media&token=45a8c220-a473-431f-934d-335527ce3a86",
//       "currentMood": "Happy",
//       "about": "notSet",
//       'gender': "notSet",
//       "isVerified": "false",
//       "password": Constants.pass,
//     });
//     userProfileDecencyReport.child(user.uid).update({
//       "numberOfOne": 0,
//       "numberOfTwo": 0,
//       "numberOfThree": 0,
//       "numberOfFour": 0,
//       "numberOfFive": 0,
//     });
//     memeProfileRtd.child(user.uid).set({
//       "isMemer": "Yes",
//       "totalMemes": 0,
//       "numberOfOne": 0,
//       "numberOfTwo": 0,
//       "numberOfThree": 0,
//       "numberOfFour": 0,
//       "numberOfFive": 0,
//     });
//     memerPercentageDecencyRtd.child(user.uid).set({
//       "PercentageDecency": 0,
//       'uid': user.uid,
//     });
//
//     relationShipReferenceRtd.child(user.uid).set({
//       "inRelationshipWithId": "",
//       "inRelationshipWithSecondName": "",
//       "inRelationshipWithFirstName": "",
//       "inRelationShip": false,
//       "pendingRelationShip": false,
//       "inRelationshipWith": "",
//     });
//   }
//
//   @override
//   void dispose() {
//     timer.cancel();
//     super.dispose();
//   }
//
//   Future<void> checkEmailVerified() async {
//     user = auth.currentUser!;
//     await user.reload();
//     if (user.emailVerified) {
//       timer.cancel();
//       Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(
//             builder: (context) => Provider<User>.value(
//               value: widget.user,
//               child: SetUserData(
//                 user: widget.user,
//               ),
//             ),
//           ));
//     } else {}
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     timer = Timer.periodic(Duration(seconds: 2), (timer) {
//       checkEmailVerified();
//     });
//     return Scaffold(
//       backgroundColor: Colors.lightBlue,
//       appBar: AppBar(
//         actions: [
//           IconButton(
//             icon: Icon(
//               Icons.logout,
//               color: Colors.white,
//             ),
//             onPressed: () => Navigator.pushAndRemoveUntil(
//               context,
//               MaterialPageRoute(
//                 builder: (BuildContext context) => SignInPage(),
//               ),
//               (route) => false,
//             ),
//           ),
//         ],
//         centerTitle: true,
//         automaticallyImplyLeading: false,
//         backgroundColor: Colors.lightBlue,
//         elevation: 0,
//         title: Text(
//           "Verification",
//           style: TextStyle(
//             fontSize: 25,
//             fontFamily: "cute",
//           ),
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.only(left: 12, right: 12),
//           child: Column(
//             children: [
//               Container(
//                 height: 200,
//                 width: 200,
//                 child: RiveAnimation.asset(
//                   'images/authLogo.riv',
//                 ),
//               ),
//               Container(
//                 padding: EdgeInsets.all(10),
//                 decoration: BoxDecoration(
//                     color: Colors.blue.shade700,
//                     borderRadius: BorderRadius.circular(15)),
//                 child: Text(
//                   "Stay Here",
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                     fontFamily: 'cute',
//                     color: Colors.white,
//                     fontSize: 20,
//                   ),
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(15),
//                 child: Text(
//                   widget.user.email.toString(),
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                     fontFamily: 'cutes',
//                     color: Colors.white,
//                     fontWeight: FontWeight.bold,
//                     fontSize: 15,
//                   ),
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(20),
//                 child: Text(
//                   "A Link sent to your email, kindly open that email and click on link to verify.",
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                     fontFamily: 'cute',
//                     color: Colors.white,
//                     fontSize: 15,
//                   ),
//                 ),
//               ),
//               // Padding(
//               //   padding: const EdgeInsets.all(5),
//               //   child: Text(
//               //     "${user.email}",
//               //     textAlign: TextAlign.center,
//               //     style: TextStyle(
//               //       fontFamily: 'cute',
//               //       color: Colors.blue.shade900,
//               //       fontSize: 12,
//               //     ),
//               //   ),
//               // ),
//
//               SizedBox(
//                 height: MediaQuery.of(context).size.height / 5.5,
//               ),
//               Text(
//                 "Did not get email?",
//                 textAlign: TextAlign.center,
//                 style: TextStyle(
//                   fontFamily: 'cutes',
//                   fontWeight: FontWeight.bold,
//                   color: Colors.black,
//                   fontSize: 15,
//                 ),
//               ),
//               GestureDetector(
//                 onTap: () => checkEmailVerified(),
//                 child: Center(
//                   child: Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Text(
//                       "Kindly, Check your email Spam Folder.",
//                       textAlign: TextAlign.center,
//                       style: TextStyle(
//                         fontFamily: 'cutes',
//                         fontWeight: FontWeight.bold,
//                         color: Colors.black,
//                         fontSize: 12,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               GestureDetector(
//                 onTap: () {
//                   showModalBottomSheet(
//                       useRootNavigator: true,
//                       isScrollControlled: true,
//                       barrierColor: Colors.red.withOpacity(0.2),
//                       elevation: 0,
//                       clipBehavior: Clip.antiAliasWithSaveLayer,
//                       context: context,
//                       builder: (context) {
//                         return Container(
//                           height: MediaQuery.of(context).size.height / 4,
//                           child: SingleChildScrollView(
//                             child: Column(
//                               children: [
//                                 Container(
//                                   child: Padding(
//                                     padding: const EdgeInsets.all(5.0),
//                                     child: Row(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.center,
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.center,
//                                       children: [
//                                         Icon(
//                                           Icons.linear_scale_sharp,
//                                           color: Colors.white,
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                   color: Colors.blue,
//                                 ),
//                                 Padding(
//                                   padding: const EdgeInsets.all(8.0),
//                                   child: Text(
//                                     "Kindly Review the below Lines",
//                                     textAlign: TextAlign.center,
//                                     style: TextStyle(
//                                         fontSize: 15,
//                                         fontFamily: "cutes",
//                                         fontWeight: FontWeight.bold,
//                                         color: Colors.red),
//                                   ),
//                                 ),
//                                 Padding(
//                                   padding: const EdgeInsets.all(8.0),
//                                   child: Text(
//                                     "* Check that, the email you put is correct? \n"
//                                     "* Check your internet connection. \n",
//                                     textAlign: TextAlign.center,
//                                     style: TextStyle(
//                                         fontSize: 16,
//                                         fontFamily: "cutes",
//                                         fontWeight: FontWeight.bold,
//                                         color: Colors.blue),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         );
//                       });
//                 },
//                 child: Padding(
//                   padding: const EdgeInsets.only(top: 4),
//                   child: Text(
//                     "Need Help!",
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontFamily: 'cute',
//                       fontSize: 10,
//                     ),
//                   ),
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

/*

This class will handle user to get their email verification

 */

import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:rive/rive.dart';
import 'package:switchapp/Authentication/Auth.dart';
import 'package:switchapp/Authentication/SignIn/SignInPage.dart';
import 'package:switchapp/Authentication/SignUp/SetUserData.dart';
import 'package:switchapp/Bridges/bridgeToSetEmailVerification.dart';
import 'package:switchapp/Models/Constans.dart';
import 'package:switchapp/UniversalResources/DataBaseRefrences.dart';

class EmailVerification extends StatefulWidget {
  // This is object of class User and we passed it as parameter, it has basic info of our user
  final User user;

  EmailVerification({
    required this.user,
  });

  @override
  _EmailVerificationState createState() => _EmailVerificationState();
}

class _EmailVerificationState extends State<EmailVerification> {
  // Firebase auth instant object to check
  // if user verified by email or not

  final auth = FirebaseAuth.instance;

  late User user;

  late Timer timer;

  String countryName = 'Select Country';

  // this function will always run one time
  // when we came to this class
  @override
  void initState() {
    super.initState();
    user = auth.currentUser!;
    user.sendEmailVerification();
    defaultUserInfo();
  }

  // this information will store to firebase as soon as a user tap our Switch button from sign up page
  // after tap our app lead our user to this page and for security we will store this info at very first
  // moment as default info. We did it because may be user exit the app or may be he close app accidently
  // after tap on switch button from signup class. So we make sure that the user with that email has his
  // store in database. So we can use this and make our decision on the basis of this info so that user
  // can set his/her own info when he start application

  defaultUserInfo() async {
    final user = Provider.of<User>(context, listen: false);
    userRefRTD.child(user.uid).set({
      "username": "",
      "androidNotificationToken": "",
      "ownerId": user.uid,
      "firstName": "",
      "secondName": "",
      "timestamp": DateTime.now().millisecondsSinceEpoch.toString(),
      "email": user.email,
      "dob": "01/01/2000",
      "country": countryName,
      'isBan': "false",
      'postId': "N/A",
      'url':
          "https://firebasestorage.googleapis.com/v0/b/double-slit-world.appspot.com/o/StaticFiles%2Flogo.png?alt=media&token=45a8c220-a473-431f-934d-335527ce3a86",
      "currentMood": "Happy",
      "about": "notSet",
      'gender': "notSet",
      "isVerified": "false",
      "password": Constants.pass,
    });
    userProfileDecencyReport.child(user.uid).update({
      "numberOfOne": 0,
      "numberOfTwo": 0,
      "numberOfThree": 0,
      "numberOfFour": 0,
      "numberOfFive": 0,
    });
    memeProfileRtd.child(user.uid).set({
      "isMemer": "Yes",
      "totalMemes": 0,
      "numberOfOne": 0,
      "numberOfTwo": 0,
      "numberOfThree": 0,
      "numberOfFour": 0,
      "numberOfFive": 0,
    });
    memerPercentageDecencyRtd.child(user.uid).set({
      "PercentageDecency": 0,
      'uid': user.uid,
    });

    relationShipReferenceRtd.child(user.uid).set({
      "inRelationshipWithId": "",
      "inRelationshipWithSecondName": "",
      "inRelationshipWithFirstName": "",
      "inRelationShip": false,
      "pendingRelationShip": false,
      "inRelationshipWith": "",
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  bool isVerified = false;

  Future<void> checkEmailVerified() async {
    user = auth.currentUser!;
    await user.reload();
    if (user.emailVerified) {
      timer.cancel();
      setState(() {
        isVerified = true;
      });
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    timer = Timer.periodic(Duration(seconds: 3), (timer) {
      checkEmailVerified();
    });
    return Scaffold(
      backgroundColor: Colors.lightBlue,
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(
              Icons.logout,
              color: Colors.white,
            ),
            onPressed: () => Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => SignInPage(),
              ),
              (route) => false,
            ),
          ),
        ],
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.lightBlue,
        elevation: 0,
        title: Text(
          "Verification",
          style: TextStyle(
            fontSize: 25,
            fontFamily: "cute",
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 12, right: 12),
          child: isVerified
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [

                      Container(
                        height: 200,
                        width: 200,
                        child: RiveAnimation.asset(
                          'images/authLogo.riv',
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15)),
                          child: Text(
                            "Verified Successfully",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'cute',
                              color: Colors.green.shade700,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Provider<User>.value(
                                value: widget.user,
                                child: SetUserData(
                                  user: widget.user,
                                ),
                              ),
                            ),
                          ),
                        },
                        child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15)),
                          child: Text(
                            "Click here to proceed",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'cute',
                              color: Colors.blue.shade700,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              : Column(
                  children: [
                    Container(
                      height: 200,
                      width: 200,
                      child: RiveAnimation.asset(
                        'images/authLogo.riv',
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: Text(
                        widget.user.email.toString(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'cutes',
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.blue.shade700,
                          borderRadius: BorderRadius.circular(15)),
                      child: Text(
                        "Stay Here",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'cute',
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Text(
                        "A Link sent to your email, kindly open that email and click on link to verify.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'cute',
                          color: Colors.white,
                          fontSize: 15,
                        ),
                      ),
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.all(5),
                    //   child: Text(
                    //     "${user.email}",
                    //     textAlign: TextAlign.center,
                    //     style: TextStyle(
                    //       fontFamily: 'cute',
                    //       color: Colors.blue.shade900,
                    //       fontSize: 12,
                    //     ),
                    //   ),
                    // ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Verifying  ",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'cute',
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                            SpinKitCircle(
                              color: Colors.white,
                              size: 16,
                            )
                          ],
                        ),
                      ),
                    ),

                    SizedBox(
                      height: MediaQuery.of(context).size.height / 5.5,
                    ),
                    Text(
                      "Did not get email?",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'cutes',
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 15,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => checkEmailVerified(),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Kindly, Check your email Spam Folder.",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'cutes',
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                            useRootNavigator: true,
                            isScrollControlled: true,
                            barrierColor: Colors.red.withOpacity(0.2),
                            elevation: 0,
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            context: context,
                            builder: (context) {
                              return Container(
                                height: MediaQuery.of(context).size.height / 4,
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      Container(
                                        child: Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
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
                                          "Kindly Review the below Lines",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontFamily: "cutes",
                                              fontWeight: FontWeight.bold,
                                              color: Colors.red),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          "* Check that, the email you put is correct? \n"
                                          "* Check your internet connection. \n",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontFamily: "cutes",
                                              fontWeight: FontWeight.bold,
                                              color: Colors.blue),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            });
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: Text(
                          "Need Help!",
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'cute',
                            fontSize: 10,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
        ),
      ),
    );
  }
}
