
import 'package:shared_preferences/shared_preferences.dart';

//静态方法
class SqUtil {
  
  //setters
  static void setInt(String key, int value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(key, value);
  }
  static void setString(String key, String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }
  static void setBool(String key, bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(key, value);
  }

  //getters
  static void getInt(String key, int value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.getInt(key);
  }
  static void getString(String key, String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.getString(key);
  }
  static void getBool(String key, bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.getBool(key);
  }

  

}