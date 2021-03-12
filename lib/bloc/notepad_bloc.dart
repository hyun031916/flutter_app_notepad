import 'dart:async';

import 'package:flutter_app_notepad/models/notepad_model.dart';
import 'package:flutter_app_notepad/repository/notepad_repository.dart';

class NotePadBloc{
  final NotePadRepository _notepadRepository;
  final StreamController<List<NotePadModel>> _notepadController = StreamController<List<NotePadModel>>.broadcast();

  get notepadListStream => _notepadController.stream;
  NotePadBloc(this._notepadRepository) {
    getNotePadList();
  }

  void getNotePadList() async {
    List<NotePadModel> notepadList = await _notepadRepository.getNotePadList();
    _notepadController.sink.add(notepadList);
  }

  void addNotePad(NotePadModel notepad) async {
    await _notepadRepository.createNotePad(notepad);
    getNotePadList();
  }

}