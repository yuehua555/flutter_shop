import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  TextEditingController typeController = TextEditingController();
  String showText = '欢迎你来到美好人家';

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(title: Text('美好人间'),),
        body: Container(
          height: 1000,
          child: Column(
            children: <Widget>[
              TextField(
                controller: typeController,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(10.0),
                  labelText: '美女类型',
                  helperText: 'Please input your favorite'
                ),
                autofocus: false,
                ),
          RaisedButton(
            onPressed: _choiceAction,
            child: Text('选择完毕'),
              ),
              Text(
                showText,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              )
            ],
          ),
        ),
      ),
    );
  }

  void _choiceAction() {
    print('开始选择你喜欢的类型。。。。。。');
    if (typeController.text.toLowerCase() =='') {
      showDialog(context: context,
      builder: (context) => AlertDialog(title: Text('美女类型不能为空')));
    } else {
      getHttp(typeController.text.toString()).then((val)
      {
        setState(() {
          showText = val['data']['name'].toString();
        });
      });
    }
  }

  Future getHttp(String typeText) async {
    try{
      Response response;
      var data = {'name': typeText};
      response = await Dio().post(
        'https://easy-mock.bookset.io/mock/5dd3b8cbbc273b7dc8149c7a/example/test',
        queryParameters: data
      );
      return response.data;
  }catch(e){
      return print(e);
    }
  }
}

