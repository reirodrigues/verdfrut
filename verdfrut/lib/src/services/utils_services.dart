import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class UtilsServices {
  final storage = const FlutterSecureStorage();

  // ------------- save data
  Future<void> saveLocalData(
      {required String key, required String data}) async {
    await storage.write(
      key: key,
      value: data,
    );
  }

  // recuperar dado salvo localmente em segurança
  Future<String?> getlocalData({required key}) async {
    return await storage.read(key: key);
  }

  // remove dado salvo localmente
  Future<void> removeLocalData({required String key}) async {
    await storage.delete(key: key);
  }

  //------------------ R$
  String priceToCurrency(double price) {
    NumberFormat numberFormat = NumberFormat.simpleCurrency(locale: 'pt_BR');

    return numberFormat.format(price);
  }

  String formateDateTime(DateTime dateTime) {
    initializeDateFormatting();

    DateFormat dateFormat = DateFormat.yMd('pt_BR').add_Hm();
    return dateFormat.format(dateTime);
  }

  void showToast({
    required String message,
    bool isError = false,
  }) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: isError ? Colors.red : Colors.white,
      textColor: isError ? Colors.white : Colors.black,
      fontSize: 14,
    );
  }
}
