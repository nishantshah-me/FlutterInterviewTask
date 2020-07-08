import 'package:ePaisa_interview/presentation/login/login_bloc.dart';
import 'package:ePaisa_interview/presentation/map/map.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:get_it/get_it.dart';
import 'dart:convert' as JSON;
import 'package:http/http.dart' as http;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:ePaisa_interview/data/model/message_model.dart';
import 'package:local_auth/local_auth.dart';

class MyAppLoginPage extends StatefulWidget {
  @override
  _MyAppLoginPageState createState() => _MyAppLoginPageState();
}

class _MyAppLoginPageState extends State<MyAppLoginPage> {

  final LoginBloc bloc = GetIt.instance<LoginBloc>();

  final LocalAuthentication _localAuthentication = LocalAuthentication();
  bool _hasFingerPrintSupport = false;
  String _authorizedOrNot = "Not Authorized";
  List<BiometricType> _availableBuimetricType = List<BiometricType>();

  Future<void> _getBiometricsSupport() async {
    bool hasFingerPrintSupport = false;
    try {
      hasFingerPrintSupport = await _localAuthentication.canCheckBiometrics;
    } catch (e) {
      print(e);
    }
    if (!mounted) return;
    setState(() {
      _hasFingerPrintSupport = hasFingerPrintSupport;
    });
  }

  Future<void> _getAvailableSupport() async {
    List<BiometricType> availableBuimetricType = List<BiometricType>();
    try {
      availableBuimetricType =
          await _localAuthentication.getAvailableBiometrics();
    } catch (e) {
      print(e);
    }
    if (!mounted) return;
    setState(() {
      _availableBuimetricType = availableBuimetricType;
    });
  }

  Future<void> _authenticateMe() async {
    bool authenticated = false;
    try {
      authenticated = await _localAuthentication.authenticateWithBiometrics(
        localizedReason: "Authenticate for Testing", // message for dialog
        useErrorDialogs: true, // show error in dialog
        stickyAuth: false, // native process
      );
    } catch (e) {
      print(e);
    }
    if (!mounted) return;
    if (authenticated) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => MapPage()));
    }
    setState(() {
      _authorizedOrNot = authenticated ? "Authorized" : "Not Authorized";
    });
  }

  Map userProfile;
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  final List<Message> messages = [];

  @override
  void initState() {
    super.initState();
    bloc.streamController.stream.listen((data) {
      if(data.success ){
        // navigate
        print("Sucess");
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => MapPage()));
      }else{
        //error
        print("Failed");
      }
      print(data.userProfile);
    });

    bloc.notifyStreamController.stream.listen((data) {
      if(data.sucess){

      }
    });

    bloc.pushNotification();

    _getBiometricsSupport();
    _getAvailableSupport();
    _authenticateMe();
  }


  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        home: new Scaffold(
            body: Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [Colors.greenAccent, Colors.blueAccent])),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: EdgeInsets.symmetric(vertical: 20),
            child: Text(
              'Login',
              style: TextStyle(fontSize: 30, color: Colors.white),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
            child: TextFormField(
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.normal),
              decoration: InputDecoration(
                  labelText: 'Email',
                  hintText: 'Email',
                  border: InputBorder.none),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
            child: TextFormField(
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.normal),
              obscureText: true,
              decoration: InputDecoration(
                  labelText: 'Password',
                  hintText: 'Password',
                  border: InputBorder.none),
            ),
          ),
          Container(
            margin: EdgeInsets.all(10),
            width: double.infinity,
            height: 50,
            child: FlatButton(
              child: Text(
                'LOGIN (MAP)',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.normal,
                    fontSize: 15),
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MapPage()));
              },
              color: Colors.blueAccent,
            ),
          ),
          Container(
            margin: EdgeInsets.all(10),
            width: double.infinity,
            height: 50,
            child: FlatButton(
              child: Text(
                'TouchId',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.normal,
                    fontSize: 15),
              ),
              onPressed: () {
                _authenticateMe();
              },
              color: Colors.blueAccent,
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Text('Login With'),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                child: FlatButton(
                    onPressed: () {
                      bloc.facebookAuth();
                      //initiateFacebookLogin();
                    },
                    child: CircleAvatar(
                      radius: 20,
                      backgroundImage: AssetImage('assets/facebook.png'),
                    )),
              ),
              Container(
                child: FlatButton(
                    onPressed: () {},
                    child: CircleAvatar(
                      radius: 20,
                      backgroundImage: AssetImage('assets/instagram.png'),
                    )),
              )
            ],
          )
        ],
      ),
    )));
  }
}
