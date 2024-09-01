import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pixel_perfect_timbu/components/collections_card.dart';
import 'package:pixel_perfect_timbu/pages/computing_page.dart';
import 'package:pixel_perfect_timbu/pages/gaming_page.dart';
import 'package:pixel_perfect_timbu/pages/mens_fashion.dart';
import 'package:pixel_perfect_timbu/pages/phone_accessories_page.dart';
import 'package:pixel_perfect_timbu/pages/product_description_page.dart';
import 'package:provider/provider.dart';

import '../components/product_card.dart';
import '../model/products.dart';
import '../services/item_manager.dart';
import 'checkout_page.dart';

class ProductsPage extends StatefulWidget {
  static const String id = 'products_page';

  const ProductsPage({
    super.key,
  });

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
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
                'Timbu Shop',
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
                [itemManager.getProductData(1), itemManager.getProductData(2)]),
            builder: (context, AsyncSnapshot<List<List<Product>>> snapshot) {
              if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData ||
                  snapshot.data!.any((list) => list.isEmpty)) {
                return const Center(child: Text('No products found.'));
              }

              List<Product> listViewProducts = snapshot.data![0];
              List<Product> gridViewProducts = snapshot.data![1];

              int listViewItemCount = 4; // Adjust this as needed
              int gridViewItemCount = 6; // Adjust this as needed

              return Padding(
                padding: const EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 28),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Welcome, Name',
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xff0A0B0A),
                          ),
                        ),
                        const SizedBox(height: 16.0),
                        TextField(
                          decoration: InputDecoration(
                            hintText: 'Search',
                            hintStyle: GoogleFonts.inter(
                              fontWeight: FontWeight.w400,
                              fontSize: 16.0,
                              color: const Color(0xffB1B2B2),
                            ),
                            prefixIcon: const Icon(
                              Icons.search_rounded,
                              color: Color(0xffB1B2B2),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16.0),
                        Text(
                          'Just for you',
                          style: GoogleFonts.lora(
                              fontSize: 18.0,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xff363939)),
                        ),
                        const SizedBox(height: 16.0),
                        SizedBox(
                          height: 270.0,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: listViewItemCount,
                            itemBuilder: (ctx, i) {
                              return SizedBox(
                                width: 180,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      right: 10.0, top: 8.0),
                                  child: Center(
                                    child: ProductCard(
                                      imageUrl: listViewProducts[i].imageUrl,
                                      name: listViewProducts[i].name,
                                      amount: listViewProducts[i].price,
                                      onPressed: () {
                                        itemManager.addItem(
                                            listViewProducts[i].imageUrl,
                                            listViewProducts[i].name,
                                            listViewProducts[i].price,
                                            listViewProducts[i].description,
                                            listViewProducts[i].uniqueID,
                                            listViewProducts[i].isAvaliable);
                                        setState(() {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
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
                                            listViewProducts[i].imageUrl,
                                            listViewProducts[i].name,
                                            listViewProducts[i].price,
                                            listViewProducts[i].description,
                                            listViewProducts[i].uniqueID,
                                            listViewProducts[i].isAvaliable);
                                        setState(() {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
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
                                                    name: listViewProducts[i]
                                                        .name,
                                                    price: listViewProducts[i]
                                                        .price,
                                                    imageUrl:
                                                        listViewProducts[i]
                                                            .imageUrl,
                                                    description:
                                                        listViewProducts[i]
                                                            .description,
                                                    uniqueID:
                                                        listViewProducts[i]
                                                            .uniqueID,
                                                    isAvailable:
                                                        listViewProducts[i]
                                                            .isAvaliable),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 16.0),
                        Row(
                          children: [
                            Text(
                              'Deals',
                              style: GoogleFonts.lora(
                                fontSize: 18.0,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xff363939),
                              ),
                              textAlign: TextAlign.left,
                            ),
                            const Spacer(),
                            Text(
                              'View all',
                              style: GoogleFonts.inter(
                                fontSize: 14.0,
                                fontWeight: FontWeight.w500,
                                color: const Color(0xff797A7B),
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ],
                        ),
                        const Divider(),
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
                                      gridViewProducts[i].description,
                                      gridViewProducts[i].uniqueID,
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
                        Text(
                          'Our Collections',
                          style: GoogleFonts.poppins(
                            letterSpacing: 5.2,
                            fontSize: 16.0,
                            fontWeight: FontWeight.w300,
                            color: const Color(0xff0A0B0A),
                          ),
                          textAlign: TextAlign.left,
                        ),
                        const Divider(),
                        const SizedBox(
                          height: 20.0,
                        ),
                        GridView.count(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          crossAxisCount: 2,
                          childAspectRatio: 6 / 8,
                          crossAxisSpacing: 0,
                          mainAxisSpacing: 0,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(right: 10.0),
                              child: CollectionsCard(
                                  name: 'Phones & Accessories',
                                  onPressed: () {
                                    Navigator.of(context)
                                        .pushNamed(PhoneAccessoriesPage.id);
                                  },
                                  imageUrl:
                                      'https://i.pinimg.com/originals/58/61/3e/58613ea92fab875a49fec23e7538b0a6.png'),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 10.0),
                              child: CollectionsCard(
                                  name: 'Men\'s Fashion',
                                  onPressed: () {
                                    Navigator.of(context)
                                        .pushNamed(MensFashionPage.id);
                                  },
                                  imageUrl:
                                      'https://nextluxury.com/wp-content/uploads/Top-15-Fashion-Accessories-For-Men-1.jpg'),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 10.0),
                              child: CollectionsCard(
                                  name: 'Gaming',
                                  onPressed: () {
                                    Navigator.of(context)
                                        .pushNamed(GamingPage.id);
                                  },
                                  imageUrl:
                                      'https://img.freepik.com/premium-photo/essential-gaming-accessories-isolated-white-background_506134-20339.jpg'),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 10.0),
                              child: CollectionsCard(
                                  name: 'Computing',
                                  onPressed: () {
                                    Navigator.of(context)
                                        .pushNamed(ComputingPage.id);
                                  },
                                  imageUrl:
                                      'https://blog.aqiservice.com/wp-content/uploads/2017/02/Computer-accessories-from-China-and-quality-control-services.png'),
                            ),
                          ],
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
