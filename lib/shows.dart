
import 'package:flutter/material.dart';
import 'package:tmdb_api/tmdb_api.dart';
import 'package:untitled2/widgets/cart.dart';


class showsScreen extends StatefulWidget {
  const showsScreen({Key? key}) : super(key: key);

  @override
  State<showsScreen> createState() => _showsScreenState();
}

class _showsScreenState extends State<showsScreen> {
  List trendingmovies=[];
  List airingmovies = [];
  List discovermovies = [];
  List trendingtv=[];



  final String apikey='231880c8395d2256effb0912ef9f9888';
  final readaccesstoken='eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIyMzE4ODBjODM5NWQyMjU2ZWZmYjA5MTJlZjlmOTg4OCIsInN1YiI6IjY0MzEwOThlMzEwMzI1MDBlMGRjYTBjMSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.5w1-z7TVVrxCGvuUeba0rlS09lIUyC2Navzx9PeKKcg';

  loadmovies() async{
    final tmdbWithCustomLogs = TMDB( //TMDB instance
      ApiKeys(apikey, readaccesstoken),//ApiKeys instance with your keys,
    );
    logConfig : ConfigLogger(
        showLogs:true,
        showErrorLogs: true
    );

    Map trendingresult = await tmdbWithCustomLogs.v3.tv.getTopRated();
    Map airingresult = await tmdbWithCustomLogs.v3.movies.getPopular();
    Map discoverresult = await tmdbWithCustomLogs.v3.discover.getMovies();
    Map trendingtvresult = await tmdbWithCustomLogs.v3.tv.getTopRated();




    setState(() {
      trendingmovies = trendingresult['results'];
      airingmovies = airingresult['results'];
      discovermovies = discoverresult['results'];
      trendingtv = trendingtvresult['results'];

    });

  }

  @override
  void initState() {
    loadmovies();
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromRGBO(17, 26, 41, 0.9) ,
     child: SingleChildScrollView(scrollDirection: Axis.vertical,child:Column(children: [moviecart(trending:trendingmovies),movieCart1(airing: airingmovies),movieCart2(discover: discovermovies,)],),)
    );
  }
}
