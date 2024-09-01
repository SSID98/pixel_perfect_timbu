import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import 'custom_button.dart';

class ProductCard extends StatelessWidget {
  final String name;
  final String amount;
  final VoidCallback onPressed;
  final VoidCallback onCardPress;
  final String image = "http://api.timbu.cloud/images/";
  final String imageUrl;
  final VoidCallback onPress;

  const ProductCard({
    super.key,
    required this.name,
    required this.amount,
    required this.onPressed,
    required this.imageUrl,
    required this.onPress,
    required this.onCardPress,
  });

  String formatNumber(String numberString) {
    final number = double.parse(numberString);
    final formatter = NumberFormat('₦#,##0', 'en_NG');
    return formatter.format(number);
  }

  @override
  Widget build(BuildContext context) {
    String formattedAmount = formatNumber(amount);
    return InkWell(
      onTap: onCardPress,
      child: Container(
        padding: EdgeInsets.zero,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5.0),
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(0.0, 0.0),
              blurRadius: 1.0,
              spreadRadius: 0.1,
            ),
          ],
        ),
        margin: const EdgeInsets.only(left: 2, bottom: 15),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding:
                        const EdgeInsets.only(top: 0.0, left: 1.0, right: 1.0),
                    child: Image.network(image + imageUrl,
                        height: 200, width: double.infinity, fit: BoxFit.cover),
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10.0, 0, 10.0, 10.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Text(
                                name,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.poppins(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w400,
                                  color: const Color(0xff797A7B),
                                ),
                                maxLines: 3,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: FittedBox(
                                child: Text(formattedAmount,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xff363939),
                                    )),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 25,
                      ),
                      CustomButton(
                        onPress: onPressed,
                        colour: const Color(0xff408C2B),
                        label: 'Add to Cart',
                        width: 56,
                        height: 24,
                        borderRadius: 2.37,
                        padvertical: 6.31,
                        padhorizontal: 2,
                        borderWidth: 1.0,
                        fill: Colors.transparent,
                        style: GoogleFonts.poppins(
                            color: const Color(0xff408C2B),
                            fontSize: 7.1,
                            fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                )
              ],
            ),
            Positioned(
              top: 10,
              right: 10,
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
                      Icons.favorite_border,
                      size: 13,
                      weight: 2,
                      color: Colors.indigoAccent,
                    ),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    onPressed: onPress,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
