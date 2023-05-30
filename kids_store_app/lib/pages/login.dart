import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kids_store_app/api/login_user.dart';
import 'package:kids_store_app/models/login_model.dart';
import 'package:kids_store_app/pages/home_page.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kids_store_app/pages/register.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utlis/constants.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // emailController.text = "wejdanaljadani@gmail.com";
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
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: screenSize.height * 0.04,
                        ),

                        TextFormField(
                          validator: (value) {
                            final RegExp validEmail = RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
                            if (value == null || value == "") {
                              return "يجب ادخال البريد الالكتروني";
                            } else if (!validEmail.hasMatch(value)) {
                              return "يجب ادخال بريد صحيح";
                            }
                            return null;
                          },
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
                          validator: (value) {
                            if (value == null || value == "") {
                              return "يجب ادخال كلمة المرور";
                            } else if (value.length < 6) {
                              return "يجب أن لاتقل كلمة المرور عن 6 أحرف";
                            } else {
                              return null;
                            }
                          },
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
                              Icons.enhanced_encryption,
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
                              _formKey.currentState?.save();
                              if (_formKey.currentState!.validate()) {
                                try {
                                  await EasyLoading.show(
                                      status: "جاري تسجيل الدخول");
                                  LoginRespone? loginRespone = await login(
                                      email: emailController.text,
                                      password: passwordController.text);
                                  await EasyLoading.dismiss();
                                  if (loginRespone != null &&
                                      loginRespone.success == true) {
                                    Fluttertoast.showToast(
                                        msg: "تم تسجيل الدخول",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.CENTER,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: Constants.primaryColor,
                                        textColor: Colors.white,
                                        fontSize: 16.0);
                                    SharedPreferences prefs =
                                        await SharedPreferences.getInstance();
                                    prefs.setBool("isLoggedIn", true);
                                    prefs.setString(
                                        "token", loginRespone.token!);
                                    await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            HomePage(),
                                      ),
                                    );
                                  } else {
                                    Fluttertoast.showToast(
                                        msg: loginRespone!.message!,
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.CENTER,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: Constants.primaryColor,
                                        textColor: Colors.white,
                                        fontSize: 16.0);
                                  }
                                } catch (err) {
                                  print("Error:${err}");
                                  await EasyLoading.dismiss();
                                }
                              } else {
                                print("not valid");
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
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            const RegisterPage()),
                                  );
                                },
                                child: Text("إنشاء حساب"))
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
