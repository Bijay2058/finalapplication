import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:untitled2/list_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:go_router/go_router.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:untitled2/login.dart';
import 'package:untitled2/model/model.dart';
import 'package:go_router/go_router.dart';

// ignore_for_file: prefer_const_constructors

import 'package:untitled2/widgets/bottom_navigation_bar.dart';
import 'info_page.dart';
class HomeScreen extends StatefulWidget {


  static const String id='home';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  final GlobalKey<NavigatorState> _homeNavigatorKey = GlobalKey<NavigatorState>();
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
  List<String> dataList = [];
  List<String> dataList1 = [];
  List<String> dataList2 = [];
  List<String> dataList3 = [];
  List<String> dataList4 = [];


  List<String> dataList0 = [];
  List<String> dataList01 = [];
  List<String> dataList02 = [];
  List<String> dataList03 = [];
  List<String> dataList04 = [];

  List<String> dataList00 = [];
  List<String> dataList001 = [];
  List<String> dataList002 = [];
  List<String> dataList003 = [];
  List<String> dataList004 = [];


  void fetchDataFromwatchingCollection() async {
    CollectionReference collectionRef = FirebaseFirestore.instance
        .collection('users')
        .doc('${FirebaseAuth.instance.currentUser?.uid}')
        .collection('Watching');
    QuerySnapshot querySnapshot = await collectionRef.get();
    List<String> posterdata = [];
    List<String> movieNamedata = [];
    List<String> watchedEpisodesdata = [];
    List<String> watchedSeasonsdata = [];
    List<String> totalEpisodesdata = [];
    if (querySnapshot != null) {
      querySnapshot.docs.forEach((doc) {
        var fieldValue = (doc?.data() as Map<String, dynamic>)?['movieName'];
        if (fieldValue != null) {
          movieNamedata.add(fieldValue.toString());
        }
        var fieldValue4 = (doc?.data() as Map<String, dynamic>)?['imageUrl'];
        if (fieldValue4 != null) {
          posterdata.add(fieldValue4.toString());
        }
        var fieldValue1 = (doc?.data() as Map<String, dynamic>)?['watchedepisodes'];
        if (fieldValue1 != null) {
          watchedEpisodesdata.add(fieldValue1.toString());
        }
        var fieldValue2 = (doc?.data() as Map<String, dynamic>)?['watchedseasons'];
        if (fieldValue2 != null) {
          watchedSeasonsdata.add(fieldValue2.toString());
        }
        var fieldValue3 = (doc?.data() as Map<String, dynamic>)?['totalepisodes'];
        if (fieldValue3 != null) {
          totalEpisodesdata.add(fieldValue3.toString());
        }
      });
    }
    if(mounted) {
      setState(() {
        dataList0 = movieNamedata;
        dataList01 = watchedEpisodesdata;
        dataList02 = watchedSeasonsdata;
        dataList03 = totalEpisodesdata;
        dataList04 = posterdata;
      });
    }



  }
  void fetchDataFromLaterCollection() async {
    CollectionReference collectionRef = FirebaseFirestore.instance
        .collection('users')
        .doc('${FirebaseAuth.instance.currentUser?.uid}')
        .collection('Later');
    QuerySnapshot querySnapshot = await collectionRef.get();
    List<String> posterdata = [];
    List<String> movieNamedata = [];
    List<String> watchedEpisodesdata = [];
    List<String> watchedSeasonsdata = [];
    List<String> totalEpisodesdata = [];
    if (querySnapshot != null) {
      querySnapshot.docs.forEach((doc) {
        var fieldValue = (doc?.data() as Map<String, dynamic>)?['movieName'];
        if (fieldValue != null) {
          movieNamedata.add(fieldValue.toString());
        }
        var fieldValue4 = (doc?.data() as Map<String, dynamic>)?['imageUrl'];
        if (fieldValue4 != null) {
          posterdata.add(fieldValue4.toString());
        }
        var fieldValue1 = (doc?.data() as Map<String, dynamic>)?['watchedepisodes'];
        if (fieldValue1 != null) {
          watchedEpisodesdata.add(fieldValue1.toString());
        }
        var fieldValue2 = (doc?.data() as Map<String, dynamic>)?['watchedseasons'];
        if (fieldValue2 != null) {
          watchedSeasonsdata.add(fieldValue2.toString());
        }
        var fieldValue3 = (doc?.data() as Map<String, dynamic>)?['totalepisodes'];
        if (fieldValue3 != null) {
          totalEpisodesdata.add(fieldValue3.toString());
        }
      });
    }
    if(mounted) {
      setState(() {
        dataList00 = movieNamedata;
        dataList001 = watchedEpisodesdata;
        dataList002 = watchedSeasonsdata;
        dataList003 = totalEpisodesdata;
        dataList004 = posterdata;
      });
    }


  }
  void fetchDataFromcompletedCollection() async {
    CollectionReference collectionRef = FirebaseFirestore.instance
        .collection('users')
        .doc('${FirebaseAuth.instance.currentUser?.uid}')
        .collection('Completed');
    QuerySnapshot querySnapshot = await collectionRef.get();
    List<String> posterdata = [];
    List<String> movieNamedata = [];
    List<String> watchedEpisodesdata = [];
    List<String> watchedSeasonsdata = [];
    List<String> totalEpisodesdata = [];
    if (querySnapshot != null) {
      querySnapshot.docs.forEach((doc) {
        var fieldValue = (doc?.data() as Map<String, dynamic>)?['movieName'];
        if (fieldValue != null) {
          movieNamedata.add(fieldValue.toString());
        }
        var fieldValue4 = (doc?.data() as Map<String, dynamic>)?['imageUrl'];
        if (fieldValue4 != null) {
          posterdata.add(fieldValue4.toString());
        }
        var fieldValue1 = (doc?.data() as Map<String, dynamic>)?['watchedepisodes'];
        if (fieldValue1 != null) {
          watchedEpisodesdata.add(fieldValue1.toString());
        }
        var fieldValue2 = (doc?.data() as Map<String, dynamic>)?['watchedseasons'];
        if (fieldValue2 != null) {
          watchedSeasonsdata.add(fieldValue2.toString());
        }
        var fieldValue3 = (doc?.data() as Map<String, dynamic>)?['totalepisodes'];
        if (fieldValue3 != null) {
          totalEpisodesdata.add(fieldValue3.toString());
        }
      });
    }
if(mounted) {
  setState(() {
    dataList = movieNamedata;
    dataList1 = watchedEpisodesdata;
    dataList2 = watchedSeasonsdata;
    dataList3 = totalEpisodesdata;
    dataList4 = posterdata;
  });
}


  }





  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    activeuser();
    fetchDataFromcompletedCollection();
    fetchDataFromwatchingCollection();
    fetchDataFromLaterCollection();

