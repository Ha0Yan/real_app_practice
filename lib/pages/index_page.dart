import 'package:flutter/material.dart';
//ios端 风格
import 'package:flutter/cupertino.dart';
import 'home_page.dart';
import 'category_page.dart';
import 'search_page.dart';
import 'profile_page.dart';

class IndexPage extends StatefulWidget {
  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  //创建底部导航栏 变量值
  final List<BottomNavigationBarItem> bottomTabs = [
    BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.home), title: Text("Homepage")),
    BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.search), title: Text("Category")),
    BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.search), title: Text("Search")),
    BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.profile_circled), title: Text("Profile")),
  ];

  //定义list变量 将分页的class 引入，以后使用哪个就选哪个
  final List tabBodies = [
    HomePage(),
    CategoryPage(),
    SearchPage(),
    ProfilePage(),
  ];
  //index 用来选择哪个页面
  int currentIndex = 0;
  var currentPage;

  //初始化 首页页面
  @override
  void initState() {
    //第一个打开的时候 就是这个首页 currentIndex = 0
    currentPage = tabBodies[currentIndex];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(244, 245, 245, 1.0),
      bottomNavigationBar: BottomNavigationBar(
        //有几个页面， 给出定义的变量bottom Tabs
        items: bottomTabs,
        //固定bottom icon
        type: BottomNavigationBarType.fixed,
        //现在的页面 index 要给定
        currentIndex: currentIndex,
        //点击事件：在此页面显示：给个回调函数
        onTap: (index){
          setState(() {
            //点击后 将现有index 赋值给 已经定义好的 currentIndex
            currentIndex = index;
            // 再用currentIndex 来调取 tabBodies 中的 每个页面 达到切换页面效果
            currentPage = tabBodies[currentIndex];
          });
        },
      ),
      // body直接传入class 页面class传入 显示页面
      body: currentPage,
    );
  }
}
