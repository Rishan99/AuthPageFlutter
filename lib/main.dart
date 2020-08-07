import 'package:authpage/authpage.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Auth Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xff999966),
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: AuthPage(
            onForgotPassword: (data) {},
            onSignUpButton: (confirmpassword, password, username) {},
            onLoginButton: (data, data1) {},
            onGoogleSignIn: () {},
            onFbSignIn: () {},
            ontwitterSignIn: () {},
          ),
        ));
  }
}
