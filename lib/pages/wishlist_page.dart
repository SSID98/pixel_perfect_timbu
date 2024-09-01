import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:pixel_perfect_timbu/components/custom_button.dart';
import 'package:pixel_perfect_timbu/pages/product_description_page.dart';
import 'package:provider/provider.dart';

import '../components/wishlist_card.dart';
import '../services/item_manager.dart';
import 'checkout_page.dart';

class WishListPage extends StatelessWidget {
  static const String id = 'wishlist_page';

  const WishListPage({
    super.key,
  });

  String formatNumber(String numberString) {
    final number = double.parse(numberString);
    final formatter = NumberFormat('₦#,##0', 'en_NG');
    return formatter.format(number);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ItemManager>(builder: (context, itemManager, child) {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          toolbarHeight: 40.0,
          titleSpacing: 6.0,
          leading: Padding(
            padding: const EdgeInsets.only(left: 24.0),
            child: IconButton(
              onPressed: () {
                itemManager.navigateToPage(0);
              },
              icon: const Icon(
                Icons.arrow_back_sharp,
                size: 16.0,
                weight: 1.09,
                color: Color(0xff1F2223),
              ),
            ),
          ),
          title: Text(
            'WishList',
            style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600,
                fontSize: 16.0,
                color: const Color(0xff0A0B0A)),
          ),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(0.0, 0.0, 24.0, 0.0),
              child: IconButton(
                icon: const Icon(Icons.shopping_cart_outlined),
                onPressed: () {
                  Navigator.of(context).pushNamed(CheckoutPage.id);
                },
              ),
            ),
          ],
        ),
        body: itemManager.wishListItem.isEmpty
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.favorite_border_sharp,
                      size: 100,
                      color: Color(0xff408C2B),
                      weight: 4,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Your Wishlist is empty',
                      style: GoogleFonts.lora(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xff0A0B0A),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.only(left: 40.0, right: 40.0),
                      child: Text(
                        'Explore our collections today and start your journey towards a beautiful shopping experience in our Timbu shop.',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xff818181),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    CustomButton(
                      colour: const Color(0xff408C2B),
                      label: 'Start shopping',
                      onPress: () {
                        itemManager.navigateToPage(0);
                      },
                      width: 160,
                      height: 48,
                      borderRadius: 6.0,
                      padvertical: 0,
                      padhorizontal: 16.0,
                      borderWidth: 2,
                      fill: const Color(0xff408C2B),
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xffFFFFFF),
                      ),
                    )
                  ],
                ),
              )
            : Padding(
                padding: const EdgeInsets.only(left: 15.0, right: 12.0),
                child: ListView.builder(
                  itemCount: itemManager.wishListItem.length,
                  itemBuilder: (context, index) {
                    final item = itemManager.wishListItem[index];

                    // Check for null values before passing to ProductDescriptionPage
                    final imageUrl = item['imageUrl'] ?? '';
                    final name = item['name'] ?? '';
                    final amount = item['amount'] ?? '';
                    final description = item['description'] ?? '';
                    final uniqueID = item['uniqueID'] ?? '';
                    final isAvailable = item['isAvailable'] ?? '';

                    return Padding(
                      padding: const EdgeInsets.only(right: 10.0, top: 8.0),
                      child: Column(
                        children: [
                          Center(
                            child: WishListCard(
                              imageUrl: imageUrl,
                              name: name,
                              amount: amount,
                              onOrder: () {
                                itemManager.addItem(
                                  imageUrl,
                                  name,
                                  amount,
                                  description,
                                  uniqueID,
                                  isAvailable,
                                );
                                itemManager.unSaveItem(index);
                              },
                              onRemove: () {
                                itemManager.unSaveItem(index);
                              },
                              onCardTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        ProductDescriptionPage(
                                      imageUrl: imageUrl,
                                      name: name,
                                      price: amount,
                                      description: description,
                                      uniqueID: uniqueID,
                                      isAvailable: isAvailable,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
      );
    });
  }
}
