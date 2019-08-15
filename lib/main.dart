import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
Widget build(BuildContext context){
    return MaterialApp(
      title:"Zoo",
      home:Scaffold(
        appBar: AppBar(
          centerTitle:false,
          leading: Icon(Icons.menu),
          title: Text("台北市立動物園"),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.apps),
              onPressed: (){
                debugPrint("inPressed");
              },
            )
          ],
          ),
        body: ListView.separated(
          itemCount:10,
          separatorBuilder: (BuildContext context, int index){
            return Container(
              height: 4,
              color: Colors.redAccent,
            );
          },
          itemBuilder: (BuildContext context, int index){
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Row(
                children: <Widget>[
                  Image.asset("images/ic_placeholder.png"),
                  SizedBox(
                    width: 8,
                  ),
                  Column( // 預設值為置中
                    crossAxisAlignment: CrossAxisAlignment.start, // 左側對齊
                   children: <Widget>[
                    Text("AAA") ,
                     SizedBox(
                       height: 8,
                     ),
                     Text("AAAAAAAAAAAA") ,
                     SizedBox(
                       height: 8,
                     ),
                     Text("AAA") ,
                   ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
