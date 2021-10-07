import 'package:http/http.dart' as http;

class BaseProvider {
  static final int RESPONSE_SUCCESS = 1;
  static final int RESPONSE_NETWORK = 2;
  static final int RESPONSE_BAD_CREDENTIALS = 3;

  //static final String cmsBaseUrl = "https://api.midowe.co.mz";
  static final String cmsBaseUrl = "http://localhost:1337";

  Future<http.Response> post(String path, String body) async {
    return await http.post(Uri.parse("$cmsBaseUrl$path"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: body);
  }

  Future<http.Response> get(String path) async {
    return await http
        .get(Uri.parse("$cmsBaseUrl$path"), headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    });
  }
}
