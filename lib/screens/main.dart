import 'package:flutter/material.dart';
import 'package:flutter_app_notepad/tab_item.dart';
import 'package:flutter_app_notepad/screens/notepad/notepad_list.dart';

void main() {
  runApp(NotePadListApp());
}


class NotePadListApp extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _NotePadListAppState();
}

class _NotePadListAppState extends State<NotePadListApp>{
  final List<TabItem> _tabItems = [
    TabItem("NotePad", Icons.clear),
    TabItem("In Progress", Icons.loop),
    TabItem("Done", Icons.check),
  ];

  int _currentTabIndex = 0;

  //Scaffold 사용, appBar 생성하고
  // 현재 선택된 탭의 인덱스로 데이터 가져오고 title 설정
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter NotePad',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        appBar: AppBar(title: Text(_tabItems[_currentTabIndex].getTitle())),
        bottomNavigationBar: _createBottomNavigationBar(),
        body: Container(
          padding: EdgeInsets.all(8.0),
          child: NotePadListPage(),
        ),
      ),
    );
  }

  Widget _createBottomNavigationBar(){
    return BottomNavigationBar(
        items: _tabItems.map((tabItem)=>
            BottomNavigationBarItem(icon: Icon(tabItem.getIcon()), label:tabItem.getTitle()),
        ).toList(),
      currentIndex: _currentTabIndex,
      onTap: (int index) => {
          _onTabClick(index)
      },
    );
  }

  void _onTabClick(int index){
    setState(() {
      _currentTabIndex = index;
    });
  }
}
