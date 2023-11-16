import 'package:http/http.dart' as http;

import '../../utils/logger.dart';

class ApiClient {
  const ApiClient._();

  static ApiClient instance = const ApiClient._();

  Future<http.Response> get(String url) async {
    'ApiClient get start'.log();
    try {
      return await http.get(Uri.parse(url));
    } on Exception catch (e) {
      'ApiClient get exception: $e'.log();
      return Future.error(e);
    } finally {
      'ApiClient get finally'.log();
    }
  }
}
