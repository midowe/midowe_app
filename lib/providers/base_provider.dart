import 'package:http/http.dart' as http;

class BaseProvider {
  static final int RESPONSE_SUCCESS = 1;
  static final int RESPONSE_NETWORK = 2;
  static final int RESPONSE_BAD_CREDENTIALS = 3;

  //static final String cmsBaseUrl = "https://api.midowe.co.mz";
  static final String cmsBaseUrl = "http://localhost:1337";
  static final String accountingBaseUrl =
      "https://053qw3mji7.execute-api.af-south-1.amazonaws.com";

  Future<http.Response> post(String path, String body) async {
    return await http.post(Uri.parse("$cmsBaseUrl$path"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: body);
  }

  Future<http.Response> cmsGet(String path) async {
    return await http
        .get(Uri.parse("$cmsBaseUrl$path"), headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    });
  }

  Future<http.Response> accountingGet(String path) async {
    return await http
        .get(Uri.parse("$accountingBaseUrl$path"), headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    });
  }
}
