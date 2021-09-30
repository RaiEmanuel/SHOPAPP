import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesApp{
  //falta bool e list string para tipos - SET
  static Future<SharedPreferences> _futureSharedPreferenceApp = SharedPreferences.getInstance();

  /* CORRIGIR FORMA DE IMPLEMENTAÇÃO PARA APENAS UMA INICIALIZAÇÃO */

  static Future<void> setValueInt(String key, int value) async{
    final SharedPreferences _sharedPreferencesApp = await _futureSharedPreferenceApp;
    _sharedPreferencesApp.setInt(key, value);
  }

  static Future<void> setValueString(String key, String value) async{
    final SharedPreferences _sharedPreferencesApp = await _futureSharedPreferenceApp;
    await _sharedPreferencesApp.setString(key, value);
    if(_sharedPreferencesApp.containsKey(key)){
      String pegou = _sharedPreferencesApp.getString(key)!;
      print("pegou ===== ${pegou}");
    }
    print("set contains ================= ${_sharedPreferencesApp.containsKey(key)} == ${value}");
  }

  static Future<void> setValueDouble(String key, double value) async{
    final SharedPreferences _sharedPreferencesApp = await _futureSharedPreferenceApp;
    _sharedPreferencesApp.setDouble(key, value);
  }

  //falta bool e list string para tipos - GET

  static Future<String> getValueString(String key) async {
    final SharedPreferences _sharedPreferencesApp = await _futureSharedPreferenceApp;
    String s = await (_sharedPreferencesApp.getString(key) ?? "default");
    print("get contains ================= ${_sharedPreferencesApp.containsKey(key)} == ${key}");
    return s;
  }

}