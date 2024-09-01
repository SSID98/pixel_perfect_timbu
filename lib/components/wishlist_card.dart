import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:pixel_perfect_timbu/components/custom_button.dart';

class WishListCard extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String image = "http://api.timbu.cloud/images/";
  final String amount;
  final VoidCallback onRemove;
  final VoidCallback onOrder;
  final VoidCallback onCardTap;

  const WishListCard({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.amount,
    required this.onRemove,
    required this.onOrder,
    required this.onCardTap,
  });

  String formatNumber(String numberString) {
    final number = double.parse(numberString);
    final formatter = NumberFormat('₦#,##0.00', 'en_NG'); //
    return formatter.format(number);
  }

  @override
  Widget build(BuildContext context) {
    String formattedAmount = formatNumber(amount);
    return InkWell(
      onTap: onCardTap,
      child: Container(
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
        margin: const EdgeInsets.all(10),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                width: 100,
                child: Image.network(image + imageUrl,
                    height: 100, width: double.infinity, fit: BoxFit.cover),
              ),
              const SizedBox(
                width: 10,
              ),
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
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xff0A0B0A),
                        ),
                        maxLines: 1,
                      ),
                    ),
                    const SizedBox(height: 15),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        formattedAmount,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff363939),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    )
                  ],
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Column(
                  children: [
                    CustomButton(
                      onPress: onOrder,
                      colour: const Color(0xff408C2B),
                      label: 'Buy Now',
                      width: 100,
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
                    const SizedBox(height: 20),
                    CustomButton(
                      onPress: onRemove,
                      colour: const Color(0xff408C2B),
                      label: 'Remove',
                      width: 100,
                      height: 37,
                      borderRadius: 6,
                      padvertical: 0,
                      padhorizontal: 0,
                      borderWidth: 1,
                      fill: Colors.transparent,
                      style: GoogleFonts.poppins(
                          color: const Color(0xff0A0B0A),
                          fontSize: 14,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
