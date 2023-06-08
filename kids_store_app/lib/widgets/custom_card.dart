import 'package:flutter/material.dart';
import 'package:kids_store_app/models/allproducts_model.dart';
import 'package:kids_store_app/models/product_cart_model.dart';
import 'package:kids_store_app/pages/product_info.dart';
import 'package:kids_store_app/providers/add_to_cart_provider.dart';
import 'package:kids_store_app/providers/favorites_provder.dart';
import 'package:kids_store_app/utlis/constants.dart';
import 'package:provider/provider.dart';

class ProductCard extends StatefulWidget {
  final Product product;
  final List<Images>? images;
  const ProductCard({super.key, required this.product, required this.images});

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return GestureDetector(
      onDoubleTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => ProductInfo(
              product: widget.product,
              images: widget.images,
            ),
          ),
        );
      },
      child: Consumer<FavoritesProvider>(builder: (context, favorites, child) {
        return Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          child: Stack(
            children: [
              Positioned(
                bottom: 0,
                right: 0,
                left: 0,
                child: Consumer<CartModel>(builder: (context, cart, child) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                          onPressed: () {
                            if (cart.getProducts().indexWhere((element) =>
                                    element.product!.id == widget.product.id) ==
                                -1) {
                              cart.add(ProductCart(
                                  product: widget.product, quantity: 1));
                            }
                          },
                          icon: Icon(
                            cart.getProducts().indexWhere((element) =>
                                        element.product!.id ==
                                        widget.product.id) ==
                                    -1
                                ? Icons.shopping_cart_outlined
                                : Icons.shopping_cart,
                            color: Constants.primaryColor,
                          )),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 6),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              widget.product.price.toString(),
                              style: const TextStyle(
                                  color: Constants.primaryColor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              width: screenSize.width * 0.01,
                            ),
                            const Text(
                              "ريال سعودي",
                              style: TextStyle(fontSize: 12),
                            )
                          ],
                        ),
                      ),
                    ],
                  );
                }),
              ),
              Column(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(8),
                    ),
                    child: Stack(
                      children: [
                        Image.network(
                          "${Constants.storgeUrl}/${widget.images![0].path}",
                          fit: BoxFit.fill,
                          height: 150, // Adjust the height as needed
                          width: double.infinity,
                        ),
                        IconButton(
                            onPressed: () {
                              if (favorites.getProducts().indexWhere(
                                      (element) =>
                                          element.id == widget.product.id) ==
                                  -1) {
                                favorites.add(widget.product);
                              } else {
                                favorites.removeProduct(widget.product);
                              }
                            },
                            icon: Icon(
                              favorites.getProducts().indexWhere((element) =>
                                          element.id == widget.product.id) ==
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
                    child: Text(widget.product.name!),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: Text(
                        widget.product.description!,
                        style: const TextStyle(
                            fontSize: 12, fontWeight: FontWeight.normal),
                      ),
                    ),
                  ),

                  // SizedBox(
                  //   height: screenSize.height * 0.02,
                  // )
                ],
              ),
            ],
          ),
        );
      }),
    );
  }
}
