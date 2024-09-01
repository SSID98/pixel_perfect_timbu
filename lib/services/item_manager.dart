import 'package:flutter/material.dart';

import '../model/products.dart';
import 'network_helper.dart';

const orgID = 'db9ac75a5b6942d68e3c98452029f75d';
const apiKey = '3f789dbf6514431b9ab3fbad7c8d96a020240707132444883782';
const appID = 'UG013DNDZ9PV7T3';

class ItemManager extends ChangeNotifier {
  int _selectedIndex = 0;
  List<Map<String, String>> checkoutItems = [];
  List<Map<String, String>> wishListItems = [];

  // final List<Map<String, String>> _items = [];
  final List<Map<String, String>> _orderHistory = []; // Order history list

  // List<Map<String, String>> get items => _items;
  List<Map<String, String>> get orderHistory =>
      _orderHistory; // Getter for order history

  int get selectedIndex =>
      _selectedIndex; //gets the integer in _selectedIndex and returns to selectedIndex

  List<Map<String, String>> get items =>
      checkoutItems; //gets the list of checkoutItems and returns to items

  List<Map<String, String>> get wishListItem =>
      wishListItems; //gets the list of wishlist and returns to item

  void onItemTapped(int index) {
    _selectedIndex = index;
    notifyListeners();
  }

  void addItem(
    String imageUrl,
    String name,
    String amount,
    String description,
    String uniqueID,
    String isAvailable,
  ) {
    checkoutItems.add({
      'imageUrl': imageUrl,
      'name': name,
      'amount': amount,
      'isAvailable': isAvailable,
      'uniqueID': uniqueID,
      'description': description,
    });
    notifyListeners();
  }

  void saveItem(
    String imageUrl,
    String name,
    String amount,
    String description,
    String uniqueID,
    String isAvailable,
  ) {
    wishListItems.add({
      'imageUrl': imageUrl,
      'name': name,
      'amount': amount,
      'isAvailable': isAvailable,
      'uniqueID': uniqueID,
      'description': description,
    });
    notifyListeners();
  }

  void removeItem(int index) {
    checkoutItems.removeAt(index);
    notifyListeners();
  }

  void removeItemByName(String name) {
    checkoutItems.removeWhere((item) => item['name'] == name);
    notifyListeners();
  }

  void orderItem(int index) {
    checkoutItems.removeAt(index);
    notifyListeners();
  }

  void unSaveItem(int index) {
    wishListItems.removeAt(index);
    notifyListeners();
  }

  void addItemToCart(int index, String imageUrl, String name, String amount) {
    wishListItems.add({
      'imageUrl': imageUrl,
      'name': name,
      'amount': amount,
    });
    wishListItems.removeAt(index);
    notifyListeners();
  }

  void navigateToPage(int index) {
    _selectedIndex = index;
    notifyListeners();
  }

  // void buyNow() {
  //   checkoutItems.add({
  //     'imageUrl': imageUrl,
  //     'name': name,
  //     'amount': amount,
  //     'isAvailable': isAvailable,
  //     'uniqueID': uniqueID,
  //     'description': description,
  //   });; // Add all items to order history
  //   items.clear(); // Clear the cart
  //   notifyListeners();
  // }

  void completeOrder() {
    _orderHistory.addAll(items); // Add all items to order history
    items.clear(); // Clear the cart
    notifyListeners();
  }

  Future<List<Product>> getProductData(int page) async {
    List<Product> products = [];
    NetworkHelper networkHelper = NetworkHelper(
        'https://api.timbu.cloud/products?organization_id=$orgID&reverse_sort=false&page=$page&size=10&Appid=$appID&Apikey=$apiKey');
    var productData = await networkHelper.getData();

    for (var eachProduct in productData['items']) {
      final name = eachProduct['name'];
      final currentPriceList = eachProduct['current_price'];
      final description = eachProduct['description'];
      final uniqueID = eachProduct['unique_id'];
      final availability = eachProduct['is_available'];
      String isAvailable = 'false';
      if (availability == true) {
        isAvailable = 'In Stock';
      }
      String price = '0';
      if (currentPriceList.isNotEmpty) {
        final ngnList = currentPriceList[0]['NGN'];
        if (ngnList != null && ngnList.isNotEmpty) {
          price = ngnList[0].toString();
        }
      }
      final photosList = eachProduct['photos'];
      final imageUrl = photosList.isNotEmpty ? photosList[0]['url'] : '';
      final product = Product(
          name: name,
          price: price,
          imageUrl: imageUrl,
          description: description,
          uniqueID: uniqueID,
          isAvaliable: isAvailable);
      products.add(product);
    }
    return products;
  }

  Future<List<Product>> getFilteredProductData(String categoryName) async {
    List<Product> products = [];

    // Fetch products from page 1
    products.addAll(await _fetchProductsFromPage(1, categoryName));
    // Fetch products from page 2
    products.addAll(await _fetchProductsFromPage(2, categoryName));

    return products;
  }

  Future<List<Product>> _fetchProductsFromPage(
      int page, String categoryName) async {
    List<Product> products = [];
    NetworkHelper networkHelper = NetworkHelper(
        'https://api.timbu.cloud/products?organization_id=$orgID&reverse_sort=false&page=$page&size=10&Appid=$appID&Apikey=$apiKey');
    var productData = await networkHelper.getData();

    for (var eachProduct in productData['items']) {
      final name = eachProduct['name'];
      final currentPriceList = eachProduct['current_price'];
      final description = eachProduct['description'];
      final uniqueID = eachProduct['unique_id'];
      final availability = eachProduct['is_available'];
      String isAvailable = 'false';
      if (availability == true) {
        isAvailable = 'In Stock';
      }
      String price = '0';
      if (currentPriceList.isNotEmpty) {
        final ngnList = currentPriceList[0]['NGN'];
        if (ngnList != null && ngnList.isNotEmpty) {
          price = ngnList[0].toString();
        }
      }
      final photosList = eachProduct['photos'];
      final imageUrl = photosList.isNotEmpty ? photosList[0]['url'] : '';
      final categoriesList = eachProduct['categories'];
      final category =
          categoriesList.isNotEmpty ? categoriesList[0]['name'] : '';

      if (category.toLowerCase() == categoryName.toLowerCase()) {
        final product = Product(
            name: name,
            price: price,
            imageUrl: imageUrl,
            description: description,
            uniqueID: uniqueID,
            isAvaliable: isAvailable);
        products.add(product);
      }
    }
    return products;
  }
}
