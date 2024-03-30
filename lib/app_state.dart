import 'package:flutter/material.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'flutter_flow/flutter_flow_util.dart';

class FFAppState extends ChangeNotifier {
  static final FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal();

  Future initializePersistedState() async {}

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  String _selectedMnu = 'home';
  String get selectedMnu => _selectedMnu;
  set selectedMnu(String _value) {
    _selectedMnu = _value;
  }

  bool _spinRoulette = false;
  bool get spinRoulette => _spinRoulette;
  set spinRoulette(bool _value) {
    _spinRoulette = _value;
  }

  List<String> _Boletos = [];
  List<String> get Boletos => _Boletos;
  set Boletos(List<String> _value) {
    _Boletos = _value;
  }

  void addToBoletos(String _value) {
    _Boletos.add(_value);
  }

  void removeFromBoletos(String _value) {
    _Boletos.remove(_value);
  }

  void removeAtIndexFromBoletos(int _index) {
    _Boletos.removeAt(_index);
  }

  void updateBoletosAtIndex(
    int _index,
    String Function(String) updateFn,
  ) {
    _Boletos[_index] = updateFn(_Boletos[_index]);
  }

  bool _seeWinner = false;
  bool get seeWinner => _seeWinner;
  set seeWinner(bool _value) {
    _seeWinner = _value;
  }

  bool _seeVideo = false;
  bool get seeVideo => _seeVideo;
  set seeVideo(bool _value) {
    _seeVideo = _value;
  }


  bool _seePrize = false;
  bool get seePrize => _seePrize;
  set seePrize(bool _value) {
    _seePrize = _value;
  }




  bool _seeCount = false;
  bool get seeCount => _seeCount;
  set seeCount(bool _value) {
    _seeCount = _value;
  }

}

LatLng? _latLngFromString(String? val) {
  if (val == null) {
    return null;
  }
  final split = val.split(',');
  final lat = double.parse(split.first);
  final lng = double.parse(split.last);
  return LatLng(lat, lng);
}

void _safeInit(Function() initializeField) {
  try {
    initializeField();
  } catch (_) {}
}

Future _safeInitAsync(Function() initializeField) async {
  try {
    await initializeField();
  } catch (_) {}
}
