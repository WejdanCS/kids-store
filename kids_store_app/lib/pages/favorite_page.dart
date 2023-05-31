import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:kids_store_app/models/allproducts_model.dart';
import 'package:kids_store_app/models/product_cart_model.dart';
import 'package:kids_store_app/providers/add_to_cart_provider.dart';
import 'package:kids_store_app/providers/favorites_provder.dart';
import 'package:kids_store_app/utlis/constants.dart';
import 'package:provider/provider.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<FavoritesProvider>(
        builder: (context, favorites, child) {
          return favorites.getProducts().isEmpty
              ? Center(child: Text("لاتوجد مفضلات "))
              : Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Text("المنتجات المفضلة"),
                    SizedBox(
                      height: 20,
                    ),
                    GridView.builder(
                        shrinkWrap: true,
                        itemCount: favorites.getProducts().length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.82,
                        ),
                        itemBuilder: (context, i) {
                          Product product = favorites.getProducts()[i];
                          return Card(
                            elevation: 4,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: ListView(
                              shrinkWrap: true,
                              children: [
                                Column(
                                  children: [
                                    ClipRRect(
                                      borderRadius: const BorderRadius.vertical(
                                        top: Radius.circular(8),
                                      ),
                                      child: Stack(
                                        children: [
                                          Image.network(
                                            "${Constants.storgeUrl}/${product.images![0].path}",
                                            fit: BoxFit.cover,
                                            height:
                                                100, // Adjust the height as needed
                                            width: double.infinity,
                                          ),
                                          IconButton(
                                              onPressed: () {
                                                favorites
                                                    .removeProduct(product);
                                              },
                                              icon: Icon(
                                                favorites
                                                            .getProducts()
                                                            .indexWhere(
                                                                (element) =>
                                                                    element
                                                                        .id ==
                                                                    product
                                                                        .id) ==
                                                        -1
                                                    ? Icons.favorite_border
                                                    : Icons.favorite,
                                                color: Constants.secondaryColor,
                                              )),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(product.name!),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Align(
                                        alignment: Alignment.topRight,
                                        child: Text(
                                          product.description!,
                                          style: const TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.normal),
                                        ),
                                      ),
                                    ),
                                    Consumer<CartModel>(
                                        builder: (context, cart, child) {
                                      return Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          IconButton(
                                              onPressed: () {
                                                if (cart
                                                        .getProducts()
                                                        .indexWhere((element) =>
                                                            element
                                                                .product!.id ==
                                                            product.id) ==
                                                    -1) {
                                                  cart.add(ProductCart(
                                                      product: product,
                                                      quantity: 1));
                                                }
                                              },
                                              icon: Icon(
                                                cart.getProducts().indexWhere(
                                                            (element) =>
                                                                element.product!
                                                                    .id ==
                                                                product.id) ==
                                                        -1
                                                    ? Icons
                                                        .shopping_cart_outlined
                                                    : Icons.shopping_cart,
                                                color: Constants.primaryColor,
                                              )),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 6),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  product.price.toString(),
                                                  style: const TextStyle(
                                                      color: Constants
                                                          .primaryColor,
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                // SizedBox(
                                                //   width: screenSize.width * 0.01,
                                                // ),
                                                const Text(
                                                  "ريال سعودي",
                                                  style:
                                                      TextStyle(fontSize: 12),
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      );
                                    }),
                                    // SizedBox(
                                    //   height: screenSize.height * 0.02,
                                    // )
                                  ],
                                ),
                              ],
                            ),
                          );
                        }),
                  ],
                );
        },
      ),
    );
  }
}
