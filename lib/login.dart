import 'package:flutter/material.dart';
import 'package:untitled2/register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'screens/home.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatefulWidget{
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<NavigatorState> _loginNavigatorKey = GlobalKey<NavigatorState>();
  //FORM KEY
  final _formKey = GlobalKey<FormState>();

  //CONTROLLER
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final emailField = TextFormField(
      autofocus: false,
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      onSaved: (value) {
        emailController.text = value!;
      },
      validator:(value)
      {
        if(value!.isEmpty)
          {
            return("Please enter your email");
          }
        else if(!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
            .hasMatch(value))
          {
            return("Please enter a valid email address");
          }
        else
          {
            return null;
          }
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.mail),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Email",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        filled: true,
        fillColor: Colors.white,

      ),
    );
    final passwordField = TextFormField(
      autofocus: false,
      controller: passwordController,
      onSaved: (value) {
        passwordController.text = value!;

      },
      validator:(value)
      {
        RegExp regex =
        RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
        if(value!.isEmpty)
        {
          return("Please enter your password");
        }
       /* else if(!regex.hasMatch(value))
        {
          return("Password length is too short");
        }*/
        else{
          return null;
        }
      },
      obscureText: true,
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.key),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Password",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),

        ),
        filled: true,
        fillColor: Colors.white,


      ),

    );


    final loginbutton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.blue,
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery
            .of(context)
            .size
            .width,
        onPressed: () {
          signIn();
        },
        child: Text("Login", textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),),
      ),);

    return Scaffold(
        backgroundColor: Color(0xFF111A29),
        body: Center(
            child: SingleChildScrollView(
              child: Container(
                color: Color(0xFF111A29),
                child: Padding(
                  padding: const EdgeInsets.all(36.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,

                      children: <Widget>[
                        SizedBox(height: 200,
                          child: Image.asset(
                              "assets/logo.png", fit: BoxFit.contain),),
                        const SizedBox(height: 55),
                        emailField,
                        const SizedBox(height: 25),
                        passwordField,
                        const SizedBox(height: 35),
                        loginbutton,
                        const SizedBox(height: 15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text("Dont Have an account?", style: TextStyle(
                                color: Colors.white),),
                            GestureDetector(onTap: () {
                            context.go('/r');
                            }
                              ,
                              child: Text('Sign Up', style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15),),)
                          ],
                        )
                      ],
                    ),
                  ),
                ),

              ),
            )
        )


    );
  }


  void signIn() async {
    try {
      if(_formKey.currentState!.validate())
        {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim()
      );
      if(credential!=null)
        {
         context.go('/a');
        }
    }} on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Fluttertoast.showToast(msg:"Email not registered");
      } else if (e.code == 'wrong-password') {
        Fluttertoast.showToast(msg: "Password is incorrect");
      }


      }
    }
  }

