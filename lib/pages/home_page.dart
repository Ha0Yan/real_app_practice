import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import '../config/httpHeaders.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String showText = "No data now!";
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
          appBar: AppBar(
            title: Text("data falsification"),
          ),
          body: Center(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  RaisedButton(
                    onPressed: _testDATA,
                    child: Text("request Data"),
                  ),
                  Text(
                    showText,
                    maxLines: 1,
                  )
                ],
              ),
            ),
          )),
    );
  }

  //调用

  void _testDATA() {
    print("get data from website......");
    getHTTP().then((val) {
        setState(() {
          showText = val['data'].toString();
        });
    });
  }

  Future getHTTP() async {
    try {
      Response response;
      Dio dio = new Dio();
      //设置header
      dio.options.headers = HTTPHeaders;
      response =
          await dio.get("https://time.geekbang.org/serv/v1/column/newAll");
      //显示在console
      print(response);
      return response.data;
    } catch (e) {
      return print(e);
    }
  }
}
