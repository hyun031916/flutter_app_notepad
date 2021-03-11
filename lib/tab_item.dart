import 'package:flutter/material.dart';

class TabItem {
  String _title;
  IconData _icon;
  TabItem(String title, IconData icon) {
    _title = title;
    _icon = icon;
  }
  String getTitle() => _title;
  IconData getIcon() => _icon;
}