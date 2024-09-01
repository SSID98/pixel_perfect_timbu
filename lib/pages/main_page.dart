import 'package:flutter/material.dart';
import 'package:pixel_perfect_timbu/pages/order_history_page.dart';
import 'package:pixel_perfect_timbu/pages/products_page.dart';
import 'package:pixel_perfect_timbu/pages/wishlist_page.dart';
import 'package:provider/provider.dart';

import '../services/item_manager.dart';

class MainPage extends StatefulWidget {
  static const String id = 'main_page';

  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final PageStorageBucket bucket = PageStorageBucket();

  @override
  Widget build(BuildContext context) {
    return Consumer<ItemManager>(builder: (context, itemManager, child) {
      return Scaffold(
        backgroundColor: Colors.white,
        body: PageStorage(
          bucket: bucket,
          child: IndexedStack(
            index: itemManager.selectedIndex,
            children: const [
              ProductsPage(),
              WishListPage(),
              Placeholder(),
              OrderHistoryPage(),
            ],
          ),
        ),
        bottomNavigationBar: Theme(
          data: Theme.of(context).copyWith(
            // sets the background color of the `BottomNavigationBar`
            canvasColor: Colors.white,
            // sets the active color of the `BottomNavigationBar` if `Brightness` is light
            primaryColor: Colors.white,
          ), // sets the inactive color of the `BottomNavigationBar`(
          child: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                label: 'Products',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite_border),
                label: 'Wishlist',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_outline),
                label: 'Profile',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.history_sharp),
                label: 'History',
              ),
            ],
            currentIndex: itemManager.selectedIndex,
            selectedItemColor: const Color(0xff1F2223),
            unselectedItemColor: Colors.grey,
            onTap: itemManager.onItemTapped,
          ),
        ),
      );
    });
  }
}
