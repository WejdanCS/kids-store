import 'dart:ui';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Constants {
  static const Color primaryColor = Color(0xff8299FF);
  static const Color secondaryColor = Color(0xffEC3188);
  static const Color thirdColor = Color(0xffEED641);
  static const isRealDevice = true;
  static String baseUrl = isRealDevice
      ? "http://${dotenv.env['IPNETWOTK']}:8000"
      : "http://10.0.2.2:8000";
  static String apiUrl = "$baseUrl/api";
  static String storgeUrl = "$baseUrl/storage";
}
