import 'package:electronics_store/screens/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:electronics_store/services/auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:electronics_store/provider/modelHud.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import '../widgets/custom_textfield.dart';

class Signup extends StatelessWidget {
  static String id = 'Signup';
  final _globalKey = GlobalKey<FormState>();
  late String _email, _password;
  final _auth = Auth();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: Provider.of<ModelHud>(context).isLoading,
        child: Form(
          key: _globalKey,
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
                  onClick: (value) {},
                  icon: Icons.perm_identity,
                  hint: 'Enter your name'),
              SizedBox(
                height: height * .02,
              ),
              CustomTextField(
                onClick: (value) {
                  _email = value;
                },
                hint: 'Enter your email',
                icon: Icons.email,
              ),
              SizedBox(
                height: height * .02,
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
                      onPressed: () async {
                        final modelhud =
                            Provider.of<ModelHud>(context, listen: false);
                        modelhud.changeisLoading(true);
                        if (_globalKey.currentState!.validate()) {
                          _globalKey.currentState?.save();
                          print(_email);
                          print(_password);
                          try {
                            final authResult = await _auth.signUp(
                                _email.trim(), _password.trim());
                            modelhud.changeisLoading(false);
                            Navigator.pushNamed(context, Login.id);
                          } on FirebaseAuthException catch (e) {
                            print(e.toString());
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(
                                e.message.toString(),
                              ),
                            ));
                          }

                          //print(authResult.user?.uid);
                        }
                        modelhud.changeisLoading(false);
                      },
                      child: Text(
                        'Signup',
                        style: TextStyle(color: Colors.white),
                      )),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Don have an account ? ',
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, Login.id);
                    },
                    child: Text(
                      'Log in ',
                      style:
                          TextStyle(color: Colors.blue.shade300, fontSize: 16),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
