import 'package:flutter/material.dart';
import 'package:untitled2/widgets/bottom_navigation_bar.dart';
import 'package:untitled2/screens/info_page.dart';

class NewsScreen extends StatefulWidget {

  static const String id = 'news_screen';
  const NewsScreen({Key? key}) : super(key: key);

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  final GlobalKey<NavigatorState> _newsNavigatorKey = GlobalKey<NavigatorState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(17, 26, 41, 1),
      appBar: AppBar(
        title: Text('NEWS'),
        backgroundColor: Color.fromRGBO(17, 26, 41, 1),
      ),
      

    );
  }
}

class MyContainer extends StatelessWidget {
  final String image;
  final String text;
  // final Function onOptionTap;
  final double progress;

  const MyContainer({
    Key? key,
    required this.image,
    required this.text,
    // this.onOptionTap,
    this.progress = 0.5,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(10.0),
        height: 200,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          color: Color.fromRGBO(23, 34, 51, 0.6),
          borderRadius: BorderRadius.all(
            Radius.circular(30),
          ),
          boxShadow: [
            BoxShadow(
                // color: Color.fromARGB(255, 63, 62, 62), //New
                blurRadius: 25.0,
                offset: Offset(0, -10))
          ],
        ),
        child: Row(children: [
          Image(
            image: NetworkImage(image),
            height: 200.0,
            width: 200.0,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  text,
                  style: TextStyle(fontSize: 30, color: Colors.white),
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(
                  height: 60,
                ),
                Text('7/13', style: TextStyle(fontSize: 30, color: Colors.white)),
                SizedBox(
                  height: 10,
                ),
                LinearProgressIndicator(
                  minHeight: 10,
                  value: progress,
                  backgroundColor: Colors.grey[300],
                  valueColor: AlwaysStoppedAnimation(Colors.blue),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child:PopupMenuButton(
              icon: Icon(Icons.more_vert, color: Colors.white),
              iconSize: 50,
              color: Color.fromARGB(255, 248, 248, 248),
              itemBuilder: (context) {
                return [
                  PopupMenuItem(
                    value: 'edit',
                    child: Text('+1 Episode'),
                  ),
                  PopupMenuItem(
                    value: 'delete',
                    child: Text('Deletee'),
                  )
                ];
              },
              )
              
            //  IconButton(
            //   iconSize: 50,
            //   icon: Icon(Icons.more_vert),
            //   onPressed: () {},
            //   // onOptionTap,
            ),
          ]
        ));
  }
}
