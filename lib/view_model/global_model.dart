import 'package:flutter/cupertino.dart';

class GlobalModel extends ChangeNotifier {
  bool _isGlobal = true;

  bool get isGlobal => _isGlobal;

  setGlobal(bool global) {
    _isGlobal = global;
    notifyListeners();
  }
}