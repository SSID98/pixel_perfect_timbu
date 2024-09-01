import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class OrderHistoryCard extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String image = "http://api.timbu.cloud/images/";
  final String amount;
  final VoidCallback onRemove;
  final VoidCallback onOrder;

  const OrderHistoryCard({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.amount,
    required this.onRemove,
    required this.onOrder,
  });

  String formatNumber(String numberString) {
    final number = double.parse(numberString);
    final formatter = NumberFormat('₦#,##0.00', 'en_NG'); //
    return formatter.format(number);
  }

  @override
  Widget build(BuildContext context) {
    String formattedAmount = formatNumber(amount);

    String currentDate = DateFormat('dd MMM, yyyy').format(DateTime.now());
    return Container(
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
                  const SizedBox(height: 5),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      'COMPLETED',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      currentDate,
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