    _tabController = TabController(length: 3, vsync: this);
    _tabController.animateTo(2);
  }
  static const List<Tab> _tabs = [
    Tab(child:  Text('Watching')),
    Tab( text: 'Completed'),
    Tab( text: 'Plan to Watch'),

  ];

  Widget drawer(BuildContext context) {
    {
      Future<void> signOut() async {
        await FirebaseAuth.instance.signOut();
        context.go('/l');
      }


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
    return Scaffold(
      backgroundColor:Color.fromRGBO(17, 26, 41, 1) ,
      drawer: drawer(context),
      appBar: AppBar(
        title: Text('Home'),
        backgroundColor: Color.fromRGBO(17, 26, 41, 0.9),
        bottom: TabBar(
            isScrollable: true,
            controller: _tabController,
            tabs:_tabs
        ),
      ),
      body:  Consumer3<MovieListProvider,completedMovieListProvider,laterMovieListProvider>(builder:((context,movieProviderModel,completedMovieProviderModel,laterMovieProviderModel,child) =>TabBarView(
          controller: _tabController,
          children:[

            ListView.builder(itemCount: dataList0.length,itemBuilder: (BuildContext context, int index) {
              return  TextButton(
                onPressed: () => Navigator.pushNamed(context, InfoPage.id),
                child: Column(
                  children: [
                    MyContainer(image:dataList04[index].toString(), text:  dataList0[index],watchedepisode: dataList01[index],totalepisode: dataList03[index],watchedseason: dataList02[index],)

                  ],
                ),
              );
            }),

            ListView.builder(itemCount: dataList.length,itemBuilder: (BuildContext context, int index) {
              return  TextButton(
                onPressed: () => Navigator.pushNamed(context, InfoPage.id),
                child: Column(
                  children: [
                    MyContainer(image:dataList4[index].toString(), text:  dataList[index],watchedepisode: dataList1[index],totalepisode: dataList3[index],watchedseason: dataList2[index],)

                  ],
                ),
              );
            }),
            ListView.builder(itemCount: dataList00.length,itemBuilder: (BuildContext context, int index) {
              return  TextButton(
                onPressed: () => Navigator.pushNamed(context, InfoPage.id),
                child: Column(
                  children: [
                    MyContainer(image:dataList004[index].toString(), text:  dataList00[index],watchedepisode: dataList001[index],totalepisode: dataList003[index],watchedseason: dataList002[index],)

                  ],
                ),
              );
            }),




            /*  ListView.builder(itemCount: completedMovieProviderModel.names.length,itemBuilder: (BuildContext context, int index) {
              return  TextButton(
                onPressed: () => Navigator.pushNamed(context, InfoPage.id),
                child: Column(
                  children: [
                    MyContainer(image:completedMovieProviderModel.posters[index], text:  completedMovieProviderModel.names[index],watchedepisode: completedMovieProviderModel.watchedepisodes[index],totalepisode: completedMovieProviderModel.totalepisodes[index],watchedseason: completedMovieProviderModel.watchedseasons[index],)

                  ],
                ),
              );
            }),*/





          /*  ListView.builder(itemCount: laterMovieProviderModel.names.length,itemBuilder: (BuildContext context, int index) {
              return  TextButton(
                onPressed: () => Navigator.pushNamed(context, InfoPage.id),
                child: Column(
                  children: [
                    MyContainer(image:laterMovieProviderModel.posters[index], text:  laterMovieProviderModel.names[index],watchedepisode: laterMovieProviderModel.watchedepisodes[index],totalepisode: laterMovieProviderModel.totalepisodes[index],watchedseason: laterMovieProviderModel.watchedseasons[index],)

                  ],
                ),
              );
            }),*/








          ]))),

    );
  }
}




