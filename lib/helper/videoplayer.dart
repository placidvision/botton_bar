import 'package:flutter/material.dart';
import 'package:better_player/better_player.dart';

import 'dart:async' show Future;

class videoplayer extends StatefulWidget {
  late String URL;
  videoplayer(this.URL);
  @override
  _VideoChannel1ScreenState createState() => _VideoChannel1ScreenState(URL);
}

class _VideoChannel1ScreenState extends State<videoplayer> {
  late String URL;
  _VideoChannel1ScreenState(this.URL);
  late BetterPlayerController _betterPlayerController;
  late List list;
  bool ismainLoaded = false;
  // static const String hlsTestStreamUrl =
  //   "https://bitdash-a.akamaihd.net/content/MI201109210084_1/m3u8s/f08e80da-bf1d-4e3d-8899-f0f6155f6efa.m3u8";
  @override
  void initState() {
    print("here");
    print(URL);
    super.initState();

    BetterPlayerConfiguration betterPlayerConfiguration =
        const BetterPlayerConfiguration(
      aspectRatio: 16 / 9,
      fit: BoxFit.contain,
      autoPlay: true,
    );
    BetterPlayerDataSource dataSource = BetterPlayerDataSource(
      BetterPlayerDataSourceType.network,
      URL,
      useAsmsSubtitles: true,
    );

    _betterPlayerController = BetterPlayerController(betterPlayerConfiguration);
    _betterPlayerController.setupDataSource(dataSource);
    super.initState();
  }

  List<Widget> buildExampleElementWidgets() {
    return [
      _buildExampleElementWidget("Click here to Donate", () {
        //    _navigateToPage(Home());
      }),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*
      appBar: AppBar(
        title: Text("Salvation TV"),
        backgroundColor: Colors.lightBlue,
        centerTitle: true,
        actions: [
          MaterialButton(
            onPressed: () {
              //Amplify.Auth.signOut().then((_)
              {
                Navigator.pushReplacementNamed(context, '/');
              }
              ;
            },
            child: const Icon(
              Icons.logout,
              color: Colors.white,
            ),
          )
        ],
      ),

      */
      body: Column(children: [
        SizedBox(height: 10),
        AspectRatio(
          aspectRatio: 16 / 9,
          child: BetterPlayer(controller: _betterPlayerController),
        ),

        const SizedBox(
          height: 8,
          width: 8,
        ),
        // ...buildExampleElementWidgets()
      ]),
    );
  }

  Widget _buildExampleElementWidget(String name, Function onClicked) {
    return Material(
      child: InkWell(
        onTap: onClicked as void Function(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10, horizontal: 120),
              child: SizedBox(
                  width: 150,
                  height: 50,
                  child: Card(
                      color: Colors.blue,
                      child: Center(
                        child: Text(
                          name,
                          style: TextStyle(color: Colors.white),
                        ),
                      ))),
            ),
            Divider(),
          ],
        ),
      ),
    );
  }

  Future _navigateToPage(Widget routeWidget) {
    return Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => routeWidget),
    );
  }
}
