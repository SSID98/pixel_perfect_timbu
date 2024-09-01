import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ItemCounter extends StatefulWidget {
  final double height;
  final double width;
  final double radius;

  const ItemCounter(
      {super.key,
      required this.height,
      required this.width,
      required this.radius});

  @override
  State<ItemCounter> createState() => _ItemCounterState();
}

class _ItemCounterState extends State<ItemCounter> {
  int itemCount = 1;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      width: widget.width,
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color(0xffEAEAEA),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(widget.radius),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: IconButton(
              onPressed: () {
                setState(() {
                  if (itemCount > 1) {
                    itemCount--;
                  }
                });
              },
              icon: const Icon(Icons.remove),
              color: itemCount == 1
                  ? const Color(0xffAFE2A1)
                  : const Color(0xff408C2B),
              padding: EdgeInsets.zero,
              iconSize: 20,
            ),
          ),
          Container(
            height: double.infinity,
            width: 1,
            color: const Color(0xffEAEAEA),
            padding: EdgeInsets.zero,
          ),
          Expanded(
            child: Text(
              '$itemCount',
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: const Color(0xff363939),
              ),
            ),
          ),
          Container(
            height: double.infinity,
            width: 1,
            color: const Color(0xffEAEAEA),
            padding: EdgeInsets.zero,
          ),
          Expanded(
            child: IconButton(
              onPressed: () {
                setState(() {
                  itemCount++;
                });
              },
              icon: const Icon(Icons.add),
              color: const Color(0xff408C2B),
              padding: EdgeInsets.zero,
              iconSize: 20,
            ),
          ),
        ],
      ),
    );
  }
}
