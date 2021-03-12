//String _title : NotePadItem의 제목을 의미한다.
// NotePadState _state : NotePadItem의 상태다. 할일인지, 하고 있는지, 완료되었는지를 나타낸다.
// DateTime _createdTime : NotePadItem의 생성 날짜를 나타낸다.

class NotePadModel{
  int _id;
  String _title;
  NotePadState _state;

  final DateTime _createdTime;

  NotePadModel(this._id, this._title, this._createdTime, this._state);

  String getTitle() => _title;
  DateTime getCreatedTime() => _createdTime;
  NotePadState getNotePadState() => _state;

  String setTitle(String title) => _title = title;
  NotePadState setNotePadState(NotePadState state) => _state = state;

  factory NotePadModel.fromDatabaseJson(Map<String, dynamic> data) => NotePadModel(
    data['id'],
    data['title'],
    DateTime.fromMillisecondsSinceEpoch(data['created_time'] as int),
    getNotePadStateByValue(data['state'] as int)
  );

  Map<String, dynamic> toDatabaseJson() => {
    'title':this._title,
    'created_time':this._createdTime.millisecondsSinceEpoch,
    'state':getNotePadStateValue(_state)
  };
}

enum NotePadState{
  notepad, inProgress, done
}

int getNotePadStateValue(NotePadState state){
  switch(state){
    case NotePadState.notepad:
      return 0;
    case NotePadState.inProgress:
      return 1;
    case NotePadState.done:
      return 2;
    default:
      return 0;
  }
}

NotePadState getNotePadStateByValue(int stateValue){
  switch(stateValue){
    case 0:
      return NotePadState.notepad;
    case 1:
      return NotePadState.inProgress;
    case 2:
      return NotePadState.done;
    default:
      return NotePadState.notepad;
  }
}