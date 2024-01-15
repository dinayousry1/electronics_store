import 'package:electronics_store/constant.dart';
import 'package:electronics_store/screens/admin/adminHome.dart';
import 'package:electronics_store/screens/signup.dart';
import 'package:electronics_store/screens/user/homePage.dart';
import 'package:electronics_store/widgets/custom_textfield.dart';
import 'package:electronics_store/services/auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:electronics_store/provider/adminMode.dart';
import 'package:electronics_store/provider/modelHud.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  static String id = 'Login';
  final GlobalKey<FormState> globalKey = GlobalKey<FormState>();

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late String _email, _password;

  final _auth = Auth();

  bool isAdmin = false;

  final adminPassword = 'admin1234';

  bool keepMeLoggedIn = false;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: Provider.of<ModelHud>(context).isLoading,
        child: Form(
          key: widget.globalKey,
          child: ListView(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 50),
                child: Container(
                  height: MediaQuery.of(context).size.height * .2,
                  child: Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      Image(
                        image: AssetImage('images/icons/ll.png'),
                      ),
                      Positioned(
                        bottom: 0,
                        child: Text(
                          'Electronics',
                          style: TextStyle(
                            fontFamily: 'Raleway',
                            fontSize: 30,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: height * .1,
              ),
              CustomTextField(
                onClick: (value) {
                  _email = value;
                },
                hint: 'Enter your email',
                icon: Icons.email,
              ),
              Padding(
                padding: EdgeInsets.only(left: 20),
                child: Row(
                  children: <Widget>[
                    Theme(
                      data: ThemeData(unselectedWidgetColor: Colors.black),
                      child: Checkbox(
                        checkColor: Colors.blue.shade300,
                        activeColor: Colors.white,
                        value: keepMeLoggedIn,
                        onChanged: (value) {
                          setState(() {
                            keepMeLoggedIn = value!;
                          });
                        },
                      ),
                    ),
                    Text(
                      'Remmeber Me ',
                      style: TextStyle(color: Colors.black),
                    )
                  ],
                ),
              ),
              CustomTextField(
                onClick: (value) {
                  _password = value;
                },
                hint: 'Enter your password',
                icon: Icons.lock,
              ),
              SizedBox(
                height: height * .05,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 120),
                child: Builder(
                  builder: (context) => TextButton(
                      style: TextButton.styleFrom(
                          backgroundColor: Colors.blue.shade300,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          )),
                      onPressed: () {
                        if (keepMeLoggedIn == true) {
                          keepUserLoggedIn();
                        }
                        _validate(context);
                      },
                      child: Text(
                        'Login',
                        style: TextStyle(color: Colors.white),
                      )),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Don\'t have an account ? ',
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, Signup.id);
                    },
                    child: Text(
                      'Sign up ',
                      style:
                          TextStyle(color: Colors.blue.shade300, fontSize: 16),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Provider.of<AdminMode>(context, listen: false)
                              .changeIsAdmin(true);
                        },
                        child: Text(
                          'iam an admin',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Provider.of<AdminMode>(context).isAdmin
                                  ? Colors.white
                                  : Colors.black),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Provider.of<AdminMode>(context, listen: false)
                              .changeIsAdmin(false);
                        },
                        child: Text(
                          'iam a user',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Provider.of<AdminMode>(context).isAdmin
                                  ? Colors.black
                                  : Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _validate(BuildContext context) async {
    {
      final modelhud = Provider.of<ModelHud>(context, listen: false);
      modelhud.changeisLoading(true);
      if (widget.globalKey.currentState!.validate()) {
        widget.globalKey.currentState?.save();
        if (Provider.of<AdminMode>(context, listen: false).isAdmin) {
          if (_password == adminPassword) {
            try {
              await _auth.signIn(_email, _password);
              Navigator.pushNamed(context, AdminHome.id);
            } on FirebaseAuthException catch (e) {
              modelhud.changeisLoading(false);
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(
                e.message.toString(),
              )));
            }
          } else {
            modelhud.changeisLoading(false);
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('something went wrong !'),
            ));
          }
        } else {
          try {
            await _auth.signIn(_email, _password);
            Navigator.pushNamed(context, HomePage.id);
          } on FirebaseAuthException catch (e) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(
              e.message.toString(),
            )));
          }
        }
      }
      modelhud.changeisLoading(false);
    }
  }

  void keepUserLoggedIn() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool(kKeepMeLoggedIn, keepMeLoggedIn);
  }
}
