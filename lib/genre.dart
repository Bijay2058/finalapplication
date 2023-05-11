import 'package:flutter/material.dart';
import 'package:tmdb_api/tmdb_api.dart';


class genrescreen extends StatefulWidget {




  const genrescreen({Key? key,}) : super(key: key);

  @override
  State<genrescreen> createState() => _genrescreenState();
}

class _genrescreenState extends State<genrescreen> {

  List genrelist=[];




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

    Map genrelistresult = await tmdbWithCustomLogs.v3.genres.getMovieList();



    setState(() {
      genrelist = genrelistresult['genres'];



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


      padding: EdgeInsets.all(16.0),
      child: GridView.builder(
          itemCount: genrelist.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, crossAxisSpacing: 4.0, mainAxisSpacing: 6.0,),
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
              onTap: () async{

              },
              child: Container(
                color: Color(0xFF172233),


                width: 350,
                child: Center(child: Text(genrelist[index]['name'],style: TextStyle(color: Colors.white),)),
            ),);
          }


      ),
    );
  }
}