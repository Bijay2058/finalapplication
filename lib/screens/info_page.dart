// ignore_for_file: prefer_const_constructors



import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:untitled2/list_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/model.dart';

class InfoPage extends StatefulWidget {
  static const String id = 'info_page';
  final name,description,rating,banner,poster,movie_id;
  const InfoPage({Key? key,required this.name,this.description,this.rating,this.banner,this.poster,this.movie_id}) : super(key: key);

  @override
  State<InfoPage> createState() => _InfoPageState(name,description,rating,poster,movie_id);
}

class _InfoPageState extends State<InfoPage> {
  String name,description,rating,poster,movie_id;
  _InfoPageState(this.name,this.description,this.rating,this.poster,this.movie_id);
  int selectedIndex = -1;
  int selectedIndex1  = -1;
  var episode=1,season=1;
  final _auth = FirebaseAuth.instance;

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








    getepisodes() async{

    var response = await Dio().get("https://api.themoviedb.org/3/tv/${movie_id}?api_key=231880c8395d2256effb0912ef9f9888");

    if(response.statusCode==200)
    {

      if(mounted) {
        setState(() {
          season = response.data["number_of_seasons"];
          episode = response.data["number_of_episodes"];
        }
        );
      }

    }
    else
    {
      print("Not sucessful");
    }

  }
 List<String> laterMoviesCollection =[];
  Future<void> fetchLaterMoviesCollection() async {
     List <String> latermovies=[];
    CollectionReference collectionRef = FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection('Later');


    QuerySnapshot querySnapshot = await collectionRef.get();



    querySnapshot.docs.forEach((doc) {
      var data = (doc.data() as Map<String, dynamic>)?['movieName'];
      latermovies.add(data);
      print(latermovies);

      setState(() {
        laterMoviesCollection = latermovies;
      });
  });
         }


















