import 'dart:async';
import 'package:flutter/material.dart';
import 'package:iot/helper/helper.dart';
import 'package:iot/screens/home.dart';
class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);
  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(const Duration(seconds: 2), () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context){
        return const Home();
      }));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color.fromARGB(255, 1, 51, 121),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Align(
                alignment:Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CreateImage("images/texohamIconDarkBackground.png",width: 75,height: 75,),
                    Padding(
                      padding: EdgeInsets.only(top: 24.0),
                      child: Text("IOT Smart Control",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                      ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Text("powered by",style: TextStyle(fontSize: 14,color: Colors.white),),
            Padding(
              padding: EdgeInsets.only(bottom: 32.0,top: 8.0),
              child: CreateImage("images/texohamLogoDarkBackground.png",width: 120,),
            )
          ],
        ),
      ),
    );
  }
}
