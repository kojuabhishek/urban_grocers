import 'package:flutter/material.dart';

import 'Items.dart';

class ItemsProviders extends ChangeNotifier {
  List<Items> _items = <Items>[];

  List<Items> get getItems {
    return _items;
  }

  //function to add items
  void addItems(String title, String description) {
    Items item = new Items(title, description);
    _items.add(item);
    notifyListeners();
  }

  //function to delete items(add to card)
  void removeItems(int index) {
    _items.remove(index);
    notifyListeners();
  }
}
