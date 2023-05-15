import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:untitled2/screens/info_page.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  TextEditingController searchController = TextEditingController();
  List<dynamic> searchResults = [];

  Future<void> searchMovies(String query) async {
    final apiKey = '231880c8395d2256effb0912ef9f9888';// Replace with your TMDB API key
    final String baseUrl = 'https://api.themoviedb.org/3';
    final String searchEndpoint = '/search/tv';
    final String language = 'en-US';

    final String url = '$baseUrl$searchEndpoint?api_key=$apiKey&language=$language&query=$query';

    final response = await http.get(Uri.parse(url));
    final jsonData = json.decode(response.body);

    setState(() {
      searchResults = jsonData['results'];
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
      Color.fromRGBO(17, 26, 41, 1),
      appBar: AppBar(
        title: Text('Search'),
        backgroundColor:Color.fromRGBO(17, 26, 41, 1),

      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: 'Enter series name',

                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                filled: true,
                fillColor: Colors.white,
              ),

            ),
          ),
          ElevatedButton(
            onPressed: () {
              final query = searchController.text;
              searchMovies(query);
            },
            child: Text('Search'),


          ),
          SizedBox(height:20),
          Expanded(
            child: ListView.builder(
              itemCount: searchResults.length,
              itemBuilder: (context, index) {
                final movie = searchResults[index];
                return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => InfoPage(name: movie['name'],
                          banner:"http://image.tmdb.org/t/p/w500" +movie['backdrop_path'],
                          description:movie['overview'] ,
                          rating: movie['vote_average'].toString(),
                          poster: "http://image.tmdb.org/t/p/w500" +movie['poster_path'],
                          movie_id: movie['id'].toString(),
                        )),
                      );
                    },
                    child: MyContainer(image: 'https://image.tmdb.org/t/p/w500${movie['poster_path']}', text: movie['name'].toString())
                );

              },
            ),

          ),
        ],
      ),
    );
  }
}

class MyContainer extends StatelessWidget {
  final String image;
  final String text;

  const MyContainer({
    Key ?key,
    required this.image,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5.0),
      height: 100,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        color: Color.fromRGBO(17, 26, 41, 1),
        borderRadius: BorderRadius.all(
          Radius.circular(0),
        ),
        boxShadow: [
          BoxShadow(
            blurRadius: 15.0,
            offset: Offset(0, -10),
          )
        ],
      ),
      child: Row(
        children: [
          Image(
            image: NetworkImage(image),
            height: 100.0,
            width: 100.0,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  text,
                  style: TextStyle(fontSize: 25, color: Colors.white),
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

