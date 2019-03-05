import 'package:flutter/material.dart';
//引入 第三方http请求库
import 'package:dio/dio.dart';



class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  //定义一个 type controller
  TextEditingController typeController = TextEditingController();
  String showText = "Data from sever showing here...";

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text("testing - HTTP GET"),
        ),
        body:
        SingleChildScrollView(child:Container(
          child: Column(
            children: <Widget>[
              //放一个文本框
              TextField(
                controller: typeController,
                //修饰文本框
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(10.0),
                  labelText: "Label Text (testing)",
                  helperText: "Input anything here...",
                ),
                //避免手机键盘自己跳出来 打乱布局
                autofocus: false,
              ),
              //放一个button
              RaisedButton(
                //点击触发 HTTP Get 请求
                onPressed: (){_ValueSelection();},
                child: Text("Date entry completed"),
              ),
              //给一个string 变量作为提示文字
              //限制overflow 如果超出container 显示省略号
              //限制显示行数为1行
              Text(showText,overflow: TextOverflow.ellipsis,maxLines: 1,)
            ],
          ),
        ),)

      ),
    );
  }

  //下拉框参数定义，根据flutter 习惯，使用下划线开头
  void _ValueSelection(){
    //请求数据需要时间，print一句话 来证明用户的操作已经在进行。
    print("request sent.....");
    //判断用户输入限制 例如空输入
    //输入为空
    if(typeController.text.toString() == ""){
      //跳一个对话框（箭头函数将传入的context值覆盖为 text Widget里我们要表达的东西）
      showDialog(context: context,builder: (context)=>AlertDialog(title: Text("Nothing input!"),));
    }
  else{
  //请求数据，传入用户输入值typeController.text.toString()
  //.then 接回调函数，返回值val
  getHTTP(typeController.text.toString()).then((val){
  //通过改变状态：改变button下的内容
  setState(() {
  //val 是map类型 改变我们定义的showText内容要按以下方式改变（dart语言内容）
  showText = val['data']['name'].toString();
  });
  });
  }
}

  //之前测试用的 void 不返回值，实际上应该使用Future 返回
  Future getHTTP(String TypeText) async{
    //catch error & pringt
    try{
      //返回值response，服务器将要返回的对象
      Response response;
      //远程请求：因为有握手过程，需要加一个await 等待（必须使用异步async才能用 await，成对出现)
      //找了一个别人在easyMock上制作的简单接口 用于小案例测试
      // https://www.easy-mock.com/mock/5c60131a4bed3a6342711498/baixing/dabaojian
      //当开发团队后端写好之后，用后端地址直接替换这个地址就可以了。
      //避免先写成静态 后再改成动态的麻烦
      //截图中 带参数用"?" 传递值是"=" 后的值：Hao    (直接传递方式，一种方式)

      //get的类型 为map类型， 将传递的参数 放在这个里面
      var data = {"name":TypeText};
      //data参数进行传递值
      //GET:response = await Dio().get("https://www.easy-mock.com/mock/5c60131a4bed3a6342711498/baixing/dabaojian",queryParameters: data);
      //POST:
      //post 适用面更广，如果实际项目中 要将很多数据的表单 传入后台时 用post， post更好用
      response = await Dio().post("https://www.easy-mock.com/mock/5c7dc5dec260db50c2ca58ab/flutter_test/test_post", queryParameters: data);
      //输出从服务器拿到的值
      return response.data;

    }
    catch(e){
      return print(e);
    }

  }
}

