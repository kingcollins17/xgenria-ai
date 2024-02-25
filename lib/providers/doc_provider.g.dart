// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'doc_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$docNotifierHash() => r'b82959d0396a936a04553038f9c7d9a8db4a3a9b';

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

abstract class _$DocNotifier extends BuildlessAsyncNotifier<DocumentData?> {
  late final AccessToken token;

  FutureOr<DocumentData?> build(
    AccessToken token,
  );
}

/// See also [DocNotifier].
@ProviderFor(DocNotifier)
const docNotifierProvider = DocNotifierFamily();

/// See also [DocNotifier].
class DocNotifierFamily extends Family<AsyncValue<DocumentData?>> {
  /// See also [DocNotifier].
  const DocNotifierFamily();

  /// See also [DocNotifier].
  DocNotifierProvider call(
    AccessToken token,
  ) {
    return DocNotifierProvider(
      token,
    );
  }

  @override
  DocNotifierProvider getProviderOverride(
    covariant DocNotifierProvider provider,
  ) {
    return call(
      provider.token,
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
  String? get name => r'docNotifierProvider';
}

/// See also [DocNotifier].
class DocNotifierProvider
    extends AsyncNotifierProviderImpl<DocNotifier, DocumentData?> {
  /// See also [DocNotifier].
  DocNotifierProvider(
    AccessToken token,
  ) : this._internal(
          () => DocNotifier()..token = token,
          from: docNotifierProvider,
          name: r'docNotifierProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$docNotifierHash,
          dependencies: DocNotifierFamily._dependencies,
          allTransitiveDependencies:
              DocNotifierFamily._allTransitiveDependencies,
          token: token,
        );

  DocNotifierProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.token,
  }) : super.internal();

  final AccessToken token;

  @override
  FutureOr<DocumentData?> runNotifierBuild(
    covariant DocNotifier notifier,
  ) {
    return notifier.build(
      token,
    );
  }

  @override
  Override overrideWith(DocNotifier Function() create) {
    return ProviderOverride(
      origin: this,
      override: DocNotifierProvider._internal(
        () => create()..token = token,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        token: token,
      ),
    );
  }

  @override
  AsyncNotifierProviderElement<DocNotifier, DocumentData?> createElement() {
    return _DocNotifierProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is DocNotifierProvider && other.token == token;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, token.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin DocNotifierRef on AsyncNotifierProviderRef<DocumentData?> {
  /// The parameter `token` of this provider.
  AccessToken get token;
}

class _DocNotifierProviderElement
    extends AsyncNotifierProviderElement<DocNotifier, DocumentData?>
    with DocNotifierRef {
  _DocNotifierProviderElement(super.provider);

  @override
  AccessToken get token => (origin as DocNotifierProvider).token;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
