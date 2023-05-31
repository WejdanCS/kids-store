import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:kids_store_app/api/post_order.dart';
import 'package:kids_store_app/models/post_order_model.dart';
import 'package:kids_store_app/providers/add_to_cart_provider.dart';
import 'package:kids_store_app/providers/products_provider.dart';
import 'package:kids_store_app/utlis/constants.dart';
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(child:
          Consumer<ProductsProvider>(builder: (context, products, child) {
        return Consumer<CartModel>(builder: (context, cart, child) {
          // if ()
          if (cart.getProducts().isEmpty) {
            return Center(child: Text("السلة فارغة اضف منتجات للسلة"));
          }
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Stack(
              children: [
                Column(
                  children: [
                    Text("المنتجات"),
                    Container(
                      width: screenSize.width,
                      // height: screenSize.height,
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: cart.getProducts().length,
                          itemBuilder: (context, i) {
                            products.getProducts();
                            return Dismissible(
                              // Specify the direction to swipe and delete
                              direction: DismissDirection.endToStart,
                              key: UniqueKey(),
                              background: Container(color: Colors.red),
                              onDismissed: (direction) {
                                cart.removeProduct(cart.getProducts()[i]);
                                Fluttertoast.showToast(
                                    msg: "تم حذف المنتج من السلة",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.CENTER,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Constants.primaryColor,
                                    textColor: Colors.white,
                                    fontSize: 16.0);
                              },
                              child: Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        children: [
                                          Text(cart
                                              .getProducts()[i]
                                              .product!
                                              .name!),
                                          Row(
                                            children: [
                                              Text(
                                                  "${cart.getProducts()[i].quantity} * "
                                                  " ${cart.getProducts()[i].product!.price!}ريال"),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Container(
                                        height: screenSize.height * 0.06,
                                        // width: screenSize.width * 0.3,
                                        decoration: BoxDecoration(
                                            color: Colors.grey.shade300,
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                        child: Row(children: [
                                          IconButton(
                                              onPressed: () {
                                                if (cart
                                                        .getProducts()[i]
                                                        .quantity! <
                                                    cart
                                                        .getProducts()[i]
                                                        .product!
                                                        .quantity!) {
                                                  cart.addQty(i, 1);
                                                  //   setState(() {
                                                  //     qty = qty + 1;
                                                  //   });
                                                } else {
                                                  Fluttertoast.showToast(
                                                      msg: "الكمية غير متوفرة",
                                                      toastLength:
                                                          Toast.LENGTH_SHORT,
                                                      gravity:
                                                          ToastGravity.CENTER,
                                                      timeInSecForIosWeb: 1,
                                                      backgroundColor: Constants
                                                          .primaryColor,
                                                      textColor: Colors.white,
                                                      fontSize: 16.0);
                                                }
                                              },
                                              icon: Icon(
                                                Icons.add,
                                                size: 16,
                                              )),
                                          Text(
                                              "${cart.getProducts()[i].quantity}"),
                                          IconButton(
                                              onPressed: () {
                                                if (cart
                                                        .getProducts()[i]
                                                        .quantity! >
                                                    1) {
                                                  cart.deleteQty(i, 1);
                                                  //   setState(() {
                                                  //     qty = qty - 1;
                                                  //   });
                                                }
                                              },
                                              icon: Icon(
                                                Icons.remove,
                                                size: 16,
                                              )),
                                        ]),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }),
                    ),
                  ],
                ),
                Positioned(
                    bottom: screenSize.height * 0.1,
                    right: 0,
                    left: 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("المجموع"),
                        Row(
                          children: [
                            Text(
                              "${cart.getTotal()} ",
                              style: TextStyle(
                                  color: Constants.primaryColor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text("ريال سعودي")
                          ],
                        )
                      ],
                    )),
                Positioned(
                    bottom: 0,
                    right: 0,
                    left: 0,
                    child: ElevatedButton(
                        onPressed: () async {
                          try {
                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            PostOrederResponse? orederResponse =
                                await postOrder(
                                    products: cart.getProducts(),
                                    token: prefs.getString("token")!);
                            if (orederResponse!.success == true) {
                              Fluttertoast.showToast(
                                  msg: orederResponse.message!,
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Constants.primaryColor,
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                              cart.removeAll();
                            } else {
                              Fluttertoast.showToast(
                                  msg: "لم يتم الطلب بنجاح",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Constants.primaryColor,
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                            }
                          } catch (err) {}
                        },
                        child: Text(
                          "ادفع الان",
                          style: TextStyle(color: Colors.white),
                        ))),
              ],
            ),
          );
        });
      })),
    );
  }
}
