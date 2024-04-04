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
  final mapsClient = context.read<GoogleMapsClient>();
  try {
    final body = await context.request.body();
    final data = jsonDecode(body) as Map<String, dynamic>;
    final originId = data['originId'] as String;
    final destinationId = data['destinationId'] as String;

    final response = await mapsClient.fetchDirections(
        originId: originId, destinationId: destinationId);

    return Response.json(body: {'directions': response.toJson()});
  } catch (err) {
    return Response.json(
      body: {'error': 'Failed to fetch the directions: ${err.toString()}'},
      statusCode: HttpStatus.badRequest,
    );
  }
}
