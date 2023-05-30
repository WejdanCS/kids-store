import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kids_store_app/api/login_user.dart';
import 'package:kids_store_app/api/register_user.dart';
import 'package:kids_store_app/models/login_model.dart';
import 'package:kids_store_app/models/register_model.dart';
import 'package:kids_store_app/pages/home_page.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kids_store_app/pages/login.dart';

import '../utlis/constants.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordConfirmationController =
      TextEditingController();

  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
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
                // SizedBox(
                //   height: screenSize.height * 0.01,
                // ),
                SvgPicture.asset(
                  "assets/images/Kids Store.svg",
                  semanticsLabel: 'Kids Store logo',
                  width: 120,
                ),
                const Text(
                  "مرحبا بك في كيدز ستور",
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: screenSize.height * 0.01,
                ),
                const Text(
                  "تسجيل حساب جديد",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
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
                          height: screenSize.height * 0.02,
                        ),
                        TextFormField(
                          validator: (value) {
                            if (value == null || value == "") {
                              return "يجب ادخال الاسم";
                            }

                            return null;
                          },
                          decoration: InputDecoration(
                            labelText: "ادخل الاسم",
                            helperText: "أحمد محمد",
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
                          keyboardType: TextInputType.name,
                          controller: nameController,
                        ),
                        SizedBox(
                          height: screenSize.height * 0.02,
                        ),
                        TextFormField(
                          validator: (value) {
                            if (value == null || value == "") {
                              return "يجب ادخال العنوان";
                            }

                            return null;
                          },
                          decoration: InputDecoration(
                            labelText: "ادخل العنوان",
                            helperText: "جدة-حي الصفا",
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
                          keyboardType: TextInputType.text,
                          controller: addressController,
                        ),
                        SizedBox(
                          height: screenSize.height * 0.02,
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
                        SizedBox(
                          height: screenSize.height * 0.02,
                        ),
                        TextFormField(
                          validator: (value) {
                            if (value == null || value == "") {
                              return "يجب ادخال كلمة المرور";
                            } else if (value.length < 6) {
                              return "يجب أن لاتقل كلمة المرور عن 6 أحرف";
                            } else if (passwordController.text !=
                                passwordConfirmationController.text) {
                              return "لايوجد تطابق بين كلمات المرور";
                            } else {
                              return null;
                            }
                          },
                          decoration: InputDecoration(
                            labelText: "تأكيد كلمة المرور",
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
                            // helperText: "User123456",
                          ),
                          keyboardType: TextInputType.text,
                          obscureText: true,
                          controller: passwordConfirmationController,
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
                                      status: "جاري تسجيل الحساب");
                                  RegisterResponse? registerRespone =
                                      await register(
                                          name: nameController.text,
                                          email: emailController.text,
                                          password: passwordController.text,
                                          passwordConfirmation:
                                              passwordConfirmationController
                                                  .text,
                                          address: addressController.text);
                                  await EasyLoading.dismiss();
                                  if (registerRespone != null &&
                                      registerRespone.status == true) {
                                    Fluttertoast.showToast(
                                        msg: "سجل الدخول،تم تسجيل الحساب",
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
                                            LoginPage(),
                                      ),
                                    );
                                  } else {
                                    String err = "";
                                    if (registerRespone!.errors!.email !=
                                            null &&
                                        registerRespone
                                            .errors!.email!.isNotEmpty) {
                                      err += registerRespone.errors!.email![0];
                                    } else if (registerRespone
                                                .errors!.password !=
                                            null &&
                                        registerRespone
                                            .errors!.password!.isNotEmpty) {
                                      err +=
                                          registerRespone.errors!.password![0];
                                    } else if (registerRespone
                                                .errors!.passwordConfirmation !=
                                            null &&
                                        registerRespone.errors!
                                            .passwordConfirmation!.isNotEmpty) {
                                      err += registerRespone
                                          .errors!.passwordConfirmation![0];
                                    } else if (registerRespone
                                                .errors!.address !=
                                            null &&
                                        registerRespone
                                            .errors!.address!.isNotEmpty) {
                                      err +=
                                          registerRespone.errors!.address![0];
                                    } else if (registerRespone.errors!.name !=
                                            null &&
                                        registerRespone
                                            .errors!.name!.isNotEmpty) {
                                      err += registerRespone.errors!.name![0];
                                    }

                                    Fluttertoast.showToast(
                                        msg: err,
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
                              "تسجيل",
                              style: TextStyle(color: Colors.white),
                            )),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("لديك حساب؟"),
                            TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            const LoginPage()),
                                  );
                                },
                                child: Text("تسجيل الدخول"))
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
