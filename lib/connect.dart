import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<List<Map<String, dynamic>>> sendShowDataToFlaskApp() async {
  String url = 'http://10.0.2.2:5000/'; // Replace with your Flask app endpoint
  CollectionReference collectionRef = FirebaseFirestore.instance
      .collection('users')
      .doc('${FirebaseAuth.instance.currentUser?.uid}')
      .collection('Completed');

  try {
    QuerySnapshot querySnapshot = await collectionRef.get();
    List<String> showIds = [];

    if (querySnapshot != null) {
      querySnapshot.docs.forEach((doc) {
        var fieldValue = (doc?.data() as Map<String, dynamic>)?['id'];
        if (fieldValue != null) {
          showIds.add(fieldValue.toString());
        }
      });
    }

    List<Map<String, dynamic>> requestBodyList = [];

    for (var id in showIds) {
      String name = await fetchShowName(id);
      List<String> genres = await fetchShowGenres(id);
      String tags = await fetchShowTags(id);

      var showData = {
        'name': name,
        'genres': genres,
        'tags': tags,
      };

      requestBodyList.add(showData);

      print(name);
      print(genres);
      print(tags);
    }

    var requestBody = jsonEncode(requestBodyList);

    print(requestBody);

    var response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
      },
      body: requestBody,
    );

    if (response.statusCode == 200) {
      print(response);
      dynamic jsonResponse = jsonDecode(response.body);

      print(jsonResponse.length);

      if (jsonResponse is List) {
        // Process the list directly
        return List<Map<String, dynamic>>.from(jsonResponse);
      } else if (jsonResponse is Map) {
        // Extract the necessary data from the map
        var recommendations = jsonResponse['Recommendations'];

        if (recommendations is List) {
          return List<Map<String, dynamic>>.from(recommendations);
        } else {
          throw Exception('Invalid response format: Recommendations not found.');
        }
      } else {
        throw Exception('Invalid response format: Expected a list or a map.');
      }
    } else {
      throw Exception('Failed to fetch recommendations');
    }
  } catch (error) {
    print('An error occurred: $error');
    // Handle the error as needed
    throw error; // Rethrow the error if necessary
  }
}

Future<String> fetchShowName(String id) async {
  var response = await Dio().get(
      "https://api.themoviedb.org/3/tv/$id?api_key=231880c8395d2256effb0912ef9f9888");
  return response.data['name'].toString();
}

Future<List<String>> fetchShowGenres(String id) async {
  var response = await Dio().get(
      "https://api.themoviedb.org/3/tv/$id?api_key=231880c8395d2256effb0912ef9f9888");
  return List<String>.from(
      response.data['genres']?.map((genre) => genre['name'])?.toList() ?? []);
}

Future<String> fetchShowTags(String id) async {
  var response = await Dio().get(
      "https://api.themoviedb.org/3/tv/$id?api_key=231880c8395d2256effb0912ef9f9888");
  return response.data['tagline'].toString();
}

class MyWidget extends StatefulWidget {
  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  Future<List<Map<String, dynamic>>> ?_recommendationsFuture;

  @override
  void initState() {
    super.initState();
    _recommendationsFuture = sendShowDataToFlaskApp();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Recommendation',
        ),
        backgroundColor: Color.fromRGBO(17, 26, 41, 1),
      ),
      body: Center(
        child: FutureBuilder<List<Map<String, dynamic>>>(
          future: _recommendationsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              var recommendations = snapshot.data;
              if (recommendations == null || recommendations.isEmpty) {
                return Text('No recommendations available.');
              }

              return ListView.builder(
                itemCount: recommendations.length,
                itemBuilder: (context, index) {
                  var recommendation = recommendations[index];
                  return MyContainer(
                    image: recommendation['Images'],
                    text: recommendation['Title'],
                  );
                },
              );
            }
          },
        ),
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

