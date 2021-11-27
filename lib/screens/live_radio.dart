import 'package:bottom_bar/helper/radio2.dart';
import 'package:bottom_bar/helper/videoplayer.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() => runApp(Test());

class Test extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: JsonImageList(),
      ),
    );
  }
}

class Flowerdata {
  int id;
  String flowerName;
  String flowerImageURL;
  String flowerImage;

  Flowerdata(
      {required this.id,
      required this.flowerName,
      required this.flowerImageURL,
      required this.flowerImage});

  factory Flowerdata.fromJson(Map<String, dynamic> json) {
    return Flowerdata(
        id: json['id'],
        flowerName: json['title'],
        flowerImageURL: json['thumbnailUrl'],
        flowerImage: json['url']);
  }
}

class JsonImageList extends StatefulWidget {
  JsonImageListWidget createState() => JsonImageListWidget();
}

class JsonImageListWidget extends State {
  final String apiURL = 'http://3.6.175.227/dashboard/salvation/radio.php';

  Future<List<Flowerdata>> fetchFlowers() async {
    var response = await http.get(Uri.parse(apiURL));

    if (response.statusCode == 200) {
      final items = json.decode(response.body).cast<Map<String, dynamic>>();

      List<Flowerdata> listOfFruits = items.map<Flowerdata>((json) {
        return Flowerdata.fromJson(json);
      }).toList();

      return listOfFruits;
    } else {
      throw Exception('Failed to load data from Server.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Flowerdata>>(
      future: fetchFlowers(),
      builder: (context, snapshot) {
        if (!snapshot.hasData)
          return Center(child: CircularProgressIndicator());

        return ListView(
          children: snapshot.data!
              .map((data) => Column(
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => audioplayer(
                                      data.flowerImage,
                                      data.flowerImageURL,
                                      data.flowerName)));
                        },
                        child: Row(children: [
                          Container(
                              width: 80,
                              height: 80,
                              margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: Image.network(
                                    data.flowerImageURL,
                                    width: 80,
                                    height: 80,
                                    fit: BoxFit.cover,
                                  ))),
                          Flexible(
                              child: Text(data.flowerName,
                                  style: TextStyle(fontSize: 18)))
                        ]),
                      ),
                      Divider(color: Colors.black),
                    ],
                  ))
              .toList(),
        );
      },
    );
  }
}
