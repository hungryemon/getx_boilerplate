import 'package:dio/dio.dart';

dynamic processObject(Map<String, dynamic> json,
    {List? keys, bool isFormData = false}) {
  Map<String, dynamic> result = {};
  for (var entry in json.entries) {
    var k = entry.key;
    var v = entry.value;
    if (keys == null) {
      if (v != null) result[k] = v;
    } else if (keys.contains(k) && v != null) {
      result[k] = v;
    }
  }
  return isFormData ? FormData.fromMap(result) : result;
}

// Map<String, dynamic> ifContainsKey(
//     {required Map<String, dynamic> json, String? key}) {
//   Map<String, dynamic> result = {};
//   for (var entry in json.entries) {
//     var k = entry.key;
//     var v = entry.value;
//     if (keys == null) {
//       if (v != null) result[k] = v;
//     } else if (keys.contains(k) && v != null) {
//       result[k] = v;
//     }
//   }
//   return result;
// }
