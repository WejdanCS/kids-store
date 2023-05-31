import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:kids_store_app/api/get_all_categories.dart';
import 'package:kids_store_app/api/get_all_products.dart';
import 'package:kids_store_app/models/allcategories_model.dart';
import 'package:kids_store_app/models/allproducts_model.dart';
import 'package:kids_store_app/models/product_cart_model.dart';
import 'package:kids_store_app/pages/product_info.dart';
import 'package:kids_store_app/providers/add_to_cart_provider.dart';
import 'package:kids_store_app/providers/products_provider.dart';
import 'package:kids_store_app/utlis/constants.dart';
import 'package:provider/provider.dart';

class HomeProducts extends StatefulWidget {
  const HomeProducts({super.key});

  @override
  State<HomeProducts> createState() => _HomeProductsState();
}

class _HomeProductsState extends State<HomeProducts> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
        body: Padding(
      padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.02),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: screenSize.height * 0.06,
            ),
            const Text(
              "الفئات",
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
                // color: Constants.secondaryColor,
                width: screenSize.width,
                height: screenSize.height * 0.1,
                child: FutureBuilder<CategoriesResponse>(
                    future:
                        getAllCategories(), // function where you call your api
                    builder: (BuildContext context,
                        AsyncSnapshot<CategoriesResponse> snapshot) {
                      // AsyncSnapshot<Your object type>
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: Text('جاري التحميل'));
                      } else {
                        if (snapshot.hasError) {
                          return Center(child: Text('خطأ: ${snapshot.error}'));
                        } else {
                          return ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: snapshot.data!.categories!.length,
                              shrinkWrap: true,
                              itemBuilder: (context, i) {
                                return Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: Chip(
                                      backgroundColor: i % 2 == 0
                                          ? Constants.thirdColor
                                              .withOpacity(0.7)
                                          : Constants.primaryColor
                                              .withOpacity(0.7),
                                      label: Text(
                                        "${snapshot.data!.categories![i].name}",
                                        style: TextStyle(
                                            color: i % 2 == 0
                                                ? Constants.secondaryColor
                                                    .withOpacity(0.8)
                                                : Colors.white,
                                            fontSize: 12),
                                      )),
                                );
                              });
                        }
                      }
                    })),
            SizedBox(
              height: screenSize.height * 0.02,
            ),
            const Text(
              "المنتجات الجديدة",
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: screenSize.height * 0.02,
            ),
            FutureBuilder<ProductsResponse>(
              future: getAllProducts(), // function where you call your api
              builder: (BuildContext context,
                  AsyncSnapshot<ProductsResponse> snapshot) {
                // AsyncSnapshot<Your object type>
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: Text('جاري التحميل'));
                } else {
                  if (snapshot.hasError) {
                    return Center(child: Text('خطأ: ${snapshot.error}'));
                  } else {
                    Provider.of<ProductsProvider>(context, listen: false)
                        .addProducts(snapshot.data!.products!);
                    return GridView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data!.products!.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.82,
                        ),
                        itemBuilder: (context, i) {
                          return ProductCard(
                              product: snapshot.data!.products![i].product!,
                              images: snapshot.data!.products![i].images!);
                        });
                  }
                }
              },
            )
          ],
        ),
      ),
    ));
  }
}

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
      child: Card(
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
                        "${Constants.storgeUrl}/${widget.images![0].path}",
                        fit: BoxFit.cover,
                        height: 100, // Adjust the height as needed
                        width: double.infinity,
                      ),
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.favorite_border,
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
                Consumer<CartModel>(builder: (context, cart, child) {
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

                            // }

                            // if(productIsInCart!=null){

                            // }else{

                            // }
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
                // SizedBox(
                //   height: screenSize.height * 0.02,
                // )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
