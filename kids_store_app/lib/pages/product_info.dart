import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:kids_store_app/models/allproducts_model.dart';
import 'package:kids_store_app/utlis/constants.dart';
import 'package:kids_store_app/widgets/custom_appbar.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ProductInfo extends StatefulWidget {
  final Product product;
  final List<Images>? images;
  const ProductInfo({super.key, required this.product, required this.images});

  @override
  State<ProductInfo> createState() => _ProductInfoState();
}

class _ProductInfoState extends State<ProductInfo> {
  CarouselController controller = CarouselController();
  int _currentIndex = 0;
  int qty = 1;

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return CustomAppBar(
      child: SizedBox(
        width: screenSize.width,
        height: screenSize.height,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.04),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: screenSize.height * 0.08,
              ),
              Stack(
                // mainAxisAlignment: MainAxisAlignment.center,
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CarouselSlider(
                    carouselController: controller,
                    items: widget.images!.map((image) {
                      return Align(
                        alignment: Alignment.center,
                        child: Container(
                            width: MediaQuery.of(context).size.width,
                            margin: const EdgeInsets.symmetric(horizontal: 5.0),
                            decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                // color: Colors.amberAccent,
                                borderRadius: BorderRadius.circular(8)),
                            child: Image.network(
                                "${Constants.storgeUrl}/${image.path}")),
                      );
                    }).toList(),
                    options: CarouselOptions(
                      height: 300,
                      onPageChanged: (val, _) {
                        setState(() {
                          print("new index $val");
                          controller.jumpToPage(val);
                          setState(() {
                            _currentIndex = val;
                          });
                        });
                      },

                      aspectRatio: 16 / 9,
                      viewportFraction: 0.8,
                      initialPage: 0,
                      enableInfiniteScroll: true,
                      reverse: false,
                      autoPlay: true,
                      autoPlayInterval: Duration(seconds: 3),
                      autoPlayAnimationDuration: Duration(milliseconds: 800),
                      autoPlayCurve: Curves.fastOutSlowIn,
                      enlargeCenterPage: true,
                      enlargeFactor: 0.3,
                      // onPageChanged: callbackFunction,
                      scrollDirection: Axis.horizontal,
                    ),
                  ),
                  Positioned(
                    bottom: 0.4,
                    child: Container(
                      height: screenSize.height * 0.08,
                      width: screenSize.width,
                      child: Center(
                        child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: widget.images!.length,
                            itemBuilder: (context, i) {
                              return Padding(
                                padding: EdgeInsets.symmetric(horizontal: 2),
                                child: InkWell(
                                  onTap: () {
                                    controller.nextPage(
                                        duration:
                                            const Duration(milliseconds: 300),
                                        curve: Curves.linear);
                                    setState(() {
                                      _currentIndex = i;
                                    });
                                  },
                                  child: Container(
                                    height: 10,
                                    width: 10,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: _currentIndex == i
                                          ? Constants.primaryColor
                                          : Colors.grey,
                                    ),
                                  ),
                                ),
                              );
                            }),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: screenSize.height * 0.02,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(widget.product.name!),
                  Text(
                    "${widget.product.price!}",
                    style: TextStyle(
                        color: Constants.primaryColor,
                        fontSize: 22,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
              Text(widget.product.description!),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("الكمية:"),
                  SizedBox(
                    width: screenSize.width * 0.04,
                  ),
                  Text(
                    "${widget.product.quantity}",
                    style: TextStyle(
                        color: Constants.secondaryColor, fontSize: 18),
                  )
                ],
              ),
              Text("الفئات"),
              Container(
                width: screenSize.width,
                height: screenSize.height * 0.06,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: widget.product.categories!.length,
                    shrinkWrap: true,
                    itemBuilder: (context, i) {
                      return Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Chip(
                            backgroundColor: i % 2 == 0
                                ? Constants.thirdColor.withOpacity(0.7)
                                : Constants.primaryColor.withOpacity(0.7),
                            label: Text(
                              "${widget.product.categories![i].name}",
                              style: TextStyle(
                                  color: i % 2 == 0
                                      ? Constants.secondaryColor
                                          .withOpacity(0.8)
                                      : Colors.white,
                                  fontSize: 12),
                            )),
                      );
                    }),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.favorite_border,
                        color: Constants.primaryColor,
                      )),
                  Container(
                    height: screenSize.height * 0.07,
                    decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(8)),
                    child: Row(children: [
                      IconButton(
                          onPressed: () {
                            if (qty < widget.product.quantity!) {
                              setState(() {
                                qty = qty + 1;
                              });
                            } else {
                              Fluttertoast.showToast(
                                  msg: "الكمية غير متوفرة",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Constants.primaryColor,
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                            }
                          },
                          icon: Icon(Icons.add)),
                      Text("$qty"),
                      IconButton(
                          onPressed: () {
                            if (qty > 1) {
                              setState(() {
                                qty = qty - 1;
                              });
                            }
                          },
                          icon: Icon(Icons.remove)),
                    ]),
                  ),
                  ElevatedButton(
                      onPressed: () {},
                      child: Text(
                        "اضف للسلة",
                        style: TextStyle(color: Colors.white),
                      ))
                ],
              ),
            ],
          ),
        ),
      ),
    );
    // Scaffold(
    //   body: SafeArea(
    //     child: SizedBox(
    //       width: screenSize.width,
    //       height: screenSize.height,
    //       child: Padding(
    //         padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.04),
    //         child: Column(
    //           mainAxisAlignment: MainAxisAlignment.start,
    //           crossAxisAlignment: CrossAxisAlignment.start,
    //           children: [
    //             SizedBox(
    //               height: screenSize.height * 0.02,
    //             ),
    //             Row(
    //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //               children: [
    //                 Text(widget.product.name!),
    //                 Text(
    //                   "${widget.product.price!}",
    //                   style: TextStyle(
    //                       color: Constants.primaryColor,
    //                       fontSize: 22,
    //                       fontWeight: FontWeight.bold),
    //                 )
    //               ],
    //             ),
    //             Text(widget.product.description!),
    //             Row(
    //               mainAxisAlignment: MainAxisAlignment.start,
    //               children: [
    //                 Text("الكمية:"),
    //                 SizedBox(
    //                   width: screenSize.width * 0.04,
    //                 ),
    //                 Text(
    //                   "${widget.product.quantity}",
    //                   style: TextStyle(
    //                       color: Constants.secondaryColor, fontSize: 18),
    //                 )
    //               ],
    //             ),
    //             Row(
    //               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //               children: [
    //                 IconButton(
    //                     onPressed: () {},
    //                     icon: Icon(
    //                       Icons.favorite_border,
    //                       color: Constants.primaryColor,
    //                     )),
    //                 Container(
    //                   height: screenSize.height * 0.07,
    //                   decoration: BoxDecoration(
    //                       color: Colors.grey.shade300,
    //                       borderRadius: BorderRadius.circular(8)),
    //                   child: Row(children: [
    //                     IconButton(onPressed: () {}, icon: Icon(Icons.add)),
    //                     Text("1"),
    //                     IconButton(onPressed: () {}, icon: Icon(Icons.remove)),
    //                   ]),
    //                 ),
    //                 ElevatedButton(
    //                     onPressed: () {},
    //                     child: Text(
    //                       "اضف للسلة",
    //                       style: TextStyle(color: Colors.white),
    //                     ))
    //               ],
    //             ),
    //           ],
    //         ),
    //       ),
    //     ),
    //   ),
    // );
  }
}
