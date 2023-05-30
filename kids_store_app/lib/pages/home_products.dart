import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:kids_store_app/api/get_all_products.dart';
import 'package:kids_store_app/models/allproducts_model.dart';
import 'package:kids_store_app/utlis/constants.dart';

class HomeProducts extends StatefulWidget {
  const HomeProducts({super.key});

  @override
  State<HomeProducts> createState() => _HomeProductsState();
}

class _HomeProductsState extends State<HomeProducts> {
  var categories = [
    "ملابس",
    "ملابس صيفية",
    "ملابس شتوية",
    "ملابس ولادي",
    "ملابس بناتي"
  ];
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
        body: Padding(
      padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.02),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: screenSize.height * 0.06,
          ),
          Text(
            "الفئات",
            style: TextStyle(fontSize: 20),
          ),
          Container(
            // color: Constants.secondaryColor,
            width: screenSize.width,
            height: screenSize.height * 0.1,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                shrinkWrap: true,
                itemBuilder: (context, i) {
                  return Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Chip(label: Text("${categories[i]}")),
                  );
                }),
          ),
          SizedBox(
            height: screenSize.height * 0.02,
          ),
          Text(
            "المنتجات الجديدة",
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(
            height: screenSize.height * 0.02,
          ),
          // Expanded(
          //     child: GridView.count(
          //         crossAxisCount: 4,
          //         children: List<Widget>.generate(16, (index) {
          //           return GridTile(
          //               child: Card(
          //                   color: Colors.blue.shade200,
          //                   child: Center(
          //                     child: Text('tile $index'),
          //                   )));
          //         }))
          //     ),
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
                  return Expanded(
                      child: GridView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.data!.products!.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 1,
                            crossAxisSpacing: 3,
                            mainAxisSpacing: 3,
                          ),
                          itemBuilder: (context, i) {
                            return GridTile(
                                child: Card(
                                    color: Colors.grey.shade100,
                                    child: SingleChildScrollView(
                                      child: Column(
                                        children: [
                                          // Image.network(
                                          //     "${Constants.storgeUrl}/${snapshot.data!.products![i].images![0].path}"),
                                          Container(
                                            width: screenSize.width,
                                            height: screenSize.height * 0.35,
                                            child: Card(
                                              semanticContainer: true,
                                              clipBehavior:
                                                  Clip.antiAliasWithSaveLayer,
                                              child: Image.network(
                                                "${Constants.storgeUrl}/${snapshot.data!.products![i].images![0].path}",
                                                fit: BoxFit.fill,
                                              ),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                              ),
                                              elevation: 5,
                                              margin: EdgeInsets.all(10),
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Text(snapshot.data!.products![i]
                                                  .product!.name!),
                                              Row(
                                                children: [
                                                  Text(
                                                    snapshot.data!.products![i]
                                                        .product!.price
                                                        .toString(),
                                                    style: TextStyle(
                                                        color: Constants
                                                            .primaryColor,
                                                        fontSize: 22,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Text("ريال سعودي")
                                                ],
                                              ),
                                            ],
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Align(
                                              alignment: Alignment.topRight,
                                              child: Text(snapshot
                                                  .data!
                                                  .products![i]
                                                  .product!
                                                  .description!),
                                            ),
                                          ),

                                          ElevatedButton(
                                              onPressed: () {},
                                              child: Text(
                                                "شراء",
                                                style: TextStyle(
                                                    color: Colors.white),
                                              )),
                                          SizedBox(
                                            height: screenSize.height * 0.02,
                                          ),
                                        ],
                                      ),
                                    )));
                          }));
                }
              }
            },
          )
        ],
      ),
    ));
  }
}