class MyContainer extends StatefulWidget {
  final String image;
  final String text;
  final String watchedepisode,totalepisode,watchedseason;
  // final Function onOptionTap;
  final double progress;


  const MyContainer({
    Key? key,
    required this.image,
    required this.text,
    required this.watchedepisode,
    required this.totalepisode,
    required this.watchedseason,

    // this.onOptionTap,
    this.progress = 0
  }) : super(key: key);


  @override
  State<MyContainer> createState() => _MyContainerState();
}

class _MyContainerState extends State<MyContainer> {
  int count =100000000;
  @override
  Widget build(BuildContext context) {

    return Consumer3<MovieListProvider,completedMovieListProvider,laterMovieListProvider>(builder:((context,movieProviderModel,completedMovieProviderModel,laterMovieProviderModel,child)=>TextButton(
      onPressed: () => Navigator.pushNamed(context, InfoPage.id),
      child: Container(
          margin: EdgeInsets.all(5.0),
          height: 100,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            color: Color.fromRGBO(23, 34, 51, 0.6),
            borderRadius: BorderRadius.all(
              Radius.circular(15),
            ),
            boxShadow: [
              BoxShadow(
                // color: Color.fromARGB(255, 63, 62, 62), //New
                  blurRadius: 15.0,
                  offset: Offset(0, -10))
            ],
          ),
          child: Row(children: [
            Image(

              image: NetworkImage(widget.image),
              height: 100.0,
              width: 100.0,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.text,
                    style: TextStyle(fontSize: 25, color: Colors.white),
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text('S${widget.watchedseason}   EP ${widget.watchedepisode}/${widget.totalepisode}', style: TextStyle(fontSize: 15, color: Colors.white)),
                  SizedBox(
                    height: 5,
                  ),
                  LinearProgressIndicator(
                    minHeight: 10,
                    value: int.parse(widget.watchedepisode)/int.parse(widget.totalepisode),
                    backgroundColor: Colors.grey[300],
                    valueColor: AlwaysStoppedAnimation(Colors.blue),
                  ),
                ],
              ),
            ),
            Align(

                alignment: Alignment.topRight,
                child:IconButton(
                  onPressed: () async {


                    CollectionReference collectionRef = FirebaseFirestore.instance
                        .collection('users')
                        .doc(FirebaseAuth.instance.currentUser?.uid)
                        .collection('Completed');

                    CollectionReference collectionRef1 = FirebaseFirestore.instance
                        .collection('users')
                        .doc(FirebaseAuth.instance.currentUser?.uid)
                        .collection('Watching');

                    CollectionReference collectionRef2= FirebaseFirestore.instance
                        .collection('users')
                        .doc(FirebaseAuth.instance.currentUser?.uid)
                        .collection('Later');


                    QuerySnapshot querySnapshot = await collectionRef.get();
                    QuerySnapshot querySnapshot1 = await collectionRef1.get();
                    QuerySnapshot querySnapshot2 = await collectionRef2.get();

                    querySnapshot.docs.forEach((doc) {
                      var data = doc.data() as Map<String, dynamic>;
                      if (data['movieName'] == widget.text) {
                        doc.reference.delete();
                      }
                    });

                    querySnapshot1.docs.forEach((doc) {
                      var data = doc.data() as Map<String, dynamic>;
                      if (data['movieName'] == widget.text) {
                        doc.reference.delete();
                      }
                    });

                    querySnapshot2.docs.forEach((doc) {
                      var data = doc.data() as Map<String, dynamic>;
                      if (data['movieName'] == widget.text) {
                        doc.reference.delete();
                      }
                    });

                    GoRouter.of(context).refresh();






                      if(laterMovieProviderModel.names.contains(widget.text)==true)
                      {





                              laterMovieProviderModel.pop(widget.text,'0','0',widget.image,widget.totalepisode);
                              GoRouter.of(context).refresh();


                    }

                      if(completedMovieProviderModel.names.contains(widget.text)==true)
                      {





                        completedMovieProviderModel.pop(widget.text,widget.watchedseason,widget.watchedepisode,widget.image,widget.totalepisode);
                        GoRouter.of(context).refresh;



                      }


                      if(movieProviderModel.names.contains(widget.text)==true)
                      {





                        movieProviderModel.pop(widget.text,widget.watchedseason,widget.watchedepisode,widget.image,widget.totalepisode);
                        GoRouter.of(context).refresh;
                        Navigator.pushNamed(context,HomeScreen.id[0]);

                      }

                  },
                    icon: Icon(Icons.delete),color:Colors.blue),
                )

              //  IconButton(
              //   iconSize: 50,
              //   icon: Icon(Icons.more_vert),
              //   onPressed: () {},
              //   // onOptionTap,

          ]
          )),
    )));
  }
}



