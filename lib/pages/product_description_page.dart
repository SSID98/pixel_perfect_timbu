import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:pixel_perfect_timbu/components/item_counter.dart';
import 'package:provider/provider.dart';

import '../components/custom_button.dart';
import '../services/item_manager.dart';
import 'checkout_page.dart';

class ProductDescriptionPage extends StatefulWidget {
  static const String id = 'product_description_page';
  final String name;
  final String price;
  final String imageUrl;
  final String description;
  final String uniqueID;
  final String isAvailable;
  final String image = "http://api.timbu.cloud/images/";

  const ProductDescriptionPage(
      {super.key,
      required this.name,
      required this.price,
      required this.imageUrl,
      required this.description,
      required this.uniqueID,
      required this.isAvailable});

  @override
  State<ProductDescriptionPage> createState() => _ProductDescriptionPageState();
}

class _ProductDescriptionPageState extends State<ProductDescriptionPage> {
  bool showCounterContainer = false;

  String formatNumber(String numberString) {
    final number = double.parse(numberString);
    final formatter = NumberFormat('₦#,##0', 'en_NG');
    return formatter.format(number);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ItemManager>(builder: (context, itemManager, child) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xffE4F5E0),
          toolbarHeight: 80.0,
          titleSpacing: 6.0,
          leading: Padding(
            padding: const EdgeInsets.only(
              left: 24.0,
            ),
            child: Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 4,
                    spreadRadius: 2,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Align(
                alignment: Alignment.center,
                child: IconButton(
                  icon: const Icon(
                    Icons.arrow_back_sharp,
                    size: 16,
                    weight: 1.09,
                    color: Color(0xff1F2223),
                  ),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ),
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
        backgroundColor: const Color(0xffE4F5E0),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 50),
            child: Column(
              children: [
                Image.network(
                  widget.image + widget.imageUrl,
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(35.0, 5.0, 35.0, 10),
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 40.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: [
                            Text(
                              'Deals',
                              style: GoogleFonts.poppins(
                                fontSize: 16.0,
                                fontWeight: FontWeight.w300,
                                color: const Color(0xff6E6E6E),
                              ),
                              textAlign: TextAlign.left,
                            ),
                            const Spacer(),
                            Text(
                              widget.isAvailable,
                              style: GoogleFonts.poppins(
                                fontSize: 14.0,
                                fontWeight: FontWeight.w400,
                                color: const Color(0xff408C2B),
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        Text(
                          widget.name,
                          style: GoogleFonts.poppins(
                            fontSize: 24.0,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xff0A0B0A),
                          ),
                          textAlign: TextAlign.left,
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        Text(
                          widget.description,
                          style: GoogleFonts.poppins(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xff5A5A5A),
                          ),
                          textAlign: TextAlign.left,
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        Row(
                          children: [
                            Text(
                              'How to Use',
                              style: GoogleFonts.poppins(
                                fontSize: 16.0,
                                fontWeight: FontWeight.w400,
                                color: const Color(0xff343434),
                              ),
                              textAlign: TextAlign.left,
                            ),
                            const Spacer(),
                            const Icon(
                              Icons.arrow_drop_down,
                              color: Color(0xff433F3E),
                            ),
                          ],
                        ),
                        const Divider(),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Row(
                          children: [
                            Text(
                              'Delivery and drop-off',
                              style: GoogleFonts.poppins(
                                fontSize: 16.0,
                                fontWeight: FontWeight.w400,
                                color: const Color(0xff343434),
                              ),
                              textAlign: TextAlign.left,
                            ),
                            const Spacer(),
                            const Icon(
                              Icons.arrow_drop_down,
                              color: Color(0xff433F3E),
                            ),
                          ],
                        ),
                        const Divider(),
                      ],
                    ),
                  ),
                ),
                showCounterContainer
                    ? _buildCounterContainer()
                    : _buildAddToCartContainer(),
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget _buildAddToCartContainer() {
    String formattedAmount = formatNumber(widget.price);
    return Container(
      color: const Color(0xff408C2B),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(35.0, 12.0, 30.0, 32),
        child: Row(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Sub',
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xffFAFAFA),
                  ),
                ),
                Text(
                  formattedAmount,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Color(0xffFAFAFA),
                  ),
                ),
              ],
            ),
            const Spacer(),
            CustomButton(
              onPress: () {
                setState(() {
                  showCounterContainer = true;
                });
              },
              colour: const Color(0xffFAFAFA),
              label: 'Add to Cart',
              width: 150,
              height: 40,
              borderRadius: 3.82,
              padvertical: 10.18,
              padhorizontal: 0,
              borderWidth: 2,
              fill: Colors.transparent,
              style: GoogleFonts.poppins(
                fontSize: 11.45,
                fontWeight: FontWeight.w400,
                color: const Color(0xffFAFAFA),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCounterContainer() {
    String formattedAmount = formatNumber(widget.price);
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 34.0),
            child: const ItemCounter(
              height: 36,
              width: 134,
              radius: 6.0,
            ),
          ),
          const SizedBox(
            height: 15.0,
          ),
          Container(
            color: const Color(0xffE4F5E0),
            padding: const EdgeInsets.fromLTRB(35.0, 12.0, 30.0, 2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                CustomButton(
                  onPress: () {
                    setState(() {
                      showCounterContainer = false;
                    });
                  },
                  colour: const Color(0xff363939),
                  label: 'Cancel',
                  width: 63,
                  height: 48,
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Unit price',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xff797A7B),
                      ),
                    ),
                    Text(
                      formattedAmount,
                      style: GoogleFonts.inter(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xff363939),
                      ),
                    ),
                  ],
                ),
                CustomButton(
                  onPress: () {
                    // Navigate to checkout page (dummy for now)
                  },
                  colour: const Color(0xff408C2B),
                  label: 'Checkout',
                  width: 115,
                  height: 48,
                  borderRadius: 6,
                  padvertical: 10.18,
                  padhorizontal: 0,
                  borderWidth: 2,
                  fill: const Color(0xff408C2B),
                  style: GoogleFonts.poppins(
                      color: const Color(0xffFAFAFA),
                      fontSize: 18,
                      fontWeight: FontWeight.w400),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