  @override
  Widget build(BuildContext context) {
    getepisodes();
    fetchLaterMoviesCollection();

    return Scaffold(
      backgroundColor: Color.fromRGBO(17, 26, 41, 1),
      body: Consumer3<MovieListProvider,completedMovieListProvider,laterMovieListProvider>(
        builder:((context,MovieProviderModel,completedMovieProviderModel,laterMovieProviderList,child)=> CustomScrollView(
          slivers: [
            SliverAppBar(
                title: Text(
                  widget.name,
                  overflow: TextOverflow.ellipsis,
                ),
                bottom: PreferredSize(
                  //You can change the height of app bar by increasing or decreasing the preferred size
                    preferredSize: Size.fromHeight(60),
                    child: Container(
                      color: Color.fromRGBO(17, 26, 41, 1),
                      width: double.maxFinite,
                      padding: EdgeInsets.only(top: 5, bottom: 10),
                      //TO:DO: add  button to the column widget and ro change the text
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                InkWell(
                                  onTap:() async {



                                    if(laterMoviesCollection.contains (name) !=true)
                                      {




                                    String? userId = user?.uid;

                                    // Here we get the document reference for current user

                                    DocumentReference userRef = FirebaseFirestore.instance.collection('users').doc(userId);



                                    CollectionReference laterMoviesRef = userRef.collection('Later');

                                    laterMoviesRef.add({'id':movie_id,'imageUrl':poster,'movieName': name,"totalepisodes":episode.toString(),"watchedseasons":(selectedIndex+1).toString(),'watchedepisodes':(selectedIndex1+1).toString()});

                                      }
                                    else
                                      {


                                        CollectionReference collectionRef = FirebaseFirestore.instance
                                            .collection('users')
                                            .doc(FirebaseAuth.instance.currentUser?.uid)
                                            .collection('Later');


                                        QuerySnapshot querySnapshot = await collectionRef.get();



                                        querySnapshot.docs.forEach((doc) {
                                          var data = doc.data() as Map<String, dynamic>;
                                          if (data['movieName'] == name) {
                                            doc.reference.delete();
                                          }

                                        });


                                      }
                                    },
                                  child: Icon(
                                    Icons.movie,
                                    size: 30.0,
                                    color: laterMoviesCollection.contains(name)==true?Colors.blue:Colors.white,
                                  ),
                                ),
                                Text('Watch Later',
                                    style: TextStyle(color: Colors.white))
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Icon(
                                  Icons.smart_display,
                                  size: 30.0,
                                  color: Colors.white,
                                ),
                                Text('Season',
                                    style: TextStyle(color: Colors.white))
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Icon(
                                  Icons.visibility,
                                  size: 30.0,
                                  color: Colors.white,
                                ),
                                Text('Episodes',
                                    style: TextStyle(color: Colors.white))
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Icon(
                                  Icons.star,
                                  size: 30.0,
                                  color: Colors.white,
                                ),
                                Text(
                                  'Rate',
                                  style: TextStyle(color: Colors.white),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    )),
                pinned: true,
                backgroundColor: Color.fromRGBO(17, 26, 41, 1),
                expandedHeight: 300,
                flexibleSpace: FlexibleSpaceBar(
                    background: Image.network(
                      widget.banner,
                      width: double.maxFinite,
                      fit: BoxFit.cover,
                    ))),
            SliverToBoxAdapter(
              child: Container(
                  margin: EdgeInsets.only(left: 20.0, right: 20.0),
                  // Dimensions.width20
                  // child: Text(
                  //   'Parents need to know that Breaking Bad isnoot intended for kids. Its intense, morally ambiguous characters and storylines are meant for mature audiences. Main character Walter White (Bryan Cranston) starts out as an essentially good person who\'s driven to extreme negative behavior (manufacturing methamphetamines and more) by depression and desperation. Over the course of the show, his good side becomes less and less evident as he eventually turns into a drug lord. There\'s a good bit of swearing (including "f--k"), frequent violence (sometimes extremely graphic), and some sexual content (a woman is shown topless; intercourse, sex work, and oral sex are implied but not shown). Latino characters perpetuate stereotypes, and women are portrayed as nagging. The making and abuse of drugs are core to the series.Parents need to know that Breaking Bad isnoot intended for kids. Its intense, morally ambiguous characters and storylines are meant for mature audiences. Main character Walter White (Bryan Cranston) starts out as an essentially good person who\'s driven to extreme negative behavior (manufacturing methamphetamines and more) by depression and desperation. Over the course of the show, his good side becomes less and less evident as he eventually turns into a drug lord. There\'s a good bit of swearing (including "f--k"), frequent violence (sometimes extremely graphic), and some sexual content (a woman is shown topless; intercourse, sex work, and oral sex are implied but not shown). Latino characters perpetuate stereotypes, and women are portrayed as nagging. The making and abuse of drugs are core to the seriesParents need to know that Breaking Bad isnoot intended for kids. Its intense, morally ambiguous characters and storylines are meant for mature audiences. Main character Walter White (Bryan Cranston) starts out as an essentially good person who\'s driven to extreme negative behavior (manufacturing methamphetamines and more) by depression and desperation. Over the course of the show, his good side becomes less and less evident as he eventually turns into a drug lord. There\'s a good bit of swearing (including "f--k"), frequent violence (sometimes extremely graphic), and some sexual content (a woman is shown topless; intercourse, sex work, and oral sex are implied but not shown). Latino characters perpetuate stereotypes, and women are portrayed as nagging. The making and abuse of drugs are core to the series.Parents need to know that Breaking Bad isnoot intended for kids. Its intense, morally ambiguous characters and storylines are meant for mature audiences. Main character Walter White (Bryan Cranston) starts out as an essentially good person who\'s driven to extreme negative behavior (manufacturing methamphetamines and more) by depression and desperation. Over the course of the show, his good side becomes less and less evident as he eventually turns into a drug lord. There\'s a good bit of swearing (including "f--k"), frequent violence (sometimes extremely graphic), and some sexual content (a woman is shown topless; intercourse, sex work, and oral sex are implied but not shown). Latino characters perpetuate stereotypes, and women are portrayed as nagging. The making and abuse of drugs are core to the seriesParents need to know that Breaking Bad isnoot intended for kids. Its intense, morally ambiguous characters and storylines are meant for mature audiences. Main character Walter White (Bryan Cranston) starts out as an essentially good person who\'s driven to extreme negative behavior (manufacturing methamphetamines and more) by depression and desperation. Over the course of the show, his good side becomes less and less evident as he eventually turns into a drug lord. There\'s a good bit of swearing (including "f--k"), frequent violence (sometimes extremely graphic), and some sexual content (a woman is shown topless; intercourse, sex work, and oral sex are implied but not shown). Latino characters perpetuate stereotypes, and women are portrayed as nagging. The making and abuse of drugs are core to the series.Parents need to know that Breaking Bad isnoot intended for kids. Its intense, morally ambiguous characters and storylines are meant for mature audiences. Main character Walter White (Bryan Cranston) starts out as an essentially good person who\'s driven to extreme negative behavior (manufacturing methamphetamines and more) by depression and desperation. Over the course of the show, his good side becomes less and less evident as he eventually turns into a drug lord. There\'s a good bit of swearing (including "f--k"), frequent violence (sometimes extremely graphic), and some sexual content (a woman is shown topless; intercourse, sex work, and oral sex are implied but not shown). Latino characters perpetuate stereotypes, and women are portrayed as nagging. The making and abuse of drugs are core to the series Parents need to know that Breaking Bad isnoot intended for kids. Its intense, morally ambiguous characters and storylines are meant for mature audiences. Main character Walter White (Bryan Cranston) starts out as an essentially good person who\'s driven to extreme negative behavior (manufacturing methamphetamines and more) by depression and desperation. Over the course of the show, his good side becomes less and less evident as he eventually turns into a drug lord. There\'s a good bit of swearing (including "f--k"), frequent violence (sometimes extremely graphic), and some sexual content (a woman is shown topless; intercourse, sex work, and oral sex are implied but not shown). Latino characters perpetuate stereotypes, and women are portrayed as nagging. The making and abuse of drugs are core to the series.Parents need to know that Breaking Bad isnoot intended for kids. Its intense, morally ambiguous characters and storylines are meant for mature audiences. Main character Walter White (Bryan Cranston) starts out as an essentially good person who\'s driven to extreme negative behavior (manufacturing methamphetamines and more) by depression and desperation. Over the course of the show, his good side becomes less and less evident as he eventually turns into a drug lord. There\'s a good bit of swearing (including "f--k"), frequent violence (sometimes extremely graphic), and some sexual content (a woman is shown topless; intercourse, sex work, and oral sex are implied but not shown). Latino characters perpetuate stereotypes, and women are portrayed as nagging. The making and abuse of drugs are core to the series.Parents need to know that Breaking Bad isnoot intended for kids. Its intense, morally ambiguous characters and storylines are meant for mature audiences. Main character Walter White (Bryan Cranston) starts out as an essentially good person who\'s driven to extreme negative behavior (manufacturing methamphetamines and more) by depression and desperation. Over the course of the show, his good side becomes less and less evident as he eventually turns into a drug lord. There\'s a good bit of swearing (including "f--k"), frequent violence (sometimes extremely graphic), and some sexual content (a woman is shown topless; intercourse, sex work, and oral sex are implied but not shown). Latino characters perpetuate stereotypes, and women are portrayed as nagging. The making and abuse of drugs are core to the series. Parents need to know that Breaking Bad isnoot intended for kids. Its intense, morally ambiguous characters and storylines are meant for mature audiences. Main character Walter White (Bryan Cranston) starts out as an essentially good person who\'s driven to extreme negative behavior (manufacturing methamphetamines and more) by depression and desperation. Over the course of the show, his good side becomes less and less evident as he eventually turns into a drug lord. There\'s a good bit of swearing (including "f--k"), frequent violence (sometimes extremely graphic), and some sexual content (a woman is shown topless; intercourse, sex work, and oral sex are implied but not shown). Latino characters perpetuate stereotypes, and women are portrayed as nagging. The making and abuse of drugs are core to the series.Parents need to know that Breaking Bad isnoot intended for kids. Its intense, morally ambiguous characters and storylines are meant for mature audiences. Main character Walter White (Bryan Cranston) starts out as an essentially good person who\'s driven to extreme negative behavior (manufacturing methamphetamines and more) by depression and desperation. Over the course of the show, his good side becomes less and less evident as he eventually turns into a drug lord. There\'s a good bit of swearing (including "f--k"), frequent violence (sometimes extremely graphic), and some sexual content (a woman is shown topless; intercourse, sex work, and oral sex are implied but not shown). Latino characters perpetuate stereotypes, and women are portrayed as nagging. The making and abuse of drugs are core to the series'
                  // ),
                  child: Column(children: [

                    Container(
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.only(top: 5, bottom: 5),
                      width: double.maxFinite,
                      color: Color.fromRGBO(23, 34, 51, 1),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Seasons',style: TextStyle(fontSize: 20,color: Colors.white),),
                          SizedBox(height: 10),
                          Wrap(children: List.generate(season, (index){
                            return InkWell(
                              onTap: (){
                                setState((){
                                  selectedIndex = index;
                                });

                              },
                              child: Container(
                                margin: EdgeInsets.only(right: 5),
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(color: selectedIndex==index?Color.fromRGBO(17, 26, 41, 0.9): Colors.blue),
                                child: Center(child: Text((index!+1).toString(),style: TextStyle(color: Colors.white),),),
                              ),
                            );
                          }),)
                        ],
                      ),
                    ),




                    Container(
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.only(top: 5, bottom: 5),
                      width: double.maxFinite,
                      color: Color.fromRGBO(23, 34, 51, 1),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Episodes',style: TextStyle(fontSize: 20,color: Colors.white),),
                          SizedBox(height: 10),
                          Wrap(children: List.generate(episode, (index){
                            return InkWell(
                              onTap: (){
                                setState((){
                                  selectedIndex1 = index;
                                });


                              },
                              child: Container(
                                margin: EdgeInsets.fromLTRB(0,0,5,5),
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(color: selectedIndex1==index?Color.fromRGBO(17, 26, 41, 0.9): Colors.blue),
                                child: Center(child: Text((index!+1).toString(),style: TextStyle(color: Colors.white),),),
                              ),
                            );
                          }),)
                        ],
                      ),
                    ),




                    Container(
                      margin: EdgeInsets.only(top: 5, bottom: 5),
                      width: double.maxFinite,
                      color: Color.fromRGBO(23, 34, 51, 1),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Padding(
                              padding: EdgeInsets.all(10),
                              child: SizedBox(
                                height: 50,
                                child: TextButton(
                                  onPressed: () {

                                    print(selectedIndex1);
                                    print(episode);
                                    if (selectedIndex1 +1  == episode) {

                                      completedMovieProviderModel.add(
                                          name, (selectedIndex + 1).toString(),
                                          (selectedIndex1 + 1).toString(),
                                          poster, episode.toString());


                                      FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
                                      User? user = _auth.currentUser;






                                      String? userId = user?.uid;

                                      // Here we get the document reference for current user

                                      DocumentReference userRef = FirebaseFirestore.instance.collection('users').doc(userId);



                                      CollectionReference completedMoviesRef = userRef.collection('Completed');

                                      completedMoviesRef.add({'id':movie_id,'imageUrl':poster,'movieName': name,"totalepisodes":episode.toString(),"watchedseasons":(selectedIndex+1).toString(),'watchedepisodes':(selectedIndex1+1).toString(),});

                                    }

                                    if(selectedIndex1 + 1  != episode){


                                      MovieProviderModel.add(
                                          name, (selectedIndex + 1).toString(),
                                          (selectedIndex1 + 1).toString(),
                                          poster, episode.toString());


                                      String? userId = user?.uid;

                                      // Here we get the document reference for current user

                                      DocumentReference userRef = FirebaseFirestore.instance.collection('users').doc(userId);



                                      CollectionReference watchingMoviesRef = userRef.collection('Watching');

                                      watchingMoviesRef.add({'imageUrl':poster,'movieName': name,"totalepisodes":episode.toString(),"watchedseasons":(selectedIndex+1).toString(),'watchedepisodes':(selectedIndex1+1).toString()});

                                    }
                                  },
                                  style: TextButton.styleFrom(
                                      backgroundColor: Colors.blue),
                                  child: const Text(
                                      "Add to profile",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 13.0),
                                  ),
                                ),
                              ),
                            ),

                          ]),
                    ),




                    Container(
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.only(top: 5, bottom: 5),
                      width: double.maxFinite,
                      color: Color.fromRGBO(23, 34, 51, 1),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Synopsis',
                              style: TextStyle(fontSize: 20, color: Colors.white),
                            ),
                            SizedBox(height:10),
                            Text(
                             widget.description,
                              style: TextStyle(color: Colors.white, fontSize: 12),
                            ),
                          ]),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 5, bottom: 5),
                      padding: EdgeInsets.all(10),
                      width: double.maxFinite,
                      color: Color.fromRGBO(23, 34, 51, 1),
                      child: Column(children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Characters',
                              style: TextStyle(fontSize: 20, color: Colors.white),
                            ),
                            TextButton(
                                onPressed: null,
                                child: Text(
                                  'View All',
                                  style: TextStyle(color: Colors.white),
                                ))
                          ],
                        ),
                        //To:do to implement the listview here
                        // ListView(
                        //   scrollDirection: Axis.horizontal,

                        //   children: [
                        //     CharacterWidget(),
                        //     CharacterWidget(),
                        //     CharacterWidget(),
                        //     CharacterWidget(),
                        //     CharacterWidget(),
                        //   ],
                        // )
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,child: Row(children: [CharacterWidget(),CharacterWidget(),CharacterWidget()],),
                        )
                      ]),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 5, bottom: 5),
                      padding: EdgeInsets.all(10),
                      width: double.maxFinite,
                      color: Color.fromRGBO(23, 34, 51, 1),
                      child: Column(children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Recommendation',
                              style: TextStyle(fontSize: 20, color: Colors.white),
                            ),
                            TextButton(
                                onPressed: null,
                                child: Text(
                                  'View All',
                                  style: TextStyle(color: Colors.white),
                                ))
                          ],
                        ),
                        //To:do to implement the listview here
                        // ListView(
                        //   scrollDirection: Axis.horizontal,
                        // )
                        Row(
                          children: [RecommendationWidget()],
                        )
                      ]),
                    )
                  ])),
            )
          ],
        )
      ),)
    );
  }
}


