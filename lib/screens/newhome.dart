import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class NewHome extends StatefulWidget {
  @override
  _newHomeState createState() => _newHomeState();
}

class _newHomeState extends State<NewHome> {
  late List list;
  bool ismainLoaded = false;

  Future getMethodhome() async {
//////////////////////////////////////////////////for main page////////////////////////////////////////////

    final String apiURL2 = 'http://3.108.213.26/dashboard/salvation/radio.php';
    http.Response res = await http.get(Uri.parse(apiURL2));
    Map<String, dynamic> map = json.decode(res.body);
    List<dynamic> list = map["map"];
    if (list != null) {
      setState(() {
        ismainLoaded = true;
      });
    }

    print(list);

    //print(data);
    print('-------------------------');
    print(list[0]);
    print('-------------------------');

    print('-------------------------');

    print('-------------------------');
  }

  @override
  void initState() {
    getMethodhome();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return (!ismainLoaded)
        ? Container(
            child: GestureDetector(
                onTap: () {
                  getMethodhome();
                },
                child: Center(
                    child: CircularProgressIndicator(
                  backgroundColor: Colors.white,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.grey),
                ))))
        :
        // TODO: implement build
        throw UnimplementedError();
  }
}
