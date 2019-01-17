import 'package:chopper/chopper.dart';

typedef T JsonFactory<T>(Map<String, dynamic> json);

class JsonSerializableConverter extends Converter {
  final Map<Type, JsonFactory> factories;

  JsonSerializableConverter(this.factories);

  T _decode<T>(Map<String, dynamic> values) {
    /// Get jsonFactory using Type parameters
    /// if not found or invalid, throw error or return null
    final jsonFactory = factories[T];
    if (jsonFactory == null || jsonFactory is! JsonFactory<T>) {
      /// throw serializer not found error;
      return null;
    }

    return jsonFactory(values);
  }

  List<T> _decodeList<T>(List values) =>
      values.where((v) => v != null).map((v) => _decode<T>(v)).toList();

  @override
  Future decodeEntity<T>(entity) async {
    if (entity == null) return null;

    /// handle case when we want to access to Map<String, dynamic> directly
    /// getResource or getMapResource
    /// Avoid dynamic or unconverted value, this could lead to several issues
    if (entity is T) return entity;
    if (entity is Iterable) return _decodeList<T>(entity);

    return _decode<T>(entity);
  }

  @override
  encodeEntity<T>(T entity) async => entity;
}
