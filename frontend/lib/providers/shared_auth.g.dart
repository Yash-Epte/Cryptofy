// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shared_auth.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$saveUserHash() => r'4518472bdbd592f14d542be811daf1ede47f2f2e';

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

/// See also [saveUser].
@ProviderFor(saveUser)
const saveUserProvider = SaveUserFamily();

/// See also [saveUser].
class SaveUserFamily extends Family<AsyncValue<void>> {
  /// See also [saveUser].
  const SaveUserFamily();

  /// See also [saveUser].
  SaveUserProvider call(
    List<String> currentUser,
  ) {
    return SaveUserProvider(
      currentUser,
    );
  }

  @override
  SaveUserProvider getProviderOverride(
    covariant SaveUserProvider provider,
  ) {
    return call(
      provider.currentUser,
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
  String? get name => r'saveUserProvider';
}

/// See also [saveUser].
class SaveUserProvider extends AutoDisposeFutureProvider<void> {
  /// See also [saveUser].
  SaveUserProvider(
    List<String> currentUser,
  ) : this._internal(
          (ref) => saveUser(
            ref as SaveUserRef,
            currentUser,
          ),
          from: saveUserProvider,
          name: r'saveUserProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$saveUserHash,
          dependencies: SaveUserFamily._dependencies,
          allTransitiveDependencies: SaveUserFamily._allTransitiveDependencies,
          currentUser: currentUser,
        );

  SaveUserProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.currentUser,
  }) : super.internal();

  final List<String> currentUser;

  @override
  Override overrideWith(
    FutureOr<void> Function(SaveUserRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: SaveUserProvider._internal(
        (ref) => create(ref as SaveUserRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        currentUser: currentUser,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<void> createElement() {
    return _SaveUserProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SaveUserProvider && other.currentUser == currentUser;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, currentUser.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin SaveUserRef on AutoDisposeFutureProviderRef<void> {
  /// The parameter `currentUser` of this provider.
  List<String> get currentUser;
}

class _SaveUserProviderElement extends AutoDisposeFutureProviderElement<void>
    with SaveUserRef {
  _SaveUserProviderElement(super.provider);

  @override
  List<String> get currentUser => (origin as SaveUserProvider).currentUser;
}

String _$getUserHash() => r'9bbc0e4f3de3aeb549db60eb88109cf81a987c76';

/// See also [getUser].
@ProviderFor(getUser)
final getUserProvider = AutoDisposeProvider<String>.internal(
  getUser,
  name: r'getUserProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$getUserHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef GetUserRef = AutoDisposeProviderRef<String>;
String _$removeUserHash() => r'a2b59569f40d6f47bd5b0471ca3d7055a67ac2fa';

/// See also [removeUser].
@ProviderFor(removeUser)
final removeUserProvider = AutoDisposeFutureProvider<bool>.internal(
  removeUser,
  name: r'removeUserProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$removeUserHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef RemoveUserRef = AutoDisposeFutureProviderRef<bool>;
String _$clearUserHash() => r'1e55015c5ea6c07016cecf72261e534646bfa38c';

/// See also [clearUser].
@ProviderFor(clearUser)
final clearUserProvider = AutoDisposeFutureProvider<void>.internal(
  clearUser,
  name: r'clearUserProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$clearUserHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef ClearUserRef = AutoDisposeFutureProviderRef<void>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
