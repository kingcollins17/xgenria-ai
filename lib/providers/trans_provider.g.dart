// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trans_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$transNotifierHash() => r'bb399775b76dcadbee2f31d3562c27c58422f669';

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

abstract class _$TransNotifier extends BuildlessAsyncNotifier<_Data> {
  late final AccessToken token;

  FutureOr<_Data> build(
    AccessToken token,
  );
}

/// See also [TransNotifier].
@ProviderFor(TransNotifier)
const transNotifierProvider = TransNotifierFamily();

/// See also [TransNotifier].
class TransNotifierFamily extends Family<AsyncValue<_Data>> {
  /// See also [TransNotifier].
  const TransNotifierFamily();

  /// See also [TransNotifier].
  TransNotifierProvider call(
    AccessToken token,
  ) {
    return TransNotifierProvider(
      token,
    );
  }

  @override
  TransNotifierProvider getProviderOverride(
    covariant TransNotifierProvider provider,
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
  String? get name => r'transNotifierProvider';
}

/// See also [TransNotifier].
class TransNotifierProvider
    extends AsyncNotifierProviderImpl<TransNotifier, _Data> {
  /// See also [TransNotifier].
  TransNotifierProvider(
    AccessToken token,
  ) : this._internal(
          () => TransNotifier()..token = token,
          from: transNotifierProvider,
          name: r'transNotifierProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$transNotifierHash,
          dependencies: TransNotifierFamily._dependencies,
          allTransitiveDependencies:
              TransNotifierFamily._allTransitiveDependencies,
          token: token,
        );

  TransNotifierProvider._internal(
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
  FutureOr<_Data> runNotifierBuild(
    covariant TransNotifier notifier,
  ) {
    return notifier.build(
      token,
    );
  }

  @override
  Override overrideWith(TransNotifier Function() create) {
    return ProviderOverride(
      origin: this,
      override: TransNotifierProvider._internal(
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
  AsyncNotifierProviderElement<TransNotifier, _Data> createElement() {
    return _TransNotifierProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is TransNotifierProvider && other.token == token;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, token.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin TransNotifierRef on AsyncNotifierProviderRef<_Data> {
  /// The parameter `token` of this provider.
  AccessToken get token;
}

class _TransNotifierProviderElement
    extends AsyncNotifierProviderElement<TransNotifier, _Data>
    with TransNotifierRef {
  _TransNotifierProviderElement(super.provider);

  @override
  AccessToken get token => (origin as TransNotifierProvider).token;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
