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

    final response = await mapsClient.fetchAutocompleteSuggestions(
      query: data['query'],
      locationBias: {
        "circle": {
          "center": {
            "latitude": data['latitude'],
            "longitude": data['longitude'],
          },
          "radius": 10000.0,
        }
      },
    );

    return Response.json(body: {
      'suggestions': response.map((e) => e.toJson()).toList(),
    });
  } catch (err) {
    return Response.json(
      body: {'error': 'Failed to fetch the suggestions: ${err.toString()}'},
      statusCode: HttpStatus.badRequest,
    );
  }
}
