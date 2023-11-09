// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:flutter/foundation.dart';
import '../../model/response/users_response.dart';
import '/helper/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '/data/local/preference/preference_manager.dart';

class PreferenceManagerImpl implements PreferenceManager {
  final _preference = SharedPreferences.getInstance();
  static const _keyAccessToken = "accessToken";
  static const _keyRefreshToken = "refreshToken";
  static const _keyAccessTokenExp = "accessTokenExp";
  static const _keyCurrentUser = "currentUser";

  @override
  Future<void> updateTokens({
    String? accessToken,
    String? refreshToken,
    String? accessTokenExp,
  }) async {
    try {
      String at = parseJwtToken(accessToken);
      String rt = parseJwtToken(refreshToken);
      await Future.wait([
        setString(_keyAccessToken, at),
        setString(_keyRefreshToken, rt),
        setString(_keyAccessTokenExp,  accessTokenExp ?? ''),
      ]);
      if (rt.isEmpty) {
        await setString(
          _keyCurrentUser,
          "",
        );
      } else {
        if (at.isNotEmpty) {
          await setString(
            _keyCurrentUser,
            jsonEncode(parseCurrentUserFromJwtToken(at)),
          );
        }
      }
    } catch (err) {
      debugPrint("ERROR updateTokens $err");
    }
  }

  @override
  Future<String> getAccessToken() async {
    String token = await getString(_keyAccessToken);
    return parseJwtToken(token);
  }

  @override
  Future<String> getRefreshToken() async {
    String token = await getString(_keyRefreshToken);
    return parseJwtToken(token);
  }

  @override
  Future<String> getAccessTokenString() async {
   String token = await getString(_keyAccessToken);
    return token;
  }

  @override
  Future<String> getRefreshTokenString() async {
    String token = await getString(_keyRefreshToken);
    return token;
  }

  @override
  Future<String> getAccessTokenTimeExp() async {
    String token = await getString(_keyAccessTokenExp);
    return token;
  }

  @override
  Future<bool> isUserLoggedIn() async {
    return (await getRefreshToken()).isNotEmpty;
  }


  @override
  Future<int> getMyId() async {
    return (await getCurrentUser()).id ?? 0;
  }

  @override
  Future<CurrentUserData> getCurrentUser() async {
    CurrentUserData cu = CurrentUserData();
    try {
      String cuStr = await getString(_keyCurrentUser);
      cu = CurrentUserData.fromJson(jsonDecode(cuStr));
      if (cu.id == null || cu.id == 0) {
        throw "No user id found";
      }
    } catch (err) {
      String at = await getAccessToken();
      if (at.isNotEmpty) {
        cu = parseCurrentUserFromJwtToken(at);
      }
    }
    return cu;
  }

  @override
  Future<String> getString(String key, {String defaultValue = ""}) {
    return _preference
        .then((preference) => preference.getString(key) ?? defaultValue);
  }

  @override
  Future<bool> setString(String key, String value) {
    return _preference.then((preference) => preference.setString(key, value));
  }

  @override
  Future<int> getInt(String key, {int defaultValue = 0}) {
    return _preference
        .then((preference) => preference.getInt(key) ?? defaultValue);
  }

  @override
  Future<bool> setInt(String key, int value) {
    return _preference.then((preference) => preference.setInt(key, value));
  }

  @override
  Future<double> getDouble(String key, {double defaultValue = 0.0}) {
    return _preference
        .then((preference) => preference.getDouble(key) ?? defaultValue);
  }

  @override
  Future<bool> setDouble(String key, double value) {
    return _preference.then((preference) => preference.setDouble(key, value));
  }

  @override
  Future<bool> getBool(String key, {bool defaultValue = false}) {
    return _preference
        .then((preference) => preference.getBool(key) ?? defaultValue);
  }

  @override
  Future<bool> setBool(String key, bool value) {
    return _preference.then((preference) => preference.setBool(key, value));
  }

  @override
  Future<List<String>> getStringList(String key,
      {List<String> defaultValue = const []}) {
    return _preference
        .then((preference) => preference.getStringList(key) ?? defaultValue);
  }

  @override
  Future<bool> setStringList(String key, List<String> value) {
    return _preference
        .then((preference) => preference.setStringList(key, value));
  }

  @override
  Future<bool> remove(String key) {
    return _preference.then((preference) => preference.remove(key));
  }

  @override
  Future<bool> clear() {
    return _preference.then((preference) => preference.clear());
  }
}
