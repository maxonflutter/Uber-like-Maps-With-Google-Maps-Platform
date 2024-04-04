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
    final placeId = data['placeId'];

    if (placeId == null) {
      return Response.json(
        body: {'error': 'Invalid placeId parameter'},
        statusCode: HttpStatus.badRequest,
      );
    } else {
      final response = await mapsClient.fetchPlaceDetails(placeId: placeId);
      print(response.toJson());
      return Response.json(
        body: {
          'place': response.toJson(),
        },
      );
    }
  } catch (err) {
    return Response.json(
      body: {'error': 'Failed to fetch the place details: ${err.toString()}'},
      statusCode: HttpStatus.badRequest,
    );
  }
}
