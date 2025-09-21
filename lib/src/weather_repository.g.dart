// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$weatherHash() => r'3310d49810d8cf1fb085c958e8e04b6888b766de';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [weather].
@ProviderFor(weather)
const weatherProvider = WeatherFamily();

/// See also [weather].
class WeatherFamily extends Family<AsyncValue<Weather>> {
  /// See also [weather].
  const WeatherFamily();

  /// See also [weather].
  WeatherProvider call(
    String city,
  ) {
    return WeatherProvider(
      city,
    );
  }

  @override
  WeatherProvider getProviderOverride(
    covariant WeatherProvider provider,
  ) {
    return call(
      provider.city,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'weatherProvider';
}

/// See also [weather].
class WeatherProvider extends AutoDisposeFutureProvider<Weather> {
  /// See also [weather].
  WeatherProvider(
    String city,
  ) : this._internal(
          (ref) => weather(
            ref as WeatherRef,
            city,
          ),
          from: weatherProvider,
          name: r'weatherProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$weatherHash,
          dependencies: WeatherFamily._dependencies,
          allTransitiveDependencies: WeatherFamily._allTransitiveDependencies,
          city: city,
        );

  WeatherProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.city,
  }) : super.internal();

  final String city;

  @override
  Override overrideWith(
    FutureOr<Weather> Function(WeatherRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: WeatherProvider._internal(
        (ref) => create(ref as WeatherRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        city: city,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<Weather> createElement() {
    return _WeatherProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is WeatherProvider && other.city == city;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, city.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin WeatherRef on AutoDisposeFutureProviderRef<Weather> {
  /// The parameter `city` of this provider.
  String get city;
}

class _WeatherProviderElement extends AutoDisposeFutureProviderElement<Weather>
    with WeatherRef {
  _WeatherProviderElement(super.provider);

  @override
  String get city => (origin as WeatherProvider).city;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
