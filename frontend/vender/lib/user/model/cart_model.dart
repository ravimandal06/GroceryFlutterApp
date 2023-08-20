import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:vender/user/model/products.dart';

class CartModel extends ChangeNotifier {
  final List<GetProductRequest> productList_ = [
    GetProductRequest(
      productType: 'drinks',
      productName: 'wine',
      productPrice: 199.99,
      productStock: 10,
      productImage: 'assets/wine.jpg',
      productOfferPrice: 188.22,
      quantity: 1,
      isSelectedToCart: false,
    ),
    GetProductRequest(
      productType: 'fruits',
      productName: 'apple',
      productPrice: 88.99,
      productStock: 20,
      productImage: 'assets/apple.jpg',
      productOfferPrice: 76.22,
      quantity: 1,
      isSelectedToCart: false,
    ),
  ];

  final List _cartItems = [];
  get cartItems => _cartItems;
  get productList => productList_;

  void addToCart(int index) {
    if (_cartItems.contains(productList[index])) {
      if (cartItems[index].quantity < cartItems[index].productStock) {
        cartItems[index].quantity++;
        GetStorage().write('productName', cartItems[index].productName);
        GetStorage().write('productCategory', cartItems[index].productType);
        GetStorage().write('productPrice', cartItems[index].productPrice);
        GetStorage().write('productQuantity', cartItems[index].quantity);
        notifyListeners();
      }
    } else {
      _cartItems.add(productList[index]);
    }
    GetStorage().write('cartItems', _cartItems);
    notifyListeners();
  }

  void removeItemFromCart(int index) {
    _cartItems.removeAt(index);
    notifyListeners();
  }

  void decreaseQuantity(int index) {
    if (cartItems[index].quantity > 1) {
      cartItems[index].quantity--;
      notifyListeners();
    }
  }

  void increaseQuantity(int index) {
    if (cartItems[index].quantity < cartItems[index].productStock) {
      cartItems[index].quantity++;
      notifyListeners();
    }
  }

  int _quantity = 1;

  void _increaseQuantity() {
    _quantity++;
    notifyListeners();
  }

  void _decreaseQuantity() {
    if (_quantity > 1) {
      _quantity--;
      notifyListeners();
    }
  }

  String calculateTotal() {
    double totalPrice = 0;
    double deliveryCharge = 0;
    double discount = 0;
    for (int i = 0; i < _cartItems.length; i++) {
      totalPrice += double.parse(_cartItems[i].productPrice.toString());
      GetStorage().write('subTotal', totalPrice);
      deliveryCharge += double.parse(
          (_cartItems.length * 5).toString()); //$5 for each product
      GetStorage().write('deliveryCharge', deliveryCharge);
      totalPrice += deliveryCharge;
      discount = totalPrice * (25 / 100); //25% discount in-total
      GetStorage().write('discount', discount);
      totalPrice -= discount;
      GetStorage().write('totalPrice', totalPrice);
      totalPrice *= cartItems[i].quantity;
      GetStorage().write('totalPrice', totalPrice);
    }
    return totalPrice.toStringAsFixed(2);
  }

  String calculateSubTotalPrice() {
    double subTotal = 0;
    for (int i = 0; i < _cartItems.length; i++) {
      subTotal += double.parse(_cartItems[i].productPrice.toString());
      GetStorage().write('subTotal', subTotal);
      subTotal *= cartItems[i].quantity;
    }
    return subTotal.toStringAsFixed(2);
  }
}
