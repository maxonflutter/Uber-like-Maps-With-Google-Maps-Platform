import 'dart:async';
import 'dart:io';

import 'package:api_client/src/resources/resources.dart';
import 'package:http/http.dart' as http;

class ApiClient {
  ApiClient({
    required String baseUrl,
    PostCall postCall = http.post,
    GetCall getCall = http.get,
  })  : _base = Uri.parse(baseUrl),
        _post = postCall,
        _get = getCall;

  final Uri _base;
  final PostCall _post;
  final GetCall _get;

  Map<String, String> get _headers => {};

  late final mapsResource = MapsResource(apiClient: this);

  /// Sends a POST request to the specified [path] with the given [body].
  Future<http.Response> post(
    String path, {
    Object? body,
    Map<String, String>? queryParameters,
  }) async {
    final response = await _post(
      _base.replace(
        path: path,
        queryParameters: queryParameters,
      ),
      body: body,
      headers: _headers
        ..addAll({HttpHeaders.contentTypeHeader: ContentType.json.value}),
    );

    return response;
  }

  /// Sends a GET request to the specified [path].
  Future<http.Response> get(
    String path, {
    Map<String, String>? queryParameters,
  }) async {
    final response = await _get(
      _base.replace(
        path: path,
        queryParameters: queryParameters,
      ),
      headers: _headers,
    );

    return response;
  }
}

/// Definition of a post call used by this client.
typedef PostCall = Future<http.Response> Function(
  Uri, {
  Object? body,
  Map<String, String>? headers,
});

/// Definition of a get call used by this client.
typedef GetCall = Future<http.Response> Function(
  Uri, {
  Map<String, String>? headers,
});
