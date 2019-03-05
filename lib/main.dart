//google 推出 移动端 设计风格
import 'package:flutter/material.dart';
//ios端 风格
import 'package:flutter/cupertino.dart';
import 'package:real_app_practice/pages/index_page.dart';

void main()=>runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //外壳带container 以后好扩展
    return Container(
      child: MaterialApp(
        title: "Real Application Practice",
        //模拟界面右上角会有debug，去掉
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.pink
        ),
        //call 其他文件的class
        home: IndexPage(),
      ),
    );
  }
}
