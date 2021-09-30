import 'package:http/http.dart' as http;

class Connection{

  static String _host = "jsonplaceholder.typicode.com";
  static Future<String> getAttr() async{
    var client = http.Client();
    await Future.delayed(Duration(seconds: 3), ()=>"a");
    var res = await client.get(Uri.parse("https://jsonplaceholder.typicode.com/users/1"));
    //print('Response body: ${response.body}');
    return res.body;
  }

  static Future<String> auth(String login, String password) async {
    var client = http.Client();
    try {
      var uriResponse = await client.post(Uri.parse('https://fakeecommerceapi.herokuapp.com/auth'),
          body: {'email': login, 'password': password});
      return uriResponse.body;

    } finally {
    client.close();
    }
  }

  static Future<String> me(String type, String token) async {
    var client = http.Client();
    try {
      var uriResponse = await client.get(Uri.parse('https://fakeecommerceapi.herokuapp.com/me'),
      headers: {"Authorization":type+" "+token});
      return uriResponse.body;
    } finally {
      client.close();
    }
  }

  static Future<String> products() async {
    var client = http.Client();
    try {
      var uriResponse = await client.get(Uri.parse('https://fakeecommerceapi.herokuapp.com/products'));
          //headers: {"Authorization":type+" "+token});
      return uriResponse.body;
    } finally {
      client.close();
    }
  }


}
