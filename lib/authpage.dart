import 'dart:math';
import 'package:authpage/clipper/clipper.dart';
import 'package:flutter/material.dart';

typedef OnLoginPressed = void Function(String username, String password);

typedef OnSignUpPressed = void Function(
    String username, String password, String confirmPassword);

class AuthPage extends StatefulWidget {
  ///Top Widget typically logo or Application Name, If nothing to be displayed pass Container() as a value
  final Widget title;
  final String usernameHintText;
  final String passwordHintText;
  final String confirmPasswordHintText;
  final String loginButtonText;
  final String signUpButtonText;

  ///Custom BoxDecoration for third party logins [facebook, google, twitter], if null default box decoration is used
  ///provide Circle Shape decoration for better shadow visualization
  final BoxDecoration thirdPartyLoginDecoration;

  ///Action to be performed when forgot password is pressed
  final Function(String emailId) onForgotPassword;

  ///Action to be performed when login button is pressed
  ///
  ///[String username, String password]
  final OnLoginPressed onLoginButton;

  ///Action to be performed when sign up button is pressed
  ///
  ///[String username, String confirmPassword ,String password]

  final OnSignUpPressed onSignUpButton;

  ///Action to be performed when Google sign in button is pressed, if null the icon is hidden
  final Function onGoogleSignIn;

  ///Action to be performed when Facebook sign in button is pressed, if null the icon is hidden
  final Function onFbSignIn;

  ///Action to be performed when Twitter sign in button is pressed, if null the icon is hidden
  final Function ontwitterSignIn;

  const AuthPage({
    Key key,
    this.usernameHintText,
    this.passwordHintText,
    this.thirdPartyLoginDecoration,
    this.loginButtonText,
    this.signUpButtonText,
    this.confirmPasswordHintText,
    this.title,
    this.onGoogleSignIn,
    this.onFbSignIn,
    this.ontwitterSignIn,
    this.onForgotPassword,
    @required this.onLoginButton,
    @required this.onSignUpButton,
  })  : assert(onSignUpButton != null &&
            onLoginButton != null &&
            onForgotPassword != null),
        super(key: key);
  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> with TickerProviderStateMixin {
  double height, width;
  TextEditingController _userNameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
  bool _obscure = true;
  bool _obscure1 = true;
  bool _obscure2 = true;
  bool upwardAnimation = false;
  PageController _pageController = PageController();
  Animation<double> _animation1;
  AnimationController _animationController1;
  TextStyle _textTextStyle =
      TextStyle(color: Colors.white, decoration: TextDecoration.none);
  TextStyle _hintTextStyle = TextStyle(color: Colors.white70);
  Color _iconColor = Colors.white70;
  @override
  void initState() {
    super.initState();
    _animationController1 = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1200));
    _animation1 = Tween(begin: 0.0, end: pi).animate(_animationController1)
      ..addListener(() {});
  }

  @override
  Widget build(BuildContext context) {
    height = (MediaQuery.of(context).size.height -
            (MediaQuery.of(context).padding.bottom) -
            MediaQuery.of(context).padding.top) /
        100;
    width = (MediaQuery.of(context).size.width -
            (MediaQuery.of(context).padding.left) -
            MediaQuery.of(context).padding.right) /
        100;
    return PageView(
      physics: NeverScrollableScrollPhysics(),
      reverse: false,
      controller: _pageController,
      scrollDirection: Axis.vertical,
      children: [
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            child: Column(
              children: <Widget>[
                Expanded(
                  child: Container(
                    child: widget.title ??
                        Center(
                          child: CircleAvatar(
                            radius: 50,
                            backgroundColor: Colors.red,
                            child: Text('App Title'),
                          ),
                        ),
                  ),
                ),
                Stack(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: ClipPath(
                          clipper: UpperDiagonalClip(),
                          child: Container(
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                colors: [Color(0xff333399), Color(0xffff00cc)],
                                begin: Alignment.topRight,
                                end: Alignment.bottomLeft,
                              )),
                              height: height * 70,
                              width: width * 80,
                              child: loginPage(height * 70, width * 80))),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: ClipPath(
                          clipper: LowerDiagonalClipPart(),
                          child: Container(
                              color: Color(0xfff48817),
                              height: height * 70,
                              width: width * 80,
                              child: Container(
                                padding: EdgeInsets.only(
                                    bottom: height * 70 / 16,
                                    left: width * 1.3),
                                child: Align(
                                  alignment: Alignment.bottomLeft,
                                  child: InkWell(
                                    child: Container(
                                      padding: EdgeInsets.all(5),
                                      child: AnimatedBuilder(
                                        animation: _animation1,
                                        builder: (context, child) {
                                          return Transform.rotate(
                                            angle: _animation1.value,
                                            child: Icon(
                                              Icons.arrow_downward,
                                              color: Colors.white,
                                              size: 20,
                                            ),
                                          );
                                        },
                                      ),
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.black),
                                    ),
                                    onTap: () async {
                                      //arrow animation
                                      _animationController1.forward();

                                      //clear textfields
                                      _userNameController.clear();
                                      _passwordController.clear();
                                      _confirmPasswordController.clear();
                                      //animate to next page
                                      _pageController.animateToPage(1,
                                          duration: Duration(seconds: 1),
                                          curve: Curves.ease);
                                    },
                                  ),
                                ),
                              ))),
                    ),
                    (widget.onGoogleSignIn != null)
                        ? Positioned(
                            bottom: (height * 70 - (height * 70) / 1.25) -
                                height * 0,
                            left:
                                width * 70 - (width * 70 / 1.39) - width * 8.2,
                            child: circularLoginWidget(
                                "assets/google.png", widget.onGoogleSignIn),
                          )
                        : Container(),
                    (widget.onFbSignIn != null)
                        ? Positioned(
                            bottom: (height * 70 - (height * 70) / 1.25) - 42,
                            left: width * 70 - (width * 70 / 1.4) + 10,
                            child: circularLoginWidget(
                                "assets/fb.png", widget.onFbSignIn),
                          )
                        : Container(),
                    (widget.ontwitterSignIn != null)
                        ? Positioned(
                            bottom: (height * 70 - (height * 70) / 1.25) -
                                42 -
                                42 +
                                12 -
                                12,
                            left: width * 70 - (width * 70 / 1.5) + 5 + 25 + 12,
                            child: circularLoginWidget(
                                "assets/twitter.png", widget.ontwitterSignIn),
                          )
                        : Container(),
                  ],
                ),
              ],
            ),
          ),
        ),
        Container(
          child: Align(
            alignment: Alignment.topCenter,
            child: Stack(
              children: <Widget>[
                Align(
                  alignment: Alignment.topCenter,
                  child: ClipPath(
                    clipper: LowerDiagonalClip(),
                    child: Container(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                        colors: [
                          Color(0xfff5af19),
                          Color(0xfff12711),
                        ],
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                      )),
                      height: height * 70,
                      width: width * 80,
                      child: signUp(
                        height * 70,
                        width * 80,
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: ClipPath(
                      clipper: UpperDiagonalClipPart(),
                      child: Container(
                          decoration: BoxDecoration(
                            color: Color(0xffc50ebd),
                          ),
                          height: height * 70,
                          width: width * 80,
                          child: Container(
                            height: height * 70,
                            width: width * 80,
                            alignment: Alignment.topRight,
                            child: Container(
                              padding: EdgeInsets.only(
                                  top: height * 70 / 16, right: width * 1.3),
                              height: ((height * 70) / 2),
                              alignment: Alignment.topRight,
                              child: InkWell(
                                child: Container(
                                  padding: EdgeInsets.all(5),
                                  child: AnimatedBuilder(
                                    animation: _animation1,
                                    builder: (context, child) {
                                      return Transform.rotate(
                                        angle: _animation1.value,
                                        child: Icon(
                                          Icons.arrow_downward,
                                          color: Colors.white,
                                          size: 20,
                                        ),
                                      );
                                    },
                                  ),
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.black),
                                ),
                                onTap: () async {
                                  _animationController1.reverse();
                                  _userNameController.clear();
                                  _passwordController.clear();
                                  _confirmPasswordController.clear();
                                  _pageController.animateToPage(0,
                                      duration: Duration(seconds: 1),
                                      curve: Curves.ease);
                                },
                              ),
                            ),
                          ))),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget circularLoginWidget(String logoPath, Function onTap) {
    return Container(
      decoration: widget.thirdPartyLoginDecoration ??
          BoxDecoration(
              color: Colors.transparent,
              boxShadow: [
                BoxShadow(
                    color: Colors.black,
                    offset: Offset(2, 0),
                    blurRadius: 0,
                    spreadRadius: 0.5)
              ],
              shape: BoxShape.circle),
      child: CircleAvatar(
        radius: 25,
        backgroundColor: Colors.white,
        child: InkWell(
          onTap: onTap,
          child: Image.asset(
            logoPath,
            fit: BoxFit.cover,
            height: 30,
          ),
        ),
      ),
    );
  }

  Widget signUp(double h, double w) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Container(
          height: (h - (h) / 1.75),
          padding: EdgeInsets.only(top: h / 12, left: w / 26),
        ),
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    TextField(
                      controller: _userNameController,
                      autofocus: false,
                      style: _textTextStyle,
                      cursorColor: Colors.white,
                      decoration: InputDecoration(
                          focusedBorder: InputBorder.none,
                          border: InputBorder.none,
                          suffixStyle: TextStyle(color: Colors.white),
                          icon: Icon(
                            Icons.mail_outline,
                            color: _iconColor,
                          ),
                          hintStyle: _hintTextStyle,
                          hintText: widget.usernameHintText ?? 'Username'),
                    ),
                    Divider(
                      height: 1,
                      color: Colors.white,
                    ),
                  ],
                ),
                Column(
                  children: <Widget>[
                    TextField(
                      obscureText: _obscure1,
                      controller: _passwordController,
                      autofocus: false,
                      cursorColor: Colors.white,
                      style: _textTextStyle,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          focusColor: Colors.black,
                          suffixIcon: InkWell(
                            child: Icon(
                                (_obscure1)
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: _iconColor),
                            onTap: () {
                              _obscure1 = !_obscure1;
                              setState(() {});
                            },
                          ),
                          hintStyle: _hintTextStyle,
                          icon: Icon(Icons.lock_outline, color: Colors.white70),
                          hintText: widget.passwordHintText ?? 'Password'),
                    ),
                    Divider(
                      height: 1,
                      color: Colors.white,
                    ),
                  ],
                ),
                Column(
                  children: <Widget>[
                    TextField(
                      obscureText: _obscure2,
                      controller: _confirmPasswordController,
                      autofocus: false,
                      cursorColor: Colors.white,
                      style: _textTextStyle,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          focusColor: Colors.white,
                          suffixIcon: InkWell(
                            child: Icon(
                              (_obscure2)
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: _iconColor,
                            ),
                            onTap: () {
                              _obscure2 = !_obscure2;
                              setState(() {});
                            },
                          ),
                          icon: Icon(Icons.lock_outline, color: _iconColor),
                          hintStyle: _hintTextStyle,
                          hintText: widget.confirmPasswordHintText ??
                              'Confirm Password'),
                    ),
                    Divider(
                      height: 1,
                      color: Colors.white,
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 2.0),
                  child: Align(
                    alignment: Alignment.center,
                    child: Container(
                        width: double.maxFinite,
                        child: RaisedButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(35),
                            ),
                            color: Colors.white,
                            child: Text(
                              widget.signUpButtonText ?? 'Sign Up',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 17),
                            ),
                            onPressed: () {
                              widget.onSignUpButton(
                                  _userNameController.text,
                                  _passwordController.text,
                                  _confirmPasswordController.text);
                            })),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget loginPage(double h, double w) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: 15,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    TextField(
                      controller: _userNameController,
                      autofocus: false,
                      style: _textTextStyle,
                      cursorColor: Colors.white,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          icon: Icon(
                            Icons.mail_outline,
                            color: _iconColor,
                          ),
                          hintStyle: _hintTextStyle,
                          hintText: widget.usernameHintText ?? 'Username'),
                    ),
                    Divider(
                      height: 1,
                      color: Colors.white,
                    ),
                  ],
                ),
                Column(
                  children: <Widget>[
                    TextField(
                      obscureText: _obscure,
                      controller: _passwordController,
                      autofocus: false,
                      style: _textTextStyle,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          suffixIcon: InkWell(
                            child: Icon(
                              (_obscure)
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: _iconColor,
                              size: 25,
                            ),
                            onTap: () {
                              _obscure = !_obscure;
                              setState(() {});
                            },
                          ),
                          icon: Icon(
                            Icons.lock_outline,
                            color: _iconColor,
                          ),
                          hintStyle: _hintTextStyle,
                          hintText: widget.passwordHintText ?? 'Password'),
                    ),
                    Divider(
                      height: 1,
                      color: Colors.white,
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    width: double.maxFinite,
                    child: RaisedButton(
                        splashColor: Color(0xffff00cc),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(35),
                        ),
                        color: Color(0xfffc4a1a),
                        child: Text(
                          widget.loginButtonText ?? 'Login',
                          style: TextStyle(color: Colors.white, fontSize: 17),
                        ),
                        onPressed: () {
                          widget.onLoginButton(
                            _userNameController.text,
                            _passwordController.text,
                          );
                        }),
                  ),
                ),
                Align(
                    alignment: Alignment.center,
                    child: InkWell(
                      onTap: () {
                        widget.onForgotPassword(_userNameController.text);
                      },
                      child: Text(
                        'Forgot Password?',
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: Colors.white70,
                            fontSize: 12,
                            decorationStyle: TextDecorationStyle.solid),
                      ),
                    )),
              ],
            ),
          ),
        ),
        Container(
          height: h - (h / 1.75),
        )
      ],
    );
  }
}
