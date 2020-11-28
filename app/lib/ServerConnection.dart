import 'package:http/http.dart' as http;
import 'dart:convert';

class ServerConnection {

  static const server = "http://194.58.122.45:6535/";

  static Future<Map> login(body) async {
    var response = await http.get(server + 'login/?login=' + body["login"] + '&password=' + body["password"]);

    return jsonDecode(response.body);
  }

  static Future<Map> getById(id) async {
    print("Started");
    var response = await http.get(server + 'get_house/?house_id=$id');
    return jsonDecode(response.body);
  }

  static Future<Map> topSurvies() async {
    var response = await http.get(server + 'top_survies/?user_id=1');
    return jsonDecode(response.body);
  }

  static Future topInitiatives() async {
    var response = await http.get(server + 'top_initiatives/');
    return jsonDecode(utf8.decode(response.bodyBytes));
  }

  static sendToEmail(login, text) async{
    var response = await http.get(server + '/feedback/?user_name=' + login + '&text=' + text);
  }
}