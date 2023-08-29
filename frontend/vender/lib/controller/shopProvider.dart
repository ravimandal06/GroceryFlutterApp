import 'package:flutter/material.dart';

import '../model/shopDetails.dart';

class ShopProvider extends ChangeNotifier {
  ShopDetails? _shopDetails;

  ShopDetails? get shopDetails => _shopDetails;

  void setShopDetails(ShopDetails details) {
    _shopDetails = details;
    notifyListeners();
  }
}
