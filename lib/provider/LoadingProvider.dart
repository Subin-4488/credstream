import 'package:flutter/material.dart';

class LoadingProvider with ChangeNotifier {
  bool loading = false;

  void startLoading() {
    loading = true;
    notifyListeners();
  }

  void stopLoading() {
    loading = false;
    notifyListeners();
  }
}
