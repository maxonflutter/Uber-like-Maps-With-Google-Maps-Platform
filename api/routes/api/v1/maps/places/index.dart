import 'dart:async';
import 'dart:io';

import 'package:dart_frog/dart_frog.dart';

FutureOr<Response> onRequest(RequestContext context) async {
  if (context.request.method != HttpMethod.get) {
    return Response(statusCode: HttpStatus.methodNotAllowed);
  }

  return _get(context);
}

Future<Response> _get(RequestContext context) async {
  try {
    return Response.json(body: {});
  } catch (err) {
    return Response.json(
      body: {'error': 'Failed to fetch the place details: ${err.toString()}'},
      statusCode: HttpStatus.badRequest,
    );
  }
}
