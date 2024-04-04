import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:maps_client/maps_client.dart';

FutureOr<Response> onRequest(RequestContext context) async {
  if (context.request.method != HttpMethod.post) {
    return Response(statusCode: HttpStatus.methodNotAllowed);
  }

  return _post(context);
}

Future<Response> _post(RequestContext context) async {
  try {
    return Response.json(body: {});
  } catch (err) {
    return Response.json(
      body: {'error': 'Failed to fetch the directions: ${err.toString()}'},
      statusCode: HttpStatus.badRequest,
    );
  }
}
