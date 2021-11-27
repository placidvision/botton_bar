// ignore_for_file: avoid_unnecessary_containers, unnecessary_new

import 'package:bottom_bar/helper/videoplayer.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';

List<Payload> payloadFromJson(String str) =>
    List<Payload>.from(json.decode(str).map((x) => Payload.fromJson(x)));

String payloadToJson(List<Payload> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Payload {
  //String sponsorlogo;
  String flowerName;
  String flowerImageURL;
  String flowerImage;

  Payload(
      {
      //required this.sponsorlogo,
      required this.flowerName,
      required this.flowerImageURL,
      required this.flowerImage});

  factory Payload.fromJson(Map<String, dynamic> json) => Payload(
        //sponsorlogo: json["sponsorlogo"] == null ? null : json["sponsorlogo"],
        flowerName: json["title"] == null ? null : json["title"],
        flowerImage: json["url"] == null ? null : json["url"],
        flowerImageURL:
            json["thumbnailUrl"] == null ? null : json["thumbnailUrl"],
      );

  Map<String, dynamic> toJson() => {
        // "sponsorlogo": sponsorlogo == null ? null : sponsorlogo,
        "flowerName": flowerName == null ? null : flowerName,
        "flowerImage": flowerImage == null ? null : flowerImage,
        "flowerImageURL": flowerImageURL == null ? null : flowerImageURL,
      };
}
//////////////////////////////////////////////Lower UI///////////////////////////////////////

Future<List<Photo>> fetchPhotos(http.Client client) async {
  final response = await client
      .get(Uri.parse('http://3.108.213.26/dashboard/salvation/live.php'));

  // Use the compute function to run parsePhotos in a separate isolate.
  return compute(parsePhotos, response.body);
}

// A function that converts a response body into a List<Photo>.
List<Photo> parsePhotos(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<Photo>((json) => Photo.fromJson(json)).toList();
}

class Photo {
  final int albumId;
  final int id;
  final String title;
  final String url;
  final String thumbnailUrl;

  const Photo({
    required this.albumId,
    required this.id,
    required this.title,
    required this.url,
    required this.thumbnailUrl,
  });

  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(
      albumId: json['albumId'] as int,
      id: json['id'] as int,
      title: json['title'] as String,
      url: json['url'] as String,
      thumbnailUrl: json['thumbnailUrl'] as String,
    );
  }
}

///////////////////////////////////////////////////////////

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: carasouel(),
    );
  }
}

class carasouel extends StatefulWidget {
  @override
  _SponsorSliderState createState() => _SponsorSliderState();
}

class _SponsorSliderState extends State<carasouel> {
  Future<List<Payload>> getSponsorSlide() async {
    final String url = "http://3.108.213.26/dashboard/salvation/radio.php";

    final response = await http.get(Uri.parse(url));
    var payloadList = payloadFromJson(response.body);
    return payloadList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Card(
          child: FutureBuilder<List<Payload>>(
            future: getSponsorSlide(),
            builder: (context, snapshot) {
              if (snapshot.hasError) print(snapshot.error);
              return snapshot.hasData
                  ? SponsorList(
                      list: snapshot.data!,
                    )
                  : Center(child: CircularProgressIndicator());
            },
          ),
        ),
      ),
    );
  }
}

class SponsorList extends StatefulWidget {
  final List<Payload> list;
  SponsorList({required this.list});

  @override
  _SponsorListState createState() => _SponsorListState();
}

class _SponsorListState extends State<SponsorList> {
  int _current = 0;

  int index = 1;

  @override
  Widget build(BuildContext context) {
    /*
    return Container(
      child: Column(
        children: <Widget>[
          CarouselSlider(
              items: widget.list.map((imageUrl) {
                return Builder(builder: (BuildContext context) {
                  return Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.symmetric(horizontal: 10.0),
                      decoration: BoxDecoration(
                        color: Colors.green,
                      ),
                      child: GestureDetector(
                        child: Image.network(
                          imageUrl.flowerImageURL,
                          fit: BoxFit.fill,
                        ),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      videoplayer(imageUrl.flowerImage)));
                        },
                      ));
                });
              }).toList(),
              options: CarouselOptions(
                height: 200.0,
                initialPage: 0,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 2),
                reverse: false,
              ))
        ],
      ),
    );*/

    return new MaterialApp(
      home: new Scaffold(
        body: new Container(
          color: Color(0xff258DED),
          height: 400.0,
          alignment: Alignment.center,
          child: new Column(
            children: [
              new Container(
                height: 200.0,
                width: 200.0,
                decoration: new BoxDecoration(
                    image: DecorationImage(
                        image: new AssetImage('assets/logo2.jpg'),
                        fit: BoxFit.fill),
                    shape: BoxShape.circle),
              ),
              new Container(
                child: new Text(
                  'Welcome to Prime Message',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: 'Aleo',
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.bold,
                      fontSize: 25.0,
                      color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