class RecommendationWidget extends StatelessWidget {
  const RecommendationWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(5),
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                width: 150.0,
                height: 200.0,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(
                            "https://images.unsplash.com/photo-1579202673506-ca3ce28943ef"),
                        fit: BoxFit.cover)),
              ),
              Container(
                width: 150,
                height: 200,
                child: Align(
                  alignment: Alignment(-1, -1),
                  //Alignment(1, -1) place the image at the top & far left.
                  //Alignment (0, 0) is the center of the container
                  //You can change the value of x and y to any number between -1 and 1
                  child: Row(
                    children: [
                      Icon(Icons.star, color: Colors.yellow, size: 15),
                      Text('7.8')
                    ],
                  ),
                ),
              ),
            ],
          ),
          Text(
            'Series Name',
            style: TextStyle(color: Colors.white),
          )
        ],
      ),
    );
  }
}

class CharacterWidget extends StatelessWidget {
  const CharacterWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(5),
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                width: 150.0,
                height: 200.0,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(
                            "https://images.unsplash.com/photo-1579202673506-ca3ce28943ef"),
                        fit: BoxFit.cover)),
              ),
              Container(
                width: 150,
                height: 160,
                child: Align(
                  alignment: Alignment(1, -1),
                  //Alignment(1, -1) place the image at the top & far left.
                  //Alignment (0, 0) is the center of the container
                  //You can change the value of x and y to any number between -1 and 1
                  child: IconButton(
                    onPressed: () {},
                    // condition inside the onpressed to add or remove from fav character
                    // Function for Remove from Favorites : function to add to favorites,,
                    icon:
                        //  Condition ? Icon(Icons.favorite, color: Colors.white, size: 25): Icon(Icons.favorite_outlined, color: Colors.blue,size: 25),
                        Icon(Icons.favorite, color: Colors.white, size: 27),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Text(
            'Charecter Name',
            style: TextStyle(color: Colors.white),
          )
        ],
      ),
    );
  }
}