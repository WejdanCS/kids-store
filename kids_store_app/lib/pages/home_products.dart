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
import 'package:kids_store_app/providers/favorites_provder.dart';
import 'package:kids_store_app/providers/products_provider.dart';
import 'package:kids_store_app/providers/user_provider.dart';
import 'package:kids_store_app/utlis/constants.dart';
import 'package:kids_store_app/widgets/custom_card.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeProducts extends StatefulWidget {
  const HomeProducts({super.key});

  @override
  State<HomeProducts> createState() => _HomeProductsState();
}

class _HomeProductsState extends State<HomeProducts> {
  ScrollController? productsController = ScrollController();
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
        body: Padding(
      padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.02),
      child: SizedBox(
        height: screenSize.height,
        width: screenSize.width,
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
                      future: getAllCategories(
                          token:
                              Provider.of<UserProvider>(context, listen: false)
                                  .token!), // function where you call your api
                      builder: (BuildContext context,
                          AsyncSnapshot<CategoriesResponse> snapshot) {
                        // AsyncSnapshot<Your object type>
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(child: Text('جاري التحميل'));
                        } else {
                          if (snapshot.hasError) {
                            return Center(
                                child: Text('خطأ: ${snapshot.error}'));
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
                future: getAllProducts(
                    token: Provider.of<UserProvider>(context, listen: false)
                        .token!), // function where you call your api
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
                      return SingleChildScrollView(
                        child: Row(
                          children: [
                            SizedBox(
                              width: screenSize.width * 0.95,
                              height: screenSize.height * 0.63,
                              child: GridView.builder(
                                  controller: productsController,
                                  physics:
                                      const AlwaysScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: snapshot.data!.products!.length,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    childAspectRatio: 0.6,
                                  ),
                                  itemBuilder: (context, i) {
                                    return ProductCard(
                                        product: snapshot
                                            .data!.products![i].product!,
                                        images: snapshot
                                            .data!.products![i].images!);
                                  }),
                            ),
                          ],
                        ),
                      );
                    }
                  }
                },
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
