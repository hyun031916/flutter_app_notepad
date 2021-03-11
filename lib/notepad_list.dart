import 'package:flutter/material.dart';

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