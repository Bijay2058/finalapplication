import 'package:flutter/material.dart';
import 'model/movie_model.dart';
import 'package:tmdb_api/tmdb_api.dart';

class search extends StatefulWidget {
  const search({Key? key}) : super(key: key);

  @override
  State<search> createState() => _searchState();
}

class _searchState extends State<search> {
  //dummy list of data CAN CHANGE IT TO API

  static List<MovieModel> main_movie_list = [
    MovieModel('The shawshank Redemption', 1994, 9.3,
        'https://m.media-amazon.com/images/I/519NBNHX5BL._SX300_SY300_QL70_FMwebp_.jpg'),
    MovieModel('The GodFather', 1972, 9.2,
        'https://m.media-amazon.com/images/I/714ZOEiVNtL._RI_.jpg'),
    MovieModel('The Dark Knight', 2008, 9.0,
        'https://m.media-amazon.com/images/M/MV5BMTMxNTMwODM0NF5BMl5BanBnXkFtZTcwODAyMTk2Mw@@._V1_.jpg'),
    MovieModel('The GodFather:Part II', 197, 9.0,
        'https://m.media-amazon.com/images/M/MV5BMWMwMGQzZTItY2JlNC00OWZiLWIyMDctNDk2ZDQ2YjRjMWQ0XkEyXkFqcGdeQXVyNzkwMjQ5NzM@._V1_.jpg'),
    MovieModel('12 Angry Men', 1957, 9.0,
        'https://upload.wikimedia.org/wikipedia/commons/b/b5/12_Angry_Men_%281957_film_poster%29.jpg')
  ];

  //List we are going to display
  List<MovieModel> display_list = List.from(main_movie_list);

  void updatelist(String value) {
    //ths is the function that will filter our list

    setState(() {
      display_list = main_movie_list
          .where(
            (element) => element.movie_title!
                .toLowerCase()
                .contains(value.toLowerCase()),
          )
          .toList();
    });
  }

  final searchController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF172233),
      appBar: AppBar(
          backgroundColor: Color(0xFF172233),
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back)),
          title: TextFormField(
            onChanged: (value) => updatelist(value),
            controller: searchController,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
                hintText: 'Search', hintStyle: TextStyle(color: Colors.white)),
          )),
      body: Column(
        children: [
          Expanded(
              child: display_list.length == 0
                  ? Center(
                      child: Text(
                        'No Results Found',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 22.0,
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  : ListView.builder(
                      itemCount: display_list.length,
                      itemBuilder: (BuildContext context, int index) {
                        return InkWell(
                          onTap: () {
                            // Perform action when item is tapped
                            print("tapped");
                          },
                          child: Material(
                            color: Color(0xFF172233),
                            child: ListTile(
                                contentPadding: EdgeInsets.all(8.0),
                                title: Text(
                                  display_list[index].movie_title!,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                                subtitle: Text(
                                  '${display_list[index].movie_release_year}',
                                  style: TextStyle(
                                    color: Colors.white60,
                                  ),
                                ),
                                trailing: Text(
                                  '${display_list[index].rating}',
                                  style: TextStyle(color: Colors.amber),
                                ),
                                leading: Image.network(
                                    display_list[index].movie_poster_url!)),
                          ),
                        );
                      },

                    )),
        ],
      ),
    );
  }
}
