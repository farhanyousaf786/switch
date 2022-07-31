import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_picker/country_picker.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:switchapp/Authentication/Auth.dart';
import 'package:switchapp/UniversalResources/DataBaseRefrences.dart';
import 'SetProfilePicture.dart';

timeStamp() => DateTime.now().toIso8601String();
class SetUserData extends StatefulWidget {
  final User? user;

  const SetUserData({ required this.user});

  @override
  _SetUserDataState createState() => _SetUserDataState();
}

class _SetUserDataState extends State<SetUserData> {
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController userNameTextEditingController = TextEditingController();
  FocusNode firstNameFocusNode = FocusNode();

  late String dob;
  String countryName = 'Select Country';

  final formKey = GlobalKey<FormState>();

  void formatUsername() {
    userNameTextEditingController.text =
        userNameTextEditingController.text.replaceAll(" ", "");
  }


  signOut() {
    final auth = Provider.of<AuthBase>(context, listen: false);
    auth.signOut();
    Navigator.pop(context);
  }

  setUserInfo() async {
    formatUsername();

    if (firstName.text.isEmpty ||
        lastName.text.isEmpty || userNameTextEditingController.text.length >29 ||
        dob.isEmpty ||
        userNameTextEditingController.text.isEmpty ||
        userExists == true) {
      showModalBottomSheet(
          useRootNavigator: true,
          isScrollControlled: true,
          barrierColor: Colors.red.withOpacity(0.2),
          elevation: 0,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          context: context,
          builder: (context) {
            return Container(
              height: MediaQuery.of(context).size.height / 2.5,
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
                            Icon(Icons.linear_scale_sharp,
                              color: Colors.white,),
                          ],
                        ),
                      ),
                      color: Colors.blue,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Container(
                          height: 150,
                          width: 150,
                          child: Lottie.asset("images/error.json")),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        userExists
                            ? "Username is already Taken"
                            : "All information should be added",
                        style: TextStyle(
                            fontSize: 15,
                            fontFamily: "cutes",
                            fontWeight: FontWeight.bold,
                            color: Colors.red),
                      ),
                    ),
                    ElevatedButton(
                      child: Text('Back'),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                          primary: Colors.red,
                          textStyle: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ),
            );
          });
    } else {
      final user = Provider.of<User>(context, listen: false);
      relationShipReferenceRtd.child(user.uid).set({
        "inRelationshipWithId": "",
        "inRelationshipWithSecondName": "",
        "inRelationshipWithFirstName": "",
        "crush": "",
        "closeFriend": "",
        "relationShipStatus": "",
        "inRelationShip": false,
        "pendingRelationShip": false,
        "relationShipRequestSenderSecondName": "",
        "relationShipRequestSenderName": "",
        "relationShipRequestSenderFirstName": "",
        "relationShipRequestSenderId": "",
        "relationShipRequestSendToName": "",
        "relationShipRequestSendToId": "",
      });
      userRefRTD.child(user.uid).update({
        "androidNotificationToken": "",
        "ownerId": user.uid,
        "firstName":
            firstName.text[0].toUpperCase() + firstName.text.substring(1),
        "secondName":
            lastName.text[0].toUpperCase() + lastName.text.substring(1),
        "timestamp": DateTime.now().millisecondsSinceEpoch.toString(),
        "email": user.email,
        "dob": dob,
        "gender": "Not Set Yet",
        "country": countryName,
        'url':
            "https://firebasestorage.googleapis.com/v0/b/double-slit-world.appspot.com/o/StaticFiles%2Flogo.png?alt=media&token=45a8c220-a473-431f-934d-335527ce3a86",
        'isBan': "false",
        "currentMood": "Happy",
        "username": userNameTextEditingController.text.toLowerCase(),
        "isVerified": "false",
      });
      userProfileDecencyReport.child(user.uid).update({
        "numberOfOne": 0,
        "numberOfTwo": 0,
        "numberOfThree": 0,
        "numberOfFour": 0,
        "numberOfFive": 0,
      });
      userRefForSearchRtd.child(user.uid).update({
        "isVerified": "false",
        "ownerId": user.uid,
        "username": userNameTextEditingController.text.toLowerCase(),
        "firstName":
            firstName.text[0].toUpperCase() + firstName.text.substring(1),
        "secondName":
            lastName.text[0].toUpperCase() + lastName.text.substring(1),
        "url":
            "https://firebasestorage.googleapis.com/v0/b/double-slit-world.appspot.com/o/StaticFiles%2Flogo.png?alt=media&token=45a8c220-a473-431f-934d-335527ce3a86",
      });
      userFollowersCountRtd.child(user.uid).set({
        "followerCounter": 0,
        "uid": user.uid,
        "username": userNameTextEditingController.text.toLowerCase(),
        "photoUrl":             "https://firebasestorage.googleapis.com/v0/b/double-slit-world.appspot.com/o/StaticFiles%2Flogo.png?alt=media&token=45a8c220-a473-431f-934d-335527ce3a86",

      });
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Provider<AuthBase>(
            create: (context) => Auth(),
            child: SetProfilePicture(user: user.uid, email: user.email, users: widget.user!,),
          ),
        ),
      );
    }
  }

  defaultUserInfo() async {
    final user = Provider.of<User>(context, listen: false);
    userRefRTD.child(user.uid).update({
      "androidNotificationToken": "",
      "ownerId": user.uid,
      "firstName": "Not set",
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
      "about": "Not Set",
      'gender': "Not set",
      'inRelationship': "false",
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
    userRefForSearchRtd.child(user.uid).update({
      "ownerId": user.uid,
      "firstName": "Not Set",
      "secondName": "Not Set",
      "url":
          "https://firebasestorage.googleapis.com/v0/b/double-slit-world.appspot.com/o/StaticFiles%2Flogo.png?alt=media&token=45a8c220-a473-431f-934d-335527ce3a86",
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
  void initState() {
    super.initState();
    getAllUsers();
  }

  getAllUsers() {
    userRefForSearchRtd.once().then((DataSnapshot snapshot) {
      values = snapshot.value;
      List userList = [];
      if (values == null) {
        setState(() {
          userListEmpty = true;
        });
      } else {
        setState(() {
          values
              .forEach((index, data) => userList.add({"user": index, ...data}));
        });
        setState(() {
          this.userList = userList;
        });

      }
    });
  }

  List userList = [];
  List userList2 = [];

  late Map<dynamic, dynamic> values;
  bool userListEmpty = false;
  bool userExists = false;
  bool userNameLengthExceeded = false;
  bool userExistsText = false;

  userValidater(String userName) {
    if (userName.isNotEmpty) {
      if (userName.length > 29) {
        showModalBottomSheet(
            useRootNavigator: true,
            isScrollControlled: true,
            barrierColor: Colors.red.withOpacity(0.2),
            elevation: 0,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            context: context,
            builder: (context) {
              return Container(
                height: MediaQuery.of(context).size.height / 3,
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
                              Icon(Icons.linear_scale_sharp,
                                color: Colors.white,),
                            ],
                          ),
                        ),
                        color: Colors.blue,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Container(
                            height: 150,
                            width: 150,
                            child: Lottie.asset("images/error.json")),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                              "Username Must be less than 30 characters",

                          style: TextStyle(
                              fontSize: 15,
                              fontFamily: "cutes",
                              fontWeight: FontWeight.bold,
                              color: Colors.red),
                        ),
                      ),
                      ElevatedButton(
                        child: Text('Back'),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                            primary: Colors.red,
                            textStyle: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                ),
              );
            });
      } else {

        setState(() {
          userList2 = userList;
        });
        int trendIndex = userList.indexWhere((f) =>
            f['username'] == userNameTextEditingController.text.toLowerCase());

        if (trendIndex == -1) {

          setState(() {
            userExists = false;
          });
        } else {
          setState(() {
            userExists = true;
          });
        }

      }
    } else {
      print("empty");
    }
  }

  void _userNameEditingComplete() {
    formatUsername();

    userValidater(userNameTextEditingController.text.toLowerCase());
    FocusScope.of(context).requestFocus(firstNameFocusNode);
  }



  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context, listen: false);

    return Scaffold(
// backgroundColor: Colors.white,
      appBar: AppBar(
        leading: Text(""),
        backgroundColor: Colors.lightBlue,
        title: Text(
          "Set Profile",
          style: TextStyle(
            fontFamily: "Cute",
            color: Colors.white,
            fontSize: 16,
          ),
        ),
        actions: [
          ElevatedButton(
            child: Text(
              'Next',
              style: TextStyle(
                fontFamily: "Cute",
                fontSize: 16,
                color: userExists ? Colors.white60 : Colors.white,
              ),
            ),
            onPressed: () {
              setUserInfo();
            },
            style: ElevatedButton.styleFrom(
                elevation: 0.0,
                primary: Colors.lightBlue,
                textStyle:
                    TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
          ),
        ],
        centerTitle: true,
        elevation: 0,
      ),

      body: Container(
        color: Colors.lightBlue,
        child: DelayedDisplay(
          delay: Duration(seconds: 1),
          slidingBeginOffset: Offset(0.0, -1),
          child: ListView(
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
              userExistsText
                  ? userExists
                      ? Center(
                          child: Text(
                           "This username Already taken",
                            style: TextStyle(
                                color: Colors.red.shade700,
                                fontSize: 12,
                                fontFamily: 'cute'),
                          ),
                        )
                      : Center(
                          child: Text(
                            userNameTextEditingController.text.isEmpty
                                ? ""
                                : "This username is Available",
                            style: TextStyle(
                                color: Colors.blue.shade800,
                                fontFamily: 'cute',
                                fontSize: 12),
                          ),
                        )
                  : Text(""),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Container(
                  // height: 65,
                  padding: EdgeInsets.fromLTRB(60, 0, 60, 0),
                  child: TextField(
                    inputFormatters: [
                    ],
                    onEditingComplete: _userNameEditingComplete,
                    onChanged: (values) {
                      userValidater(
                          userNameTextEditingController.text.toLowerCase());
                    },
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    //   maxLength: 30,
                    onTap: () => {
                      setState(() {
                        userExistsText = true;
                      }),
                    },
                    style: TextStyle(
                      color: Colors.blue.shade900,
                      fontSize: 12,
                      fontFamily: "Cute",
                    ),
                    controller: userNameTextEditingController,
                    decoration: InputDecoration(
                      fillColor: Colors.transparent,
                      isDense: true,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        borderSide:
                            new BorderSide(color: Colors.white, width: 2),
                      ),
                      filled: true,
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        borderSide:
                            new BorderSide(color: Colors.white, width: 2),
                      ),
                      labelText: 'Username',
                      labelStyle: TextStyle(
                          fontFamily: "Cute",
                          color: Colors.blue.shade900,
                          fontSize: 12),
                    ),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(15.0),
                child: DelayedDisplay(
                  delay: Duration(seconds: 1),
                  slidingBeginOffset: Offset(-0.5, 0.0),
                  child: Container(
                    height: 50,
                    padding: EdgeInsets.fromLTRB(60, 0, 60, 0),
                    child: TextField(
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      style: TextStyle(
                          color: Colors.blue.shade900,
                          fontFamily: "Cute",
                          fontSize: 12),
                      controller: firstName,
                      focusNode: firstNameFocusNode,
                      decoration: InputDecoration(
                        isDense: true,
                        fillColor: Colors.transparent,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          borderSide:
                              new BorderSide(color: Colors.white, width: 2),
                        ),
                        filled: true,
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          borderSide:
                              new BorderSide(color: Colors.white, width: 2),
                        ),
                        labelText: 'First Name',
                        labelStyle: TextStyle(
                            fontFamily: 'cute',
                            color: Colors.blue.shade900,
                            fontSize: 12),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: DelayedDisplay(
                  delay: Duration(seconds: 1),
                  slidingBeginOffset: Offset(-0.5, 0.0),
                  child: Container(
                    height: 50,
                    padding: EdgeInsets.fromLTRB(60, 0, 60, 0),
                    child: TextField(
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      style: TextStyle(
                          color: Colors.blue.shade900,
                          fontFamily: "Cute",
                          fontSize: 12),
                      controller: lastName,
                      decoration: InputDecoration(
                        fillColor: Colors.transparent,
                        isDense: true,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          borderSide:
                              new BorderSide(color: Colors.white, width: 2),
                        ),
                        filled: true,
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          borderSide:
                              new BorderSide(color: Colors.white, width: 2),
                        ),
                        labelText: 'Last Name',
                        labelStyle: TextStyle(
                            color: Colors.blue.shade900,
                            fontSize: 12,
                            fontFamily: 'cute'),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.only(top: 20),
                child: Text(
                  "Date Of Birth",
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: "Cute",
                    color: Colors.white,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Container(
                  height: 80,
                  padding: EdgeInsets.fromLTRB(80, 0, 80, 0),
                  child: TextFormField(
                    maxLength: 10,
                    maxLengthEnforced: false,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    style: TextStyle(
                        color: Colors.blue.shade800,
                        fontFamily: "Cute",
                        fontWeight: FontWeight.bold,
                        fontSize: 12),
                    onChanged: (value) => {
                      dob = value,
                    },
                    decoration: InputDecoration(
                      fillColor: Colors.transparent,
                      isDense: true,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        borderSide:
                            new BorderSide(color: Colors.white, width: 2),
                      ),
                      filled: true,
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        borderSide: new BorderSide(
                          color: Colors.white,
                          width: 2,
                        ),
                      ),
                      labelText: 'Exp : 12/30/1999',
                      labelStyle: TextStyle(
                          color: Colors.blue.shade800,
                          fontSize: 12,
                          fontFamily: 'cute'),
                    ),
                  ),
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.only(left: 50, right: 50, top: 10),
              //   child: Container(
              //     decoration: BoxDecoration(
              //         color: Colors.white10,
              //         borderRadius: BorderRadius.circular(20)),
              //     height: 150,
              //     child: CupertinoDatePicker(
              //       mode: CupertinoDatePickerMode.date,
              //       initialDateTime: DateTime(1996, 10, 10),
              //       onDateTimeChanged: (DateTime newDateTime) {
              //         _selectedDate = newDateTime;
              //         print(_selectedDate);
              //       },
              //     ),
              //   ),
              // ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Center(
                  child: Text(
                    "Your Country",
                    style: TextStyle(
                      fontFamily: "Cute",
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: Container(
              //     child: CountryListPick(
              //       // pickerBuilder: (context, CountryCode countryCode) {
              //       //   return Row(
              //       //     children: [
              //       //       Image.asset(
              //       //         countryCode.flagUri,
              //       //         package: 'country_list_pick',
              //       //       ),
              //       //       Text(countryCode.code),
              //       //       Text(countryCode.dialCode),
              //       //     ],
              //       //   );
              //       // },
              //       theme: CountryTheme(
              //           isShowFlag: true,
              //           isShowTitle: true,
              //           isShowCode: false,
              //           isDownIcon: true,
              //           showEnglishName: true,
              //           alphabetTextColor: Colors.white,
              //           alphabetSelectedBackgroundColor: Colors.white),
              //       initialSelection: '+92',
              //
              //       onChanged: (CountryCode code) {
              //         print(code.name);
              //         print(code.code);
              //         print(code.dialCode);
              //         print(code.flagUri);
              //         setState(() {
              //           countryName = code.name;
              //         });
              //       },
              //     ),
              //   ),
              // ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: FlatButton(

                    // shape: RoundedRectangleBorder(
                    //     borderRadius: BorderRadius.circular(15.0),
                    //     side: BorderSide(color: Colors.grey, width: 2)),
                    child: Container(
                      padding: EdgeInsets.only(
                          top: 11, left: 8, right: 8, bottom: 10),
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.blue.shade50,
                        border:
                            Border.all(color: Colors.blue.shade700, width: 1),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Text(
                        '$countryName',
                        style: TextStyle(
                            color: Colors.blue.shade800,
                            fontFamily: "Cute",
                            fontSize: 10),
                      ),
                    ),
                    onPressed: () => {
                          showCountryPicker(
                            context: context,
                            //Optional.  Can be used to exclude(remove) one ore more country from the countries list (optional).
                            exclude: <String>['KN', 'MF'],
                            //Optional. Shows phone code before the country name.
                            showPhoneCode: true,
                            onSelect: (Country country) {
                              setState(() {
                                countryName = country.name;
                              });
                            },
                          )
                        }),
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: DelayedDisplay(
                  delay: Duration(seconds: 1),
                  slidingBeginOffset: Offset(0.0, -1),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        "1 of 2 Steps",
                        style: TextStyle(
                          fontFamily: "Cute",
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),

                      // Flexible(
                      //   child: Container(
                      //     padding: EdgeInsets.only(top: 60, left: 20, right: 20),
                      //     child: RaisedButton(
                      //       focusColor: Colors.white,
                      //       highlightColor: Colors.white,
                      //       elevation: 0,
                      //       textColor: Colors.blue.shade700,
                      //       color: Colors.blue.withOpacity(0.1),
                      //       child: Text(
                      //         'Next',
                      //         style: TextStyle(
                      //           fontFamily: "Cute",
                      //           fontSize: 16,
                      //           color: Colors.white,
                      //         ),
                      //       ),
                      //       onPressed: setUserInfo,
                      //     ),
                      //   ),
                      // ),
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
