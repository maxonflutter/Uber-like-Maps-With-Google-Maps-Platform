class PlaceAutocompleteResponse {
  final String placeId;
  final String text;

  const PlaceAutocompleteResponse({
    required this.placeId,
    required this.text,
  });

  factory PlaceAutocompleteResponse.fromJson(Map<String, dynamic> json) {
    final data = json['placePrediction'] as Map<String, dynamic>;
    final placeId = data['placeId'] as String;
    final text = data['structuredFormat']['mainText']['text'] as String;
    return PlaceAutocompleteResponse(placeId: placeId, text: text);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': placeId,
      'text': text,
    };
  }
}
