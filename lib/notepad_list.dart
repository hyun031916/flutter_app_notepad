import 'package:flutter/material.dart';
import 'package:flutter_app_notepad/notepad_model.dart';

//StatefulWidget의 뼈대 만들기
//목록이 추가, 삭제, 수정되면서 상태가 변경되는 Page => StatefulWidget
class NotePadListPage extends StatefulWidget{

  @override
  State<StatefulWidget> createState() => _NotePadListPage();
}

class _NotePadListPage extends State<NotePadListPage>{

  //_createNotePadList() 호출하여 화면 그리기
  @override
  Widget build(BuildContext context) {
    return _createNotePadList();
  }

  Widget _createNotePadList(){
    return ListView.separated(
        itemCount: 10,
        itemBuilder: (BuildContext context, int index){
          return _createNotePadCard();
        },
        separatorBuilder: (BuildContext context, int index){
          return Divider(
            thickness: 8.0,
            height: 8.0,
            color: Colors.transparent,
          );
        },
    );
  }

  Widget _createNotePadCard(){
    return Card(
      elevation: 4.0,
      //귀퉁이가 약간 둥근 형태의 카드
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8.0))),
      child: Container(
        padding: EdgeInsets.all(16.0),
        child: _createNotePadRow()
      ),
    );
  }

  //Row를 사용하여 좌측에 _createNotePadItemContentWidget을
  //우측에 오른쪽 화살표 모양의 아이콘 갖는 Row 반환하기
  Widget _createNotePadRow(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _createNotePadItemContentWidget(),
        Icon(Icons.keyboard_arrow_right, color:Colors.blue)
      ],
    );
  }

  //Column 사용하여 구현. 위는 NotePad Item의 Title을,
  //아래에는 NotePad Item의 생성 날짜를 나타내는 Text로 구성
  Widget _createNotePadItemContentWidget(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("NotePad Item Title",
          style: TextStyle(fontSize: 24.0, color:Colors.blue)),
        Divider(
          thickness: 8.0,
          height: 8.0,
          color: Colors.transparent,
        ),
        Text("2021.03.11",
        style: TextStyle(fontSize: 18.0, color: Colors.blueGrey))
      ],
    );
  }
}


class _NotePadListPageState extends State<NotePadListPage>{
  final TextEditingController _notepadTitleController = TextEditingController();
  List<NotePadModel> _notepadList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //FloatingActionButton을 생성하고 누를경우(onPressed)
      // _openAddTodoDialog를 호출하여 AlertDialog 보여줌줌
        floatingActionButton: _createFloatingActionButton(),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        body: _createNotePadList(),
    );
  }

  Widget _createFloatingActionButton(){
    return FloatingActionButton(
        child: Icon(Icons.add, color: Colors.white),
      onPressed: ()=>{
          _openAddNotePadDialog()
    },
    );
  }

  void _openAddNotePadDialog(){
    showDialog(
      context: context,
      builder: (BuildContext context){
        //AlertDialog를 보여주기 위해서 "showDialog" 함수에 AlertDialog를 넘겨주면 된다.
        //
        // 출처: https://doitddo.tistory.com/119?category=954509 [두잇뚜]
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0)
          ),
          title: Text(
            "여기에 입력해주세요.",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24.0,
              color: Colors.blue
            ),
          ),
          content: TextField(
            controller: _notepadTitleController,
          ),
          actions: [
            FlatButton(
              child: new Text(
                "취소",
                style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.red
                  ),
              ),
              onPressed: (){
                _notepadTitleController.text="";
                Navigator.pop(context);
              },
            ),
          ],
        );
      }
    );
  }


  //다이얼로그의 "추가" 버튼을 누르면 _addNewTodo가 호출됨
  void _addNewNotePad(String title){
    NotePadModel newNotePad = NotePadModel(title, DateTime.now());
    //, "setState" 함수 내부에서 _todoList에 새로 생성된 TodoModel 객체를 추가
    setState(() {
      _notepadList.add(newNotePad);
    });
  }

  _createNotePadList() {}
}
