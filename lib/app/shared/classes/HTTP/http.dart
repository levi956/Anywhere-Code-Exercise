import 'package:anywhere_code_exercise/core/core.dart';
import 'package:awesome_dio_interceptor/awesome_dio_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

const seconds60 = Duration(seconds: 60);
const baseUrlPath = 'BASE_URL';

final _customIntercepor = AwesomeDioInterceptor(
    logRequestTimeout: false,
    logRequestHeaders: false,
    logResponseHeaders: false);

const _rType = ResponseType.json;

class HTTP {
  static void clearHeader() {
    final dio = Dio();
    dio.options.headers.clear();
  }

  static String get baseUrl => dotenv.env[baseUrlPath] ?? nullString;

  static final Map<String, String> _headers = Map<String, String>.from(
    {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    },
  );

  static Map<String, String> get _getHeaders =>
      Map<String, String>.from(_headers);

  static List<String> headerLog = [];

  static addHeader({
    required String key,
    required String value,
  }) {
    _headers[key] = value;
    headerLog.add("$key: $value");
  }

  static Future<Response> get({String? endpoint}) async {
    final dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        responseType: _rType,
        headers: _getHeaders,
        connectTimeout: seconds60,
        receiveTimeout: seconds60,
      ),
    )..interceptors.add(_customIntercepor);
    String url = endpoint ?? '?q=${env.queryPathUrl}&format=json';
    final response = await dio.get(url);
    return response;
  }
}
