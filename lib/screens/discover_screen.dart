import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:untitled2/genre.dart';
import 'package:untitled2/shows.dart';
import 'package:untitled2/GenreTab.dart';
import 'package:flutter/material.dart';
import 'package:untitled2/search.dart';
import 'package:untitled2/shows.dart';
import 'package:untitled2/screens/home.dart';
import 'package:untitled2/widgets/bottom_navigation_bar.dart';

import '../model/model.dart';

var userid = "Demo";

class discoverscreen extends StatefulWidget {

  static const String id='discover_screen';
  const discoverscreen({Key? key}) : super(key: key);

  @override
  State<discoverscreen> createState() => _discoverscreenState();
}

class _discoverscreenState extends State<discoverscreen> {

  final GlobalKey<NavigatorState> _newsNavigatorKey = GlobalKey<NavigatorState>();

  Future<void> activeuser() async {
    await FirebaseFirestore.instance.collection("users").doc(user?.uid)
        .get()
        .then((value) {
      currentuser = UserModel.fromMap(value.data());
    });
    setState(() {


    });
  }

  User? user = FirebaseAuth.instance.currentUser;
  UserModel currentuser = UserModel();

  Widget drawer(BuildContext context) {
    {
      Future<void> signOut() async {
        await FirebaseAuth.instance.signOut();
        GoRouter.of(context).replace('/l');
      }

      activeuser();


      return Drawer(

          child:Container(
              color:Color.fromRGBO(17, 26, 41, 1),
              padding: EdgeInsets.fromLTRB(10, 60, 0, 0),

              child: Column(

                children: <Widget>[ListTile(
                    leading: CircleAvatar(
                        child: Icon(CupertinoIcons.person, color: Colors.white)),
                    title: Text('${currentuser.username}',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),)

                ),
                  SizedBox(height: 40),


                  ListTile(leading:Icon(Icons.recommend,color: Colors.white,),title:Text("Recommendation",style:TextStyle(color:Colors.white,)),onTap: (){},),
                  ListTile(leading:Icon(Icons.favorite,color: Colors.white,),title:Text("Favourites",style:TextStyle(color:Colors.white)),onTap: (){},),
                  ListTile(leading:Icon(Icons.logout,color: Colors.white,),title:Text("Logout",style: TextStyle(color: Colors.white,)),onTap: (){signOut();},),

                ],)
          )



      );
    }
  }
  @override
  Widget build(BuildContext context) {

    return DefaultTabController(length: 2,
           child:Scaffold(
               drawer:drawer(context),
    appBar: AppBar(

    title: Text("Discover"),
    actions: <Widget>[IconButton(onPressed: ()
    {
    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context){
    return Search();
    }));
    },
    icon: Icon(Icons.search))],
    backgroundColor: Color.fromRGBO(17, 26, 41, 1),),
             body:Container(
               color: Color.fromRGBO(17, 26, 41, 1),
               child: Column(

                 children: [TabBar(tabs: [
                   Tab(
                     child: Center(child: (Text('Shows',style: TextStyle(fontSize: 12),))),
                   ),
                   Tab(
                     child: Center(child: (Text('Genre',style: TextStyle(fontSize: 12),))),
                   ),


                 ]),

                   Expanded(child: TabBarView(children: [
                     // shows tab
                     Container(
                       child:showsScreen(),)
                     ,
                     //genre tab
                     Container(
                         child:GenreTab(),)
                     ,

                     //categories tab
                     Container(
                         child:Text('Categories tab')
                     ),

                     //character tab
                     Container(
                         child:Center(child: Text('Characters tab'),)
                     ),
                   ],))

                 ],
               ),
             ),

           )
    );
  }
}




