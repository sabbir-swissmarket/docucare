import 'dart:convert';
import 'package:docucare/utils/core.dart';

class SharedPrefManager {
  saveStringValue(String keyName, String data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(keyName, data);
    debugPrint("$keyName is stored");
  }

  saveIntValue(String keyName, int data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(keyName, data);
    debugPrint("$keyName is stored");
  }

  saveDoubleValue(String keyName, double data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setDouble(keyName, data);
    debugPrint("$keyName is stored");
  }

  saveBoolValue(String keyName, bool data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(keyName, data);
    debugPrint("$keyName is stored");
  }

  saveObjectValue(String keyName, dynamic data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(keyName, jsonEncode(data));
    debugPrint("$keyName is stored");
  }

  saveEnumValue(String keyName, dynamic data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(keyName, EnumToString.convertToString(data));
    debugPrint("$keyName is stored");
  }

  Future<String?> getStringValue(String keyValue) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? stringValue = prefs.getString(keyValue);
    debugPrint("$stringValue is fetch");
    return stringValue;
  }

  Future<bool?> getBoolValue(String keyValue) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? boolValue = prefs.getBool(keyValue);
    debugPrint("$boolValue is fetch");
    return boolValue;
  }

  Future<int?> getIntValue(String keyValue) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? intValue = prefs.getInt(keyValue);
    debugPrint("$intValue is fetch");
    return intValue;
  }

  Future<double?> getDoubleValue(String keyValue) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    double? doubleValue = prefs.getDouble(keyValue);
    debugPrint("$doubleValue is fetch");
    return doubleValue;
  }

  Future<dynamic> getObjectValue(String keyValue) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? stringValues = prefs.getString(keyValue);
    debugPrint("$stringValues is fetch");
    return stringValues;
  }

  Future<String?> getEnumValue(String keyValue) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? stringValues = prefs.getString(keyValue);
    debugPrint("$stringValues is fetch");
    return stringValues;
  }

  Future<bool> isKeyValid(String keyValue) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool checkValue = prefs.containsKey(keyValue);
    return checkValue;
  }

  Future<void> removeAValue(String keyValue) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    debugPrint("$keyValue is removed");
    prefs.remove(keyValue);
  }

  logOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }
}