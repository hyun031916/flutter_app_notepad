import 'package:flutter/material.dart';

void main() {
  runApp(NotePadApp());
}
class TabItem {
  String _title;
  IconData _icon;
  TabItem(String title, IconData icon) {
    _title = title;
    _icon = icon;
  }
  String getTitle() => _title;
  IconData getIcon() => _icon;
}

class NotePadApp extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _NotePadApp();
}

class _NotePadApp extends State<NotePadApp>{
  final List<TabItem> _tabItems = [
    TabItem("note", Icons.clear),
    TabItem("In Progress", Icons.loop),
    TabItem("Done", Icons.check),
  ];

  int _currentTabIndex = 0;

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
