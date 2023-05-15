import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:untitled2/model/model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:go_router/go_router.dart';
import 'login.dart';
class RegistrationScreen extends StatefulWidget{
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}
class _RegistrationScreenState extends State<RegistrationScreen> {
  final GlobalKey<NavigatorState> _registrationNavigatorKey = GlobalKey<NavigatorState>();

  //our form key
  final _formKey = GlobalKey<FormState>();
  //editing Controller
  final userNameEditingController = new TextEditingController();
  final emailEditingController = new TextEditingController();
  final passwordEditingController = new TextEditingController();
  final confirmPasswordEditingController = new TextEditingController();

  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    final userName = TextFormField(
      autofocus: false,
      controller: userNameEditingController,
      keyboardType: TextInputType.emailAddress,
      onSaved: (String ? value) {
        userNameEditingController.text = value!;
      },
      validator: (value) {
        if (value!.isEmpty) {
          return ("Please enter your username");
        }
        else {
          return null;
        }
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.account_circle),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "User Name",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        filled: true,
        fillColor: Colors.white,

      ),
    );
    final emailField = TextFormField(
      autofocus: false,
      controller: emailEditingController,
      keyboardType: TextInputType.emailAddress,
      onSaved: (String ? value) {
        emailEditingController.text = value!;
      },
      validator: (value) {
        if (value!.isEmpty) {
          return ("Please enter your email");
        }
        else if (!RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
            .hasMatch(value)) {
          return ("Please enter a valid email address");
        }
        else {
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
      controller: passwordEditingController,
      keyboardType: TextInputType.emailAddress,
      onSaved: (String ? value) {
        passwordEditingController.text = value!;
      },
      validator: (value) {
        RegExp regex =
        RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
        if (value!.isEmpty) {
          return ("Please enter your password");
        }
      /*  else if (!regex.hasMatch(value)) {
          return ("Password length is too short");
        }*/
        else {
          return null;
        }
      },
      obscureText: true,
      textInputAction: TextInputAction.next,
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
    final confirmPasswordField = TextFormField(
      autofocus: false,
      controller: confirmPasswordEditingController,
      keyboardType: TextInputType.emailAddress,
      onSaved: (String ? value) {
        confirmPasswordEditingController.text = value!;
      },
      validator: (value) {
        if (value != passwordEditingController.text) {
          return ("Password does not matched");
        }
        else {
          return null;
        }
      },
      obscureText: true,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.key),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Confirm Password",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        filled: true,
        fillColor: Colors.white,

      ),
    );
    final registerbutton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.blue,
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(30, 15, 30, 15),
        minWidth: MediaQuery
            .of(context)
            .size
            .width,
        onPressed: () {
          Register();
        },
        child: Text("Register", textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),),
      ),);
    return Scaffold(
        backgroundColor: Color(0xFF111A29),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,

        ),
        body: Center(
            child: SingleChildScrollView(
              child: Container(
                color: Color(0xFF111A29),
                child: Padding(
                  padding: const EdgeInsets.all(34.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,

                      children: <Widget>[
                        SizedBox(height: 200,
                          child: Image.asset(
                              "assets/logo.png", fit: BoxFit.contain),)
                        ,
                        const SizedBox(height: 35),
                        userName,
                        const SizedBox(height: 15),
                        emailField,
                        const SizedBox(height: 15),
                        passwordField,
                        const SizedBox(height: 15),
                        confirmPasswordField,
                        const SizedBox(height: 25),
                        registerbutton
                      ],
                    ),
                  ),
                ),

              ),
            )
        )


    );
  }


  void Register() async {
    try {
      if (_formKey.currentState!.validate()) {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
            email: emailEditingController.text.trim(),
            password: passwordEditingController.text.trim());

        if (userCredential != null) {
          postDetailsToFireStore();

        };
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Fluttertoast.showToast(msg: "The password is too weak");
      } else if (e.code == 'email-already-in-use') {
        Fluttertoast.showToast(msg: "Account already exist with that email");
      }
    } catch (e) {
      print(e);
    }
  }

  void postDetailsToFireStore() async{
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;

    UserModel userModel = UserModel();

    userModel.email = user!.email;
    userModel.uid = user!.uid;
    userModel.username = userNameEditingController.text;


    await firebaseFirestore.collection('users').doc(user.uid).set(userModel.toMap());



    context.go('/l');
  }


}


