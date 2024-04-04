import 'package:dart_frog/dart_frog.dart';
import 'package:maps_client/maps_client.dart';

import '../../../main.dart';

Handler middleware(Handler handler) {
  return handler
      .use(requestLogger())
      .use(provider<GoogleMapsClient>((_) => mapsClient));
}
