import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:taipei_zoo/api_data.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title:"Zoo",
      theme: ThemeData(),
      home:new ZooStoreListPage(), // 抽出Scaffold 建立ZooStoreListPage Widget
    );
  }
}


class ZooStoreListPage extends StatefulWidget { // option + Enter 將StatefulWidget轉乘StatelessWidget
  const ZooStoreListPage({
    Key key,
  }) : super(key: key);

  @override
  _ZooStoreListPageState createState() => _ZooStoreListPageState();
}

class _ZooStoreListPageState extends State<ZooStoreListPage> {
// 加入Api fetchData()
  ZooData _data;
  _fetchData() async {
    var url =
        'https://data.taipei/opendata/datalist/apiAccess?scope=resourceAquire&rid=5a0e5fbb-72f8-41c6-908e-2fb25eff9b8a';
    var response = await http.get(url);
    print('Response status: ${response.statusCode}');

    // Utf8Decoder()解決中文亂碼
    Utf8Decoder decode = Utf8Decoder();
    String resultUtf8 = decode.convert(response.bodyBytes);
    print('Response body: ${resultUtf8}');

    // import 'package:taipei_zoo/api_data.dart';
    // setState(() {}) 狀態改變後會執行callback
    setState(() {
      _data = ZooData.fromJson(json.decode(resultUtf8));
    });
  }

  //control + Enter快捷鍵 choose method to override 找一開始開app就load一次資料 initState()
  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  bool _isShowList = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle:false,
        leading: Icon(Icons.menu),
        title: Text("台北市立動物園"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.apps),
            onPressed: (){
              debugPrint("onPressed");
              setState(() {
                _isShowList = ! _isShowList;
              });
            },
          )
        ],
        ),

      body: _isShowList // 方格內容設定
          ? _getPageList()
          : _getPageGrid() ,
    );
  }

  GridView _getPageGrid() {
    return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          childAspectRatio: 3/5,
        ),
            itemBuilder: (BuildContext context, int index){
              var item = _data.result.results[index];
              String storeTitle = item.eName;
              String storeInfo = item.eInfo;
              String storeMemo = item.eMemo;
              String storeImg = item.ePicURL;
                return Column( // 預設值為置中
                  children: <Widget>[
                    Image.network(storeImg),
                    Text(
                      storeTitle,
                      style: TextStyle(
                        fontSize: 20,
                      ) ,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ) ,
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      storeInfo,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ) ,
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      storeMemo,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ) ,
                  ],
                );
      },
    );
  }

  ListView _getPageList() {
    return ListView.separated(
      itemCount:_data == null ? 0 : _data.result.results.length, // if?成立的話就0，不然就：
      separatorBuilder: (BuildContext context, int index){
        return Container(
          height: 1,
          color: Color(0xFFF1F1F1),
        );
      },
      itemBuilder: _getPageListItem,
    );
  }


  Widget _getPageListItem(BuildContext context, int index){

      var item = _data.result.results[index];
      String storeTitle = item.eName;
      String storeInfo = item.eInfo;
      String storeMemo = item.eMemo;
      String storeImg = item.ePicURL;

      return Padding(
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Row(
          children: <Widget>[
            Image.network(
              storeImg,
              width: 100,
              height: 100,
              fit: BoxFit.cover, // 等比放大
            ),
            SizedBox(
              width: 8,
            ),
            // Column外層包一層 Expended Widget
            Expanded(
              child: Column( // 預設值為置中
                crossAxisAlignment: CrossAxisAlignment.start, // 左側對齊
               children: <Widget>[
                Text(
                  storeTitle,
                  style: TextStyle(
                  fontSize: 20,
                  color: Colors.blueAccent,
                  ) ,
                  maxLines: 1,
                ) ,
                 SizedBox(
                   height: 8,
                 ),
                 Text(
                   storeInfo,
                   maxLines: 2,
                   overflow: TextOverflow.ellipsis,
                 ) ,
                 SizedBox(
                   height: 8,
                 ),
                 Text(
                   storeMemo,
                   maxLines: 1,
                   overflow: TextOverflow.ellipsis,
                 ) ,
               ],
              ),
            ),
          ],
        ),
      );
    }
}
