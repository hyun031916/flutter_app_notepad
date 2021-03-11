//String _title : NotePadItem의 제목을 의미한다.
// NotePadState _state : NotePadItem의 상태다. 할일인지, 하고 있는지, 완료되었는지를 나타낸다.
// DateTime _createdTime : NotePadItem의 생성 날짜를 나타낸다.

class NotePadModel{
  String _title;
  NotePadState _state;

  final DateTime _createdTime;

  NotePadModel(this._title, this._createdTime){
    _state = NotePadState.notepad;
  }

  String getTitle() => _title;
  DateTime getCreatedTime() => _createdTime;
  NotePadState getNotePadState() => _state;

  String setTitle(String title) => _title = title;
  NotePadState setNotePadState(NotePadState state) => _state = state;

}

enum NotePadState {
  notepad, inProgress, done
}