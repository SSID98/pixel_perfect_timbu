import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CollectionsCard extends StatelessWidget {
  final String name;
  final VoidCallback onPressed;
  final String imageUrl;

  const CollectionsCard({
    super.key,
    required this.name,
    required this.onPressed,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
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
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding:
                      const EdgeInsets.only(top: 1.0, left: 1.0, right: 1.0),
                  child: Image.network(
                    imageUrl,
                    height: double.infinity,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (BuildContext context, Object exception,
                        StackTrace? stackTrace) {
                      return const Center(
                        child: Icon(
                          Icons.broken_image,
                          color: Colors.grey,
                          size: 50.0,
                        ),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Center(
                child: Text(
                  name,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xff0A0B0A),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
