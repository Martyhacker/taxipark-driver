import 'package:flutter/material.dart';

enum ModalType { none, services, from, where, when }

class ModalProvider extends ChangeNotifier {
  ModalType modalType = ModalType.services;

  changeType(ModalType type) {
    modalType = type;
    notifyListeners();
  }
}
