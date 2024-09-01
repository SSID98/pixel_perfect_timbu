import 'package:flutter/material.dart';
import 'package:pixel_perfect_timbu/pages/checkout_page.dart';
import 'package:pixel_perfect_timbu/pages/computing_page.dart';
import 'package:pixel_perfect_timbu/pages/gaming_page.dart';
import 'package:pixel_perfect_timbu/pages/main_page.dart';
import 'package:pixel_perfect_timbu/pages/mens_fashion.dart';
import 'package:pixel_perfect_timbu/pages/order_history_page.dart';
import 'package:pixel_perfect_timbu/pages/order_successful.dart';
import 'package:pixel_perfect_timbu/pages/phone_accessories_page.dart';
import 'package:pixel_perfect_timbu/pages/product_description_page.dart';
import 'package:pixel_perfect_timbu/pages/products_page.dart';
import 'package:pixel_perfect_timbu/pages/wishlist_page.dart';
import 'package:pixel_perfect_timbu/services/item_manager.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ItemManager(),
      child: const SimpleShoppingApp(),
    ),
  );
}

class SimpleShoppingApp extends StatelessWidget {
  const SimpleShoppingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: MainPage.id,
      routes: {
        MainPage.id: (context) => const MainPage(),
        ProductsPage.id: (context) => const ProductsPage(),
        CheckoutPage.id: (context) => const CheckoutPage(),
        ProductDescriptionPage.id: (context) => const ProductDescriptionPage(
              name: '',
              price: '',
              imageUrl: '',
              description: '',
              uniqueID: '',
              isAvailable: '',
            ),
        WishListPage.id: (context) => const WishListPage(),
        PhoneAccessoriesPage.id: (context) => const PhoneAccessoriesPage(),
        MensFashionPage.id: (context) => const MensFashionPage(),
        ComputingPage.id: (context) => const ComputingPage(),
        GamingPage.id: (context) => const GamingPage(),
        OrderSuccessful.id: (context) => const OrderSuccessful(),
        OrderHistoryPage.id: (context) => const OrderHistoryPage(),
      },
    );
  }
}
