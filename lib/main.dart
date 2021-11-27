/*

import 'package:bottom_bar/screens/live_tv.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'screens/live_tv.dart';
import 'screens/live_radio.dart';
import 'screens/donation.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Shortcuts(
        shortcuts: <LogicalKeySet, Intent>{
          LogicalKeySet(LogicalKeyboardKey.arrowLeft): ActivateIntent(),
        },
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: MyHomePage(title: 'SALVATION TV'),
        ));
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int selectedPage = 0;
  final _pageOptions = [LiveTV(), Test(), Donation()];

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Init.instance.initialize(),
      builder: (context, AsyncSnapshot snapshot) {
        // Show splash screen while waiting for app resources to load:
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const MaterialApp(home: Splash());
        } else {
          return Scaffold(
            appBar: AppBar(
              title: Text(widget.title),
            ),

            body: _pageOptions[selectedPage],
            bottomNavigationBar: ConvexAppBar(
              activeColor: Colors.amber,
              items: [
                TabItem(icon: Icons.home, title: 'Home'),
                TabItem(icon: Icons.live_tv, title: 'Live TV'),
                // TabItem(icon: Icons.chat_bubble_rounded, title: 'Search'),
                TabItem(icon: Icons.radio, title: 'Live Radio'),
                TabItem(icon: Icons.money, title: 'Donation'),
              ],
              initialActiveIndex: 0, //optional, default as 0
              onTap: (int i) {
                setState(() {
                  selectedPage = i;
                });
              },
            ), // This trailing comma makes auto-formatting nicer for build methods.
          );
        }
      },
    );
  }
}

class Splash extends StatelessWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool lightMode =
        MediaQuery.of(context).platformBrightness == Brightness.light;
    return Scaffold(
      backgroundColor:
          lightMode ? const Color(0xffe1f5fe) : const Color(0xff042a49),
      body: Center(
          child: lightMode
              ? Image.asset('images/splash.png')
              : Image.asset('assets/splash_dark.png')),
    );
  }
}

class Init {
  Init._();
  static final instance = Init._();

  Future initialize() async {
    await Future.delayed(const Duration(seconds: 3));
  }
}
*/

import 'package:bottom_bar/screens/live_tv.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import 'screens/video_player.dart';

class Movie {
  final String title;

  final String image;

  final String url;

  Movie({required this.title, required this.image, required this.url});
}

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Shortcuts(
        shortcuts: <LogicalKeySet, Intent>{
          LogicalKeySet(LogicalKeyboardKey.select): ActivateIntent(),
        },
        child: MaterialApp(
            title: 'Flutter Android TV',
            theme: ThemeData(
              primarySwatch: Colors.blue,
              visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
            home: LivePage()));
  }
}

class LivePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<LivePage> {
  List<Widget> _actionMovieCards = [];

  List<Widget> _bollywoodMovieCards = [];

  final GlobalKey _listKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blueGrey,
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  'Action Movies',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w300,
                      fontSize: 18),
                ),
              ),
              Container(
                height: 200,
                child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    key: _listKey,
                    itemCount: _actionMovieCards.length,
                    itemBuilder: (context, index) {
                      return _actionMovieCards[index];
                    }),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  'Bollywood Movies',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w300,
                      fontSize: 18),
                ),
              ),
              Container(
                height: 200,
                child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,

                    //key: _listKey,

                    itemCount: _bollywoodMovieCards.length,
                    itemBuilder: (context, index) {
                      return _bollywoodMovieCards[index];
                    }),
              ),
            ],
          ),
        ));
  }
}

void addMovies() {
  List<Movie> _actionMovies = [
    Movie(
        title: 'Dracula',
        image: 'https://wallpaperaccess.com/full/1923020.jpg',
        url: 'https://www.youtube.com/watch?v=_2aWqecTTuE'),
    Movie(
        title: 'The Maze Runner',
        image:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQczM9W4ScNshPLjZLLRFbNvxzBL7vXOLjTxXZvp2OZE3ri3w2JsNjdpNV5erKRNfTyDzc&usqp=CAU',
        url: 'https://www.youtube.com/watch?v=AwwbhhjQ9Xk'),
    Movie(
        title: '300',
        image: 'https://wallpapercave.com/wp/wp2162772.jpg',
        url: 'https://www.youtube.com/watch?v=UrIbxk7idYA'),
    Movie(
        title: 'Venom',
        image:
            'https://mountaincrestexpress.com/wp-content/uploads/2018/10/Venom-1-1024x756.png',
        url: 'https://www.youtube.com/watch?v=u9Mv98Gr5pY'),
    Movie(
        title: 'Pirates Of the Caribbean',
        image: 'https://cdn.wallpapersafari.com/45/66/q2rdlZ.jpg',
        url: 'https://www.youtube.com/watch?v=Hgeu5rhoxxY')
  ];

  List<Movie> _bollywoodMovies = [
    Movie(
        title: 'Shaandar',
        image:
            'https://www.whoa.in/download/shaandaar-bollywood-movies-hd-poster',
        url: 'https://www.youtube.com/watch?v=k99-vMPh3-A'),
    Movie(
        title: '2 States',
        image: 'https://wallpaperaccess.com/full/1494461.jpg',
        url: 'https://www.youtube.com/watch?v=CGyAaR2aWcA'),
    Movie(
        title: 'Ishaqzaade',
        image:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTSwxz8bwLoiW2C81B6IlqvgnK_ViI9-XPvoQ&usqp=CAU',
        url: 'https://www.youtube.com/watch?v=46kTKQ0C2Ek'),
    Movie(
        title: 'Kick',
        image:
            'https://images.wallpapersden.com/image/ws-tiger-shroff-and-hrithik-roshan-war-movie_66472.jpg',
        url: 'https://www.youtube.com/watch?v=u-j1nx_HY5o'),
    Movie(
        title: 'Happy New Year',
        image:
            'https://c4.wallpaperflare.com/wallpaper/194/620/840/movies-bollywood-movies-wallpaper-preview.jpg',
        url: 'https://www.youtube.com/watch?v=JGHwANkQFrg')
  ];

  _actionMovies.forEach((movie) {
    _actionMovieCards.add(buildCard(movie));
  });

  _bollywoodMovies.forEach((movie) {
    _bollywoodMovieCards.add(buildCard(movie));
  });
}

Widget buildCard(Movie movie) {
  return InkWell(
      focusColor: Colors.white,
      onTap: () {},
      child: Container(
          height: 200,
          width: 200,
          child: Card(
              color: Colors.black12,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                      child: Image.network(
                    movie.image,
                    fit: BoxFit.cover,
                  )),
                  Divider(
                    color: Colors.white,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(movie.title,
                        style: TextStyle(color: Colors.white)),
                  ),
                ],
              ))));
}
