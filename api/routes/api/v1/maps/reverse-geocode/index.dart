import 'dart:async';
import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:maps_client/maps_client.dart';

FutureOr<Response> onRequest(RequestContext context) async {
  if (context.request.method != HttpMethod.get) {
    return Response(statusCode: HttpStatus.methodNotAllowed);
  }

  return _get(context);
}

Future<Response> _get(RequestContext context) async {
  final mapsClient = context.read<GoogleMapsClient>();
  try {
    final data = context.request.uri.queryParameters;

    final latitude = data['latitude'];
    final longitude = data['longitude'];

    if (latitude == null || longitude == null) {
      return Response.json(
        body: {'error': 'Latitude and longitude are required'},
        statusCode: HttpStatus.badRequest,
      );
    }

    final response = await mapsClient.latLonToAddress(
      latitude: double.parse(latitude),
      longitude: double.parse(longitude),
    );

    return Response.json(body: {'address': response.toJson()});
  } catch (err) {
    return Response.json(
      body: {'error': 'Failed to fetch the address: ${err.toString()}'},
      statusCode: HttpStatus.badRequest,
    );
  }
}
