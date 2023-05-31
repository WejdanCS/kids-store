import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kids_store_app/pages/login.dart';
import 'package:kids_store_app/utlis/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
        body: Column(
      children: [
        SizedBox(
          height: 16,
        ),
        Container(
          width: screenSize.width,
          child: ListView(
            shrinkWrap: true,
            children: [
              ListTile(
                onTap: () {
                  // print("object");
                  showDialog(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      title: Text("تنبيه"),
                      content: Text("هل أنت متأكد من تسجيل الخروج؟"),
                      actions: [
                        ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.red)),
                            onPressed: () async {
                              // Navigator.of(context).pop();
                              await EasyLoading.show(
                                  status: "جاري تسجيل الخروج");
                              SharedPreferences prefs =
                                  await SharedPreferences.getInstance();
                              prefs.setBool("isLoggedIn", false);
                              prefs.remove("token");
                              await EasyLoading.dismiss();

                              Fluttertoast.showToast(
                                  msg: "تم تسجيل الخروج بنجاح",
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
                            },
                            child: Text(
                              "نعم",
                              style: TextStyle(color: Colors.white),
                            )),
                        TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text("إلغاء"))
                      ],
                    ),
                  );
                },
                title: Text("تسجيل الخروج"),
                leading: Icon(
                  Icons.logout,
                  color: Colors.red,
                ),
              )
            ],
          ),
        ),
      ],
    ));
  }
}
