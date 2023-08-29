import '../model/shopDetails.dart';

class ShopManager {
  static final ShopManager _instance = ShopManager._internal();

  factory ShopManager() {
    return _instance;
  }

  ShopDetails? _shopDetails;

  ShopDetails? get shopDetails => _shopDetails;

  void setShopDetails(ShopDetails details) {
    _shopDetails = details;
  }

  ShopManager._internal();
}
