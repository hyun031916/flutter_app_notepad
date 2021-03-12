import 'package:flutter_app_notepad/models/notepad_model.dart';
import 'package:flutter_app_notepad/database/dao/notepad_dao.dart';

class NotePadRepository{
  final NotePadDao _notepadDao;

  NotePadRepository(this._notepadDao);

  Future<List<NotePadModel>> getNotePadList() => _notepadDao.getNotePadList();

  Future<int> createNotePad(NotePadModel notepad) => _notepadDao.createNotePad(notepad);
}
