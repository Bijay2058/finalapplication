
import 'package:flutter/material.dart';
import 'package:untitled2/screens/info_page.dart';





class movieCart1 extends StatelessWidget {
  final airing;

  const movieCart1({Key? key, required this.airing}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 20, 10, 10),
      padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
      height: 450,
      width: MediaQuery
          .of(context)
          .size
          .width,
      color: Color(0xFF172233),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Airing", style: TextStyle(fontSize: 25, color: Colors.white),),
          SizedBox(height: 20),
          Container(height: 300,
            child: ListView.builder(
                itemCount: airing.length, scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return InkWell(
                      onTap: () {},
                      child: Container(
                        margin: const EdgeInsets.fromLTRB(10, 60, 0, 0),
                        height: 170,
                        width: 100,

                        color: Color(0xFF172233),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children:
                          [ Container
                            (margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                            height: 110,
                            width: 140,
                            child: FittedBox(child: Image.network(
                                'http://image.tmdb.org/t/p/w500' +
                                    airing[index]['poster_path']

                            ), fit: BoxFit.cover,),),
                            SizedBox(height: 15,),
                            Text(airing[index]['title'] != null
                                ? airing[index]['title']
                                : 'Loading', style: TextStyle(
                                color: Colors.white, fontSize: 10),),
                            SizedBox(height: 10,),
                            Row(
                              children: [
                                Icon(
                                  Icons.star, color: Colors.white, size: 10,),
                                Text(airing[index]['vote_average'].toString(),
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 10),)
                              ],
                            )
                          ],
                        ),
                      )
                  );
                }),
          )


        ],
      ),
    );
  }
}

class movieCart2 extends StatelessWidget {
  final discover;
  const movieCart2({Key? key,this.discover}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 20, 10, 10),
      padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
      height:400,
      width:MediaQuery.of(context).size.width,
      color: Color(0xFF172233),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [Text("Discover",style: TextStyle(fontSize: 25,color: Colors.white),),
          SizedBox(height:20),
          Container(height: 300,
            child: ListView.builder(itemCount: discover.length,scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return InkWell(
                      onTap: () {},
                      child: Container(
                        margin: const EdgeInsets.fromLTRB(10, 60, 0, 0),
                        height: 170,
                        width: 100,

                        color: Color(0xFF172233),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children:
                          [ Container
                            (margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                            height: 110,
                            width: 140,
                            child: FittedBox(child: Image.network('http://image.tmdb.org/t/p/w500'+ discover[index]['poster_path']

                            ), fit: BoxFit.cover,),),
                            SizedBox(height: 15,),
                            Text(discover[index]['title']!=null?discover[index]['title']:'Loading', style: TextStyle(
                                color: Colors.white, fontSize: 10),),
                            SizedBox(height: 10,),
                            Row(
                              children: [
                                Icon(
                                  Icons.star, color: Colors.white, size: 10,),
                                Text(discover[index]['vote_average'].toString(),style: TextStyle(
                                    color: Colors.white, fontSize: 10),)
                              ],
                            )
                          ],
                        ),
                      )
                  );
                }),
          )


        ],
      ),
    );
  }
}








class moviecart extends StatelessWidget {
  final List trending;
  final topratedtv;








  const moviecart({Key? key, required this.trending,this.topratedtv}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 20, 10, 10),
      padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
      height: 450,
      width: MediaQuery.of(context).size.width,
      color: Color(0xFF172233),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Top Sereis", style: TextStyle(fontSize: 25, color: Colors.white),),
          SizedBox(height: 10),
          Row(
              children: [
                TextButton(onPressed: () {

                },
                    child: Text('Movies', style: TextStyle(color: Colors.white),),
                    style: ButtonStyle(
                        shape: MaterialStateProperty.all<
                            RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                                side: BorderSide(color: Color(0xFF43a5f6),)
                            )
                        )
                    )),
                SizedBox(width: 10),
                TextButton(onPressed: () {},
                    child: Text(
                      'TV', style: TextStyle(color: Colors.white),),
                    style: ButtonStyle(
                        shape: MaterialStateProperty.all<
                            RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                                side: BorderSide(color: Color(0xFF43a5f6),)
                            )
                        )
                    )),
                SizedBox(width: 10),

                TextButton(onPressed: () {},
                    child: Text(
                      'Upcoming', style: TextStyle(color: Colors.white),),
                    style: ButtonStyle(
                        shape: MaterialStateProperty.all<
                            RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                                side: BorderSide(color: Color(0xFF43a5f6),)
                            )
                        )
                    )),
                SizedBox(width: 10),

                TextButton(onPressed: () {},
                    child: Text(
                      'Airing', style: TextStyle(color: Colors.white),),
                    style: ButtonStyle(
                        shape: MaterialStateProperty.all<
                            RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                                side: BorderSide(color: Color(0xFF43a5f6),)
                            )
                        )
                    )),

              ]),

          SizedBox(height: 10),

          Container(height: 300,
            child: ListView.builder(itemCount: trending.length,scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => InfoPage(name: trending[index]['name'],
                           banner:"http://image.tmdb.org/t/p/w500" +trending[index]['backdrop_path'],
                            description:trending[index]['overview'] ,
                            rating: trending[index]['vote_average'].toString(),
                            poster: "http://image.tmdb.org/t/p/w500" +trending[index]['poster_path'],
                            movie_id: trending[index]['id'].toString(),
                          )),
                        );
                      },
                      child: Container(
                        margin: const EdgeInsets.fromLTRB(10, 60, 0, 0),
                        height: 170,
                        width: 100,

                        color: Color(0xFF172233),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children:
                          [ Container
                            (margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                            height: 110,
                            width: 140,
                            child: FittedBox(child: Image.network('http://image.tmdb.org/t/p/w500'+ trending[index]['poster_path']

                            ), fit: BoxFit.cover,),),
                            SizedBox(height: 15,),
                            Text(trending[index]['name']!=null?trending[index]['name']:'Loading', style: TextStyle(
                                color: Colors.white, fontSize: 10),),
                            SizedBox(height: 10,),
                            Row(
                              children: [
                                Icon(
                                  Icons.star, color: Colors.white, size: 10,),
                                Text(trending[index]['vote_average'].toString(),style: TextStyle(
                                    color: Colors.white, fontSize: 10),)
                              ],
                            )
                          ],
                        ),
                      )
                  );
                }),
          )


        ],
      ),
    );
  }


}