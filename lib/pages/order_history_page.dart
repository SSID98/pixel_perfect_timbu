import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../components/custom_button.dart';
import '../components/order_history_card.dart';
import '../services/item_manager.dart';
import 'checkout_page.dart';

class OrderHistoryPage extends StatelessWidget {
  static const String id = 'order_history_page';

  const OrderHistoryPage({
    super.key,
  });

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
            'My Order History',
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
        body: itemManager.orderHistory.isEmpty
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.history_sharp,
                      size: 100,
                      color: Color(0xff408C2B),
                      weight: 4,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'No Orders Yet',
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
                        Navigator.pop(context);
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
                padding:
                    const EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0),
                child: ListView.builder(
                  itemCount: itemManager.orderHistory.length,
                  itemBuilder: (context, index) {
                    final item = itemManager.orderHistory[index];
                    return OrderHistoryCard(
                      imageUrl: item['imageUrl']!,
                      name: item['name']!,
                      amount: item['amount']!,
                      onOrder: () {},
                      // No action needed
                      onRemove: () {}, // No action needed
                    );
                  },
                ),
              ),
      );
    });
  }
}
