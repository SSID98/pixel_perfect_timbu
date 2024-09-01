import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:pixel_perfect_timbu/components/custom_button.dart';
import 'package:pixel_perfect_timbu/pages/product_description_page.dart';
import 'package:provider/provider.dart';

import '../components/checkout_card.dart';
import '../services/item_manager.dart';
import 'order_successful.dart';

class CheckoutPage extends StatelessWidget {
  static const String id = 'checkout_page';

  const CheckoutPage({
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
      double totalAmount = itemManager.items
          .fold(0, (sum, item) => sum + double.parse(item['amount'] ?? ''));
      String formattedTotalAmount = formatNumber(totalAmount.toString());

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
                Navigator.pop(context);
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
            'Cart',
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
        body: itemManager.items.isEmpty
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.shopping_cart_outlined,
                      size: 100,
                      color: Color(0xff408C2B),
                      weight: 4,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Your Cart is empty',
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
            : SingleChildScrollView(
                child: Column(
                  children: [
                    const Center(
                      child: Padding(
                        padding: EdgeInsets.only(
                            bottom: 10.0, right: 35.0, left: 35.0),
                        child: Divider(
                          height: 1,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 300.0,
                      child: ListView.builder(
                        itemCount: itemManager.items.length,
                        itemBuilder: (context, index) {
                          final item = itemManager.items[index];

                          // Check for null values before passing to ProductDescriptionPage
                          final imageUrl = item['imageUrl'] ?? '';
                          final name = item['name'] ?? '';
                          final amount = item['amount'] ?? '';
                          final description = item['description'] ?? '';
                          final uniqueID = item['uniqueID'] ?? '';
                          final isAvailable = item['isAvailable'] ?? '';
                          return Padding(
                            padding:
                                const EdgeInsets.only(right: 10.0, top: 8.0),
                            child: Column(
                              children: [
                                Center(
                                  child: CheckoutCard(
                                    imageUrl: imageUrl,
                                    name: name,
                                    amount: amount,
                                    onOrder: () {
                                      itemManager.orderItem(index);
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const OrderSuccessful(),
                                        ),
                                      );
                                    },
                                    onRemove: () {
                                      itemManager.removeItem(index);
                                    },
                                    onCardPress: () {
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
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 35.0, right: 35.0, bottom: 50.0),
                      child: Container(
                          height: 290,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.0),
                              border: const Border(
                                top: BorderSide(
                                    width: 1.0, color: Color(0xff408C2B)),
                                bottom: BorderSide(
                                    width: 1.0, color: Color(0xff408C2B)),
                                right: BorderSide(
                                    width: 1.0, color: Color(0xff408C2B)),
                                left: BorderSide(
                                    width: 1.0, color: Color(0xff408C2B)),
                              )),
                          child: Padding(
                            padding:
                                const EdgeInsets.fromLTRB(12.0, 0, 12.0, 0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Cart Summary',
                                  style: GoogleFonts.lora(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xff0A0B0A),
                                  ),
                                ),
                                const SizedBox(height: 25),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Sub-total',
                                      style: GoogleFonts.poppins(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: const Color(0xff6E6E6E),
                                      ),
                                    ),
                                    const SizedBox(width: 60.0),
                                    FittedBox(
                                      child: Text(formattedTotalAmount,
                                          style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            color: Color(0xff363939),
                                          )),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 20.0),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Delivery Fee',
                                        style: GoogleFonts.poppins(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color: const Color(0xff6E6E6E),
                                        ),
                                      ),
                                      const SizedBox(width: 50.0),
                                      FittedBox(
                                        child: Text('N2,000',
                                            style: GoogleFonts.poppins(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                              color: const Color(0xff6E6E6E),
                                            )),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 30.0),
                                const Divider(),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 8.0, right: 8.0),
                                  child: Container(
                                    color: Colors.transparent,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        CustomButton(
                                          onPress: () {},
                                          colour: const Color(0xff363939),
                                          label: 'Cancel',
                                          width: 63,
                                          height: 34,
                                          borderRadius: 4,
                                          padvertical: 8.0,
                                          padhorizontal: 0,
                                          borderWidth: 1,
                                          fill: Colors.transparent,
                                          style: GoogleFonts.inter(
                                              color: const Color(0xff363939),
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Total Amount',
                                              style: GoogleFonts.poppins(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                                color: const Color(0xff797A7B),
                                              ),
                                            ),
                                            const SizedBox(height: 5.0),
                                            FittedBox(
                                              child: Text(
                                                formattedTotalAmount,
                                                style: const TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w600,
                                                  color: Color(0xff363939),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        CustomButton(
                                          onPress: () {
                                            itemManager.completeOrder();
                                            Navigator.of(context)
                                                .pushNamed(OrderSuccessful.id);
                                          },
                                          colour: const Color(0xff408C2B),
                                          label: 'Checkout',
                                          width: 110,
                                          height: 37,
                                          borderRadius: 6,
                                          padvertical: 0,
                                          padhorizontal: 0,
                                          borderWidth: 0,
                                          fill: const Color(0xff408C2B),
                                          style: GoogleFonts.poppins(
                                              color: const Color(0xffFAFAFA),
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )),
                    )
                  ],
                ),
              ),
      );
    });
  }
}
