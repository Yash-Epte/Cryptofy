// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coins_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getCoinsHash() => r'871b927d22a2564fe34427c131bf68ab5b417c72';

/// See also [getCoins].
@ProviderFor(getCoins)
final getCoinsProvider = AutoDisposeFutureProvider<List<Coins>>.internal(
  getCoins,
  name: r'getCoinsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$getCoinsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef GetCoinsRef = AutoDisposeFutureProviderRef<List<Coins>>;
String _$getPredictDataHash() => r'1ead60220807881790f340adb92e9c5a3be6c660';

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

/// See also [getPredictData].
@ProviderFor(getPredictData)
const getPredictDataProvider = GetPredictDataFamily();

/// See also [getPredictData].
class GetPredictDataFamily extends Family<AsyncValue<Map<String, dynamic>>> {
  /// See also [getPredictData].
  const GetPredictDataFamily();

  /// See also [getPredictData].
  GetPredictDataProvider call({
    required String coinName,
    required dynamic fromTime,
    required dynamic endTime,
  }) {
    return GetPredictDataProvider(
      coinName: coinName,
      fromTime: fromTime,
      endTime: endTime,
    );
  }

  @override
  GetPredictDataProvider getProviderOverride(
    covariant GetPredictDataProvider provider,
  ) {
    return call(
      coinName: provider.coinName,
      fromTime: provider.fromTime,
      endTime: provider.endTime,
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
  String? get name => r'getPredictDataProvider';
}

/// See also [getPredictData].
class GetPredictDataProvider
    extends AutoDisposeFutureProvider<Map<String, dynamic>> {
  /// See also [getPredictData].
  GetPredictDataProvider({
    required String coinName,
    required dynamic fromTime,
    required dynamic endTime,
  }) : this._internal(
          (ref) => getPredictData(
            ref as GetPredictDataRef,
            coinName: coinName,
            fromTime: fromTime,
            endTime: endTime,
          ),
          from: getPredictDataProvider,
          name: r'getPredictDataProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getPredictDataHash,
          dependencies: GetPredictDataFamily._dependencies,
          allTransitiveDependencies:
              GetPredictDataFamily._allTransitiveDependencies,
          coinName: coinName,
          fromTime: fromTime,
          endTime: endTime,
        );

  GetPredictDataProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.coinName,
    required this.fromTime,
    required this.endTime,
  }) : super.internal();

  final String coinName;
  final dynamic fromTime;
  final dynamic endTime;

  @override
  Override overrideWith(
    FutureOr<Map<String, dynamic>> Function(GetPredictDataRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetPredictDataProvider._internal(
        (ref) => create(ref as GetPredictDataRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        coinName: coinName,
        fromTime: fromTime,
        endTime: endTime,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<Map<String, dynamic>> createElement() {
    return _GetPredictDataProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetPredictDataProvider &&
        other.coinName == coinName &&
        other.fromTime == fromTime &&
        other.endTime == endTime;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, coinName.hashCode);
    hash = _SystemHash.combine(hash, fromTime.hashCode);
    hash = _SystemHash.combine(hash, endTime.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GetPredictDataRef on AutoDisposeFutureProviderRef<Map<String, dynamic>> {
  /// The parameter `coinName` of this provider.
  String get coinName;

  /// The parameter `fromTime` of this provider.
  dynamic get fromTime;

  /// The parameter `endTime` of this provider.
  dynamic get endTime;
}

class _GetPredictDataProviderElement
    extends AutoDisposeFutureProviderElement<Map<String, dynamic>>
    with GetPredictDataRef {
  _GetPredictDataProviderElement(super.provider);

  @override
  String get coinName => (origin as GetPredictDataProvider).coinName;
  @override
  dynamic get fromTime => (origin as GetPredictDataProvider).fromTime;
  @override
  dynamic get endTime => (origin as GetPredictDataProvider).endTime;
}

String _$getMontlyDataHash() => r'd6d4c7c8037fee0d9a08bb98c546874822535bdb';

/// See also [getMontlyData].
@ProviderFor(getMontlyData)
const getMontlyDataProvider = GetMontlyDataFamily();

/// See also [getMontlyData].
class GetMontlyDataFamily extends Family<AsyncValue<Map<String, dynamic>>> {
  /// See also [getMontlyData].
  const GetMontlyDataFamily();

  /// See also [getMontlyData].
  GetMontlyDataProvider call({
    required String coinName,
  }) {
    return GetMontlyDataProvider(
      coinName: coinName,
    );
  }

  @override
  GetMontlyDataProvider getProviderOverride(
    covariant GetMontlyDataProvider provider,
  ) {
    return call(
      coinName: provider.coinName,
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
  String? get name => r'getMontlyDataProvider';
}

/// See also [getMontlyData].
class GetMontlyDataProvider
    extends AutoDisposeFutureProvider<Map<String, dynamic>> {
  /// See also [getMontlyData].
  GetMontlyDataProvider({
    required String coinName,
  }) : this._internal(
          (ref) => getMontlyData(
            ref as GetMontlyDataRef,
            coinName: coinName,
          ),
          from: getMontlyDataProvider,
          name: r'getMontlyDataProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getMontlyDataHash,
          dependencies: GetMontlyDataFamily._dependencies,
          allTransitiveDependencies:
              GetMontlyDataFamily._allTransitiveDependencies,
          coinName: coinName,
        );

  GetMontlyDataProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.coinName,
  }) : super.internal();

  final String coinName;

  @override
  Override overrideWith(
    FutureOr<Map<String, dynamic>> Function(GetMontlyDataRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetMontlyDataProvider._internal(
        (ref) => create(ref as GetMontlyDataRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        coinName: coinName,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<Map<String, dynamic>> createElement() {
    return _GetMontlyDataProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetMontlyDataProvider && other.coinName == coinName;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, coinName.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GetMontlyDataRef on AutoDisposeFutureProviderRef<Map<String, dynamic>> {
  /// The parameter `coinName` of this provider.
  String get coinName;
}

class _GetMontlyDataProviderElement
    extends AutoDisposeFutureProviderElement<Map<String, dynamic>>
    with GetMontlyDataRef {
  _GetMontlyDataProviderElement(super.provider);

  @override
  String get coinName => (origin as GetMontlyDataProvider).coinName;
}

String _$getDailyDataHash() => r'54b7a5bd80a24f91cd6c48750bfaf63ca1ef6786';

/// See also [getDailyData].
@ProviderFor(getDailyData)
const getDailyDataProvider = GetDailyDataFamily();

/// See also [getDailyData].
class GetDailyDataFamily extends Family<AsyncValue<Map<String, dynamic>>> {
  /// See also [getDailyData].
  const GetDailyDataFamily();

  /// See also [getDailyData].
  GetDailyDataProvider call({
    required String coinName,
  }) {
    return GetDailyDataProvider(
      coinName: coinName,
    );
  }

  @override
  GetDailyDataProvider getProviderOverride(
    covariant GetDailyDataProvider provider,
  ) {
    return call(
      coinName: provider.coinName,
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
  String? get name => r'getDailyDataProvider';
}

/// See also [getDailyData].
class GetDailyDataProvider
    extends AutoDisposeFutureProvider<Map<String, dynamic>> {
  /// See also [getDailyData].
  GetDailyDataProvider({
    required String coinName,
  }) : this._internal(
          (ref) => getDailyData(
            ref as GetDailyDataRef,
            coinName: coinName,
          ),
          from: getDailyDataProvider,
          name: r'getDailyDataProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getDailyDataHash,
          dependencies: GetDailyDataFamily._dependencies,
          allTransitiveDependencies:
              GetDailyDataFamily._allTransitiveDependencies,
          coinName: coinName,
        );

  GetDailyDataProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.coinName,
  }) : super.internal();

  final String coinName;

  @override
  Override overrideWith(
    FutureOr<Map<String, dynamic>> Function(GetDailyDataRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetDailyDataProvider._internal(
        (ref) => create(ref as GetDailyDataRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        coinName: coinName,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<Map<String, dynamic>> createElement() {
    return _GetDailyDataProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetDailyDataProvider && other.coinName == coinName;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, coinName.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GetDailyDataRef on AutoDisposeFutureProviderRef<Map<String, dynamic>> {
  /// The parameter `coinName` of this provider.
  String get coinName;
}

class _GetDailyDataProviderElement
    extends AutoDisposeFutureProviderElement<Map<String, dynamic>>
    with GetDailyDataRef {
  _GetDailyDataProviderElement(super.provider);

  @override
  String get coinName => (origin as GetDailyDataProvider).coinName;
}

String _$getStreamCoinsHash() => r'9d77d92b5908be9d899cbe7b29b91c799bcb8c46';

/// See also [getStreamCoins].
@ProviderFor(getStreamCoins)
final getStreamCoinsProvider = AutoDisposeStreamProvider<List<Coins>>.internal(
  getStreamCoins,
  name: r'getStreamCoinsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$getStreamCoinsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef GetStreamCoinsRef = AutoDisposeStreamProviderRef<List<Coins>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
