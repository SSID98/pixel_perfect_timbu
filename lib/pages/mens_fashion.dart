import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pixel_perfect_timbu/pages/product_description_page.dart';
import 'package:provider/provider.dart';

import '../components/product_card.dart';
import '../model/products.dart';
import '../services/item_manager.dart';
import 'checkout_page.dart';

class MensFashionPage extends StatefulWidget {
  static const String id = 'mens_fashion_page';

  const MensFashionPage({
    super.key,
  });

  @override
  State<MensFashionPage> createState() => _MensFashionPageState();
}

class _MensFashionPageState extends State<MensFashionPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ItemManager>(
      builder: (context, itemManager, child) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 32.0, 20.0, 28),
              child: Text(
                'Men\'s fashion',
                style: GoogleFonts.redressed(
                    fontWeight: FontWeight.w400,
                    fontSize: 24.0,
                    color: Colors.green),
              ),
            ),
            actions: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 13.0, 24.0, 20.0),
                child: IconButton(
                  icon: const Icon(Icons.shopping_cart_outlined),
                  onPressed: () {
                    Navigator.of(context).pushNamed(CheckoutPage.id);
                  },
                ),
              ),
            ],
          ),
          body: FutureBuilder(
            future: Future.wait(
                [itemManager.getFilteredProductData('men\'s fashion')]),
            builder: (context, AsyncSnapshot<List<List<Product>>> snapshot) {
              if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData ||
                  snapshot.data!.any((list) => list.isEmpty)) {
                return const Center(child: Text('No products found.'));
              }

              List<Product> gridViewProducts = snapshot.data![0];
              int gridViewItemCount =
                  gridViewProducts.length; // Adjust this as needed

              return Padding(
                padding: const EdgeInsets.fromLTRB(15.0, 30.0, 15.0, 28),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Featured',
                          style: GoogleFonts.lora(
                              fontSize: 18.0,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xff363939)),
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: gridViewItemCount,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 6 / 8,
                            crossAxisSpacing: 0,
                            mainAxisSpacing: 0,
                          ),
                          itemBuilder: (ctx, i) => Center(
                            child: Padding(
                              padding: const EdgeInsets.only(right: 10.0),
                              child: ProductCard(
                                imageUrl: gridViewProducts[i].imageUrl,
                                name: gridViewProducts[i].name,
                                amount: gridViewProducts[i].price,
                                onPressed: () {
                                  itemManager.addItem(
                                      gridViewProducts[i].imageUrl,
                                      gridViewProducts[i].name,
                                      gridViewProducts[i].price,
                                      gridViewProducts[i].uniqueID,
                                      gridViewProducts[i].description,
                                      gridViewProducts[i].isAvaliable);
                                  setState(() {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                            'Product added to cart successfully!'),
                                        backgroundColor: Colors.green,
                                      ),
                                    );
                                  });
                                },
                                onPress: () {
                                  itemManager.saveItem(
                                      gridViewProducts[i].imageUrl,
                                      gridViewProducts[i].name,
                                      gridViewProducts[i].price,
                                      gridViewProducts[i].description,
                                      gridViewProducts[i].uniqueID,
                                      gridViewProducts[i].isAvaliable);
                                  setState(() {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                            'Product saved to wishlist successfully!'),
                                        backgroundColor: Colors.green,
                                      ),
                                    );
                                  });
                                },
                                onCardPress: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          ProductDescriptionPage(
                                              name: gridViewProducts[i].name,
                                              price: gridViewProducts[i].price,
                                              imageUrl:
                                                  gridViewProducts[i].imageUrl,
                                              description: gridViewProducts[i]
                                                  .description,
                                              uniqueID:
                                                  gridViewProducts[i].uniqueID,
                                              isAvailable: gridViewProducts[i]
                                                  .isAvaliable),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
