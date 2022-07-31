import 'package:flutter/material.dart';

class ConnectionLost extends StatefulWidget {
  @override
  _ConnectionLostState createState() => _ConnectionLostState();
}

class _ConnectionLostState extends State<ConnectionLost> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.blue,
      ),
      body: Container(
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "No Internet",
                  style: TextStyle(
                      color: Colors.white, fontSize: 20, fontFamily: 'cute'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Make sure that Your WIFI or Mobile Network in On",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white, fontSize: 10, fontFamily: 'cute'),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamedAndRemoveUntil(context, '/', (_) => false);
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.refresh_sharp,
                        size: 22,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        "Refresh",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontFamily: 'cute'),
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
