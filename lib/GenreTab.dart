import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:tmdb_api/tmdb_api.dart';

class GenreTab extends StatefulWidget {
  const GenreTab({Key? key}) : super(key: key);

  // Define a list of movie genres with their respective images
  static const List<Map<String, dynamic>> _genres = [
    {
      'name': 'Action',
      'image':
          'https://c8.alamy.com/comp/2E9K6R0/the-old-guard-2020-directed-by-gina-prince-bythewood-credit-netflix-album-2E9K6R0.jpg'
    },
    {
      'name': 'Comedy',
      'image':
          'https://thumbs.dreamstime.com/b/comedy-cinema-poster-comedy-cinema-poster-abstract-movie-poster-print-design-120601572.jpg'
    },
    {
      'name': 'Drama',
      'image':
          'https://i.pinimg.com/736x/6c/fb/d2/6cfbd23a05b78db17423d34b35c0e425.jpg'
    },
    {
      'name': 'Horror',
      'image':
          'https://creativereview.imgix.net/content/uploads/2017/09/elmst.jpeg'
    },
    {
      'name': 'Romance',
      'image':
          'https://m.media-amazon.com/images/M/MV5BZmRjNDgxODUtY2E3OC00MzRhLWI5YzQtNDNkMzlmM2EwMDBhXkEyXkFqcGdeQXVyMTEzMTI1Mjk3._V1_.jpg'
    },
    {
      'name': 'Sci-Fi',
      'image':
          'https://m.media-amazon.com/images/M/MV5BYjI5OGMxNzYtZmZiYS00NDI1LWI4NWMtOTZmNjY1MjMzZjExXkEyXkFqcGdeQXVyNTgxMjE3OTQ@._V1_FMjpg_UX1000_.jpg'
    },
  ];

  @override
  State<GenreTab> createState() => _GenreTabState();
}

class _GenreTabState extends State<GenreTab> {

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
    return GridView.builder(
      // Set the number of items in the grid
      itemCount: genrelist.length,

      // Define the layout of the grid
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        childAspectRatio: 1.0,
      ),

      // Build each container in the grid with an image and a name
      itemBuilder: (BuildContext context, int index) {
        return InkWell(
          onTap: () {
            // TODO: Navigate to movies page with this genre
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    GenreMoviesPage(genreName: genrelist[index]['name']),
              ),
            );
          },
          child: Container(
            margin: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              image: DecorationImage(
                image: NetworkImage( 'https://c8.alamy.com/comp/2E9K6R0/the-old-guard-2020-directed-by-gina-prince-bythewood-credit-netflix-album-2E9K6R0.jpg'),
                fit: BoxFit.cover,

              ),
            ),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10.0,
                  vertical: 5.0,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10.0),
                    bottomRight: Radius.circular(10.0),
                  ),
                  color: Colors.black.withOpacity(0.6),
                ),
                child: Text(
                  genrelist[index]['name'],
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class GenreMoviesPage extends StatelessWidget {
  final String genreName;

  const GenreMoviesPage({Key? key, required this.genreName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: Fetch the list of movies belonging to the selected genre
    // a dummy list of movies for demonstration purposes
     const List<Map<String, dynamic>> movies = [
      {'name':"Movie 1",'rating':"9.8",'season':'11','episodes':'12','image':'https://creativereview.imgix.net/content/uploads/2017/09/elmst.jpeg'},
      {'name':"Movie 2",'rating':'8.1','season':'1','episodes':'12','image':'https://creativereview.imgix.net/content/uploads/2017/09/elmst.jpeg'},
      {'name':"Movie 3",'rating':'3.5','season':'1','episodes':'12','image':'https://creativereview.imgix.net/content/uploads/2017/09/elmst.jpeg'},
      {'name':"Movie 4",'rating':'8.5','season':'2','episodes':'12','image':'https://creativereview.imgix.net/content/uploads/2017/09/elmst.jpeg'},
      {'name':"Movie 5",'rating':'6.5','season':'5','episodes':'12','image':'https://creativereview.imgix.net/content/uploads/2017/09/elmst.jpeg'},
      {'name':"Movie 6",'rating':'8.5','season':'1','episodes':'12','image':'https://creativereview.imgix.net/content/uploads/2017/09/elmst.jpeg'},
      {'name':"Movie 7",'rating':'5.5','season':'7','episodes':'12','image':'https://creativereview.imgix.net/content/uploads/2017/09/elmst.jpeg'},
      {'name':"Movie 8",'rating':'9.5','season':'10','episodes':'12','image':'https://creativereview.imgix.net/content/uploads/2017/09/elmst.jpeg'}
    ];

    return Scaffold(
      backgroundColor: Color.fromRGBO(17, 26, 41, 0.9),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(17, 26, 41, 0.9),
        title: Text(genreName),
      ),
      body: GridView.builder(
        // Set the number of items in the grid
        itemCount: movies.length,

        // Define the layout of the grid
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 0.7,
        ),

        // Build each container in the grid with a movie name
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            // Make each container tappable
            onTap: () {
              // TODO: Navigate to movie details page for this movie
            },

            child: Column(
              children: [
                Container(
                  height: 200,
                  width: 200,
                  
                  margin: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(23, 34, 51, 0.9),
                    borderRadius: BorderRadius.circular(10.0),
                    image: DecorationImage(
                      image: NetworkImage(movies[index]['image']),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child:
                      Align(
                        alignment: Alignment.topRight,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10.0,
                            vertical: 5.0,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(10.0),
                              bottomRight: Radius.circular(10.0),
                            ),
                            color: Colors.black.withOpacity(0.6),
                          ),
                          child: Text('${
                            movies[index]['rating']}',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    
                
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(movies[index]['name'],style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                    Text('Seasons ${movies[index]['season']}',style: TextStyle(color: Colors.white,fontSize: 10),),

                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
