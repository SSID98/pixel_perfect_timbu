import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import 'item_counter.dart';

class CheckoutCard extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String amount;
  final VoidCallback onRemove;
  final String image = "http://api.timbu.cloud/images/";
  final VoidCallback onOrder;
  final VoidCallback onCardPress;

  const CheckoutCard({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.amount,
    required this.onRemove,
    required this.onOrder,
    required this.onCardPress,
  });

  String formatNumber(String numberString) {
    final number = double.parse(numberString);
    final formatter = NumberFormat('N#,##0.00', 'en_NG'); //
    return formatter.format(number);
  }

  @override
  Widget build(BuildContext context) {
    String formattedAmount = formatNumber(amount);
    return Padding(
      padding: const EdgeInsets.fromLTRB(35.0, 0, 35.0, 28),
      child: InkWell(
        onTap: onCardPress,
        child: Container(
          color: Colors.transparent,
          child: Stack(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 15.0),
                      child: Image.network(image + imageUrl,
                          height: 100,
                          width: double.infinity,
                          fit: BoxFit.cover),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 28.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'RS34670',
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              fontWeight: FontWeight.w300,
                              color: const Color(0xff6E6E6E),
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            name,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xff0A0B0A),
                            ),
                            maxLines: 1,
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 40.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Unit price',
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: const Color(0xff5A5A5A),
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            formattedAmount,
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xff363939),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Positioned(
                left: 118,
                bottom: 8,
                child: Row(
                  children: [
                    const ItemCounter(
                      height: 24.31,
                      width: 66.52,
                      radius: 1.83,
                    ),
                    const SizedBox(
                      width: 6,
                    ),
                    Container(
                      height: 22.96,
                      width: 30.73,
                      color: const Color(0xffCC474E),
                      child: IconButton(
                        color: const Color(0xffFFFFFF),
                        onPressed: onRemove,
                        icon: const Icon(
                          Icons.delete_outline_sharp,
                          size: 15,
                        ),
                        padding: EdgeInsets.zero,
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
