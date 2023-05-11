import 'package:untitled2/genre.dart';
import 'package:untitled2/shows.dart';
import 'package:untitled2/GenreTab.dart';

import 'package:flutter/material.dart';
import 'package:untitled2/search.dart';
import 'package:untitled2/shows.dart';
import 'package:untitled2/screens/home.dart';
import 'package:untitled2/widgets/bottom_navigation_bar.dart';


class discoverscreen extends StatefulWidget {
  static const String id='discover_screen';
  const discoverscreen({Key? key}) : super(key: key);

  @override
  State<discoverscreen> createState() => _discoverscreenState();
}

class _discoverscreenState extends State<discoverscreen> {


  @override
  Widget build(BuildContext context) {
    return DefaultTabController(length: 4,
           child:Scaffold(
    appBar: AppBar(
        leading:Icon(Icons.menu),
    title: Text("Discover"),
    actions: <Widget>[IconButton(onPressed: ()
    {
    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context){
    return search();
    }));
    },
    icon: Icon(Icons.search))],
    backgroundColor: Color.fromRGBO(17, 26, 41, 0.9),),



             body:Container(
               color: Color.fromRGBO(17, 26, 41, 0.9),
               child: Column(

                 children: [TabBar(tabs: [
                   Tab(
                     child: Center(child: (Text('Shows',style: TextStyle(fontSize: 12),))),
                   ),
                   Tab(
                     child: Center(child: (Text('Genre',style: TextStyle(fontSize: 12),))),
                   ),
                   Tab(
                     child: Center(child: (Text('Categories',style: TextStyle(fontSize: 12),))),
                   ),
                   Tab(
                     child: Center(child: (Text('Characters',style: TextStyle(fontSize: 12),))),
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