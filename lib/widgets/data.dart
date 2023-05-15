InkWell(
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
                      child: MyContainer(image: 'https://image.tmdb.org/t/p/w500${movie['poster_path']}', text: movie['name'].toString());
                  );