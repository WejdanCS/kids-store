import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kids_store_app/api/login_user.dart';
import 'package:kids_store_app/pages/home_page.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../utlis/constants.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    emailController.text = "wejdanaljadani@gmail.com";
    passwordController.text = "12345678";
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: SafeArea(
            child: SizedBox(
          width: screenSize.width,
          // color: Colors.amber,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: screenSize.height * 0.04,
                ),
                SvgPicture.asset(
                  "assets/images/Kids Store.svg",
                  semanticsLabel: 'Kids Store logo',
                  width: 180,
                ),
                const Text(
                  "مرحبا بك في كيدز ستور",
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.w500),
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: screenSize.width * 0.06),
                  child: Form(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: screenSize.height * 0.04,
                        ),

                        TextFormField(
                          decoration: InputDecoration(
                            labelText: "ادخل البريد الالكتروني",
                            helperText: "user@gmail.com",
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: const BorderSide(
                                  color: Constants.primaryColor, width: 1.2),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: const BorderSide(
                                  color: Constants.thirdColor, width: 1.2),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: const BorderSide(
                                  color: Colors.red, width: 1.2),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: const BorderSide(
                                  color: Constants.primaryColor, width: 1.2),
                            ),
                            prefixIcon: const Icon(
                              Icons.person_outline_rounded,
                              color: Constants.primaryColor,
                            ),
                            labelStyle:
                                const TextStyle(color: Constants.primaryColor),
                            fillColor: Colors.grey,
                          ),
                          keyboardType: TextInputType.emailAddress,
                          controller: emailController,
                        ),
                        SizedBox(
                          height: screenSize.height * 0.02,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: "ادخل كلمة المرور",
                            // helperText: "user@gmail.com",
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: const BorderSide(
                                  color: Constants.primaryColor, width: 1.2),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: const BorderSide(
                                  color: Constants.thirdColor, width: 1.2),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: const BorderSide(
                                  color: Colors.red, width: 1.2),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: const BorderSide(
                                  color: Constants.primaryColor, width: 1.2),
                            ),
                            prefixIcon: const Icon(
                              Icons.visibility_off,
                              color: Constants.primaryColor,
                            ),
                            labelStyle:
                                const TextStyle(color: Constants.primaryColor),
                            fillColor: Colors.grey,
                            helperText: "User123456",
                          ),
                          keyboardType: TextInputType.text,
                          obscureText: true,
                          controller: passwordController,
                        ),

                        Align(
                          alignment: Alignment.topRight,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: screenSize.width * 0.04),
                            child: TextButton(
                              onPressed: () {},
                              child: Text(
                                "نسيت كلمة المرور؟",
                              ),
                            ),
                          ),
                        ),
                        // SizedBox(
                        //   height: screenSize.height * 0.01,
                        // ),
                        ElevatedButton(
                            style: ButtonStyle(
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ))),
                            onPressed: () async {
                              try {
                                await EasyLoading.show(
                                    status: "جاري تسجيل الدخول");
                                await login(
                                    email: emailController.text,
                                    password: passwordController.text);
                                await EasyLoading.dismiss();
                                Fluttertoast.showToast(
                                    msg: "تم تسجيل الدخول",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.CENTER,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Constants.primaryColor,
                                    textColor: Colors.white,
                                    fontSize: 16.0);

                                await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        HomePage(),
                                  ),
                                );
                              } catch (err) {
                                print("Error:${err}");
                              }
                            },
                            child: const Text(
                              "تسجيل الدخول",
                              style: TextStyle(color: Colors.white),
                            )),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("ليس لديك حساب؟"),
                            TextButton(
                                onPressed: () {}, child: Text("إنشاء حساب"))
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        )),
      ),
    );
  }
}
