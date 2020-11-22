import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class HttpHelper {
  String baseUrl = 'https://dog.ceo/api/breed/';
  String razasUrl = 'https://dog.ceo/api/breeds/list/all';
  List<String> razas = [];

  Future<List> getDogs(String raza) async {
    var response = await http.get(baseUrl + '$raza/images');
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      List urlImgs = jsonResponse['message'];
      print(urlImgs);
      print(razas);
      return urlImgs;
    } else {
      print('Error: ${response.statusCode}');
      return [];
    }
  }

  Future<List> getRazas() async {
    var response = await http.get(razasUrl);
    if (response.statusCode == 200) {
      print('llamado');
      var jsonResponse = convert.jsonDecode(response.body);
      Map razasJson = jsonResponse['message'];
      razasJson.forEach((key, value) {
        razas.add(key);
      });
      return razas;
    } else {
      print(response.statusCode);
      return [];
    }
  }
}
