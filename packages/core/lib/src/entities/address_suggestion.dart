import 'package:freezed_annotation/freezed_annotation.dart';

part 'address_suggestion.freezed.dart';
part 'address_suggestion.g.dart';

@freezed
class AddressSuggestion with _$AddressSuggestion {
  const AddressSuggestion._();

  const factory AddressSuggestion({
    required String id,
    required String text,
  }) = _AddressSuggestion;

  factory AddressSuggestion.fromJson(Map<String, dynamic> json) =>
      _$AddressSuggestionFromJson(json);
}
