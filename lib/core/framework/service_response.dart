// ignore_for_file: unnecessary_string_escapes

import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'base_notifier.dart';

class ServiceResponse<T> {
  String? message;
  bool error;
  T? data;

  ServiceResponse({this.data, this.message, required this.error});

  NotifierState<T> toNotifierState() {
    return NotifierState<T>(
      status: !error ? NotifierStatus.done : NotifierStatus.error,
      message: message,
      data: data,
    );
  }

  AsyncValue<T> toAsyncValue() {
    return !error
        ? AsyncData(data as T)
        : AsyncError(message!, StackTrace.current);
  }
}

ServiceResponse<T> serveError<T>({required String error}) {
  return ServiceResponse<T>(
    error: true,
    message: error,
  );
}

ServiceResponse<T> serveNoInternetError<T>() {
  return ServiceResponse<T>(
    error: true,
    message: 'Check your Internet Connection.',
  );
}

ServiceResponse<T> serveData<T>({required T? value, String? message}) {
  return ServiceResponse<T>(
    error: false,
    data: value,
    message: message,
  );
}

typedef FutureHandler<T> = Future<ServiceResponse<T>>;

Future<ServiceResponse<T>> serveFuture<T>({
  required Future<T> Function(Fail fail) function,
  String Function(Object e)? handleError,
  String Function(T response)? handleData,
}) async {
  try {
    final T response = await function(_fail);
    String? message;
    if (handleData != null) {
      message = handleData(response);
    }
    return serveData<T>(value: response, message: message);
  } on DioException catch (_) {
    // print(_.error.toString());
    // if (_.error.toString().contains('SocketException')) {
    //   return serveError(error: 'Check your internet connection!');
    // }
    if (_.response == null) {
      return serveError(error: defaultError);
    }
    if (_.response!.statusCode == 400 || _.response!.statusCode == 404) {
      final body = _.response!.data;
      if (body['message'] is String) {
        return serveError(error: body['message'] ?? defaultError);
      }
      return serveError(error: defaultError);
    }
    if (_.error == DioExceptionType.connectionTimeout ||
        _.error == DioExceptionType.receiveTimeout) {
      return serveError(error: timeoutE);
    }

    return serveError(error: defaultError);
  } on ServeException catch (e) {
    return serveError<T>(error: e.message);
  } catch (e) {
    String error = handleError == null ? e.toString() : handleError(e);
    return serveError<T>(error: error);
  }
}

class ServeException implements Exception {
  late final String message;
  ServeException(this.message);
}

typedef Fail = Function(String message);

Never _fail(String message) => throw ServeException(message);

const defaultError = 'Something went wrong ¯/_(ツ)_/¯';
const timeoutE = 'Connection Timeout ¯/_(ツ)_/¯';

typedef FutureResponse<T> = Future<ServiceResponse<T>>;
typedef StreamResponse<T> = Stream<ServiceResponse<T>>;
