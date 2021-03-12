import 'package:flutter/material.dart';
import 'package:flutter_app_notepad/bloc/notepad_bloc.dart';
import 'package:flutter_app_notepad/database/dao/notepad_dao.dart';
import 'package:flutter_app_notepad/repository/notepad_repository.dart';

import 'package:intl/intl.dart';
import 'package:flutter_app_notepad/models/notepad_model.dart';

//StatefulWidget의 뼈대 만들기
//목록이 추가, 삭제, 수정되면서 상태가 변경되는 Page => StatefulWidget
class NotePadListPage extends StatelessWidget{
  static const String NOTEPAD_DATE_FORMAT = 'yyy-MM-dd';

  final TextEditingController _notepadTitleController = TextEditingController();
  final NotePadBloc _notepadBloc = NotePadBloc(
      NotePadRepository(
          NotePadDao()
      )
  );

  //_createNotePadList() 호출하여 화면 그리기
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //FloatingActionButton을 생성하고 누를경우(onPressed)
      // _openAddTodoDialog를 호출하여 AlertDialog 보여줌줌
      floatingActionButton: _createFloatingActionButton(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      body: _createNotePadListStreamBuilder(),
    );
  }

  Widget _createFloatingActionButton(BuildContext context){
    return FloatingActionButton(
      child: Icon(Icons.add, color: Colors.white),
      onPressed: ()=>{
        _openAddNotePadDialog(context)
      },
    );
  }

  Widget _createNotePadListStreamBuilder(){
    return StreamBuilder(
      stream: _notepadBloc.notepadListStream,
      builder: (BuildContext context, AsyncSnapshot<List<NotePadModel>> snapshot){
        if(snapshot.hasData){
          if(snapshot.data.length > 0){
            return _createNotePadList(snapshot.data);
          }else{
            return Container();
          }
        }else{
          return Container();
        }
      },
    );
  }
  Widget _createNotePadList(List<NotePadModel> notepadList){
    return ListView.separated(
        itemCount: notepadList.length,
        itemBuilder: (BuildContext context, int index){
          return _createNotePadCard(notepadList[index]);
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

  Widget _createNotePadCard(NotePadModel notePadModel){
    return Card(
      elevation: 4.0,
      //귀퉁이가 약간 둥근 형태의 카드
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0))
      ),
      child: Container(
        padding: EdgeInsets.all(16.0),
        child: _createNotePadItemRow(notePadModel)
      ),
    );
  }

  //Row를 사용하여 좌측에 _createNotePadItemContentWidget을
  //우측에 오른쪽 화살표 모양의 아이콘 갖는 Row 반환하기
  Widget _createNotePadItemRow(NotePadModel notePadModel){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _createNotePadItemContentWidget(notePadModel),
        Icon(Icons.keyboard_arrow_right, color:Colors.blue)
      ],
    );
  }

  //Column 사용하여 구현. 위는 NotePad Item의 Title을,
  //아래에는 NotePad Item의 생성 날짜를 나타내는 Text로 구성
  Widget _createNotePadItemContentWidget(NotePadModel notePadModel){
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(notePadModel.getTitle(),
          style: TextStyle(fontSize: 24.0, color:Colors.blue)),
        Divider(
          thickness: 8.0,
          height: 8.0,
          color: Colors.transparent,
        ),
        Text(DateFormat(NOTEPAD_DATE_FORMAT).format(notePadModel.getCreatedTime()),
        style: TextStyle(fontSize: 18.0, color: Colors.blueGrey))
      ],
    );
  }



  void _openAddNotePadDialog(BuildContext context){
    showDialog(
        context: context,
        builder: (BuildContext context){
          //AlertDialog를 보여주기 위해서 "showDialog" 함수에 AlertDialog를 넘겨주면 된다.
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
              FlatButton(
                  child: new Text(
                    "추가",
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.blue
                    ),
                  ),
                  onPressed: (){
                    _addNewNotePad(_notepadTitleController.text);
                    _notepadTitleController.text = "";
                    Navigator.pop(context);
                  }
              ),
            ],
          );
        }
    );
  }


  //다이얼로그의 "추가" 버튼을 누르면 _addNewTodo가 호출됨
  void _addNewNotePad(String title) async {
    NotePadModel newNotePad = NotePadModel(
        null, title, DateTime.now(), NotePadState.notepad);
    _notepadBloc.addNotePad(newNotePad);
  }

}
