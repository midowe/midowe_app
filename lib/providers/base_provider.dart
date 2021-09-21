import 'package:http/http.dart' as http;

class BaseProvider {
  static final int RESPONSE_SUCCESS = 1;
  static final int RESPONSE_NETWORK = 2;
  static final int RESPONSE_BAD_CREDENTIALS = 3;

  final String cmsBaseUrl = "https://api.midowe.co.mz";

  Future<http.Response> post(String path, String body) async {
    return await http.post(Uri.parse("$cmsBaseUrl$path"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: body);
  }
}
