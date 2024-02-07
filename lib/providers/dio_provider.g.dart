// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$dioHash() => r'1e868cbdb649355ab0880fcbcfa82126d51b7592';

/// See also [dio].
@ProviderFor(dio)
final dioProvider = AutoDisposeProvider<Dio>.internal(
  dio,
  name: r'dioProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$dioHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef DioRef = AutoDisposeProviderRef<Dio>;
String _$templatesHash() => r'd1b3f9841d7bbeaa067c265bf0f35dbf6b5e83ee';

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

/// See also [templates].
@ProviderFor(templates)
const templatesProvider = TemplatesFamily();

/// See also [templates].
class TemplatesFamily extends Family<AsyncValue<TemplateResponse>> {
  /// See also [templates].
  const TemplatesFamily();

  /// See also [templates].
  TemplatesProvider call(
    AccessToken token,
  ) {
    return TemplatesProvider(
      token,
    );
  }

  @override
  TemplatesProvider getProviderOverride(
    covariant TemplatesProvider provider,
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
  String? get name => r'templatesProvider';
}

/// See also [templates].
class TemplatesProvider extends AutoDisposeFutureProvider<TemplateResponse> {
  /// See also [templates].
  TemplatesProvider(
    AccessToken token,
  ) : this._internal(
          (ref) => templates(
            ref as TemplatesRef,
            token,
          ),
          from: templatesProvider,
          name: r'templatesProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$templatesHash,
          dependencies: TemplatesFamily._dependencies,
          allTransitiveDependencies: TemplatesFamily._allTransitiveDependencies,
          token: token,
        );

  TemplatesProvider._internal(
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
  Override overrideWith(
    FutureOr<TemplateResponse> Function(TemplatesRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: TemplatesProvider._internal(
        (ref) => create(ref as TemplatesRef),
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
  AutoDisposeFutureProviderElement<TemplateResponse> createElement() {
    return _TemplatesProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is TemplatesProvider && other.token == token;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, token.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin TemplatesRef on AutoDisposeFutureProviderRef<TemplateResponse> {
  /// The parameter `token` of this provider.
  AccessToken get token;
}

class _TemplatesProviderElement
    extends AutoDisposeFutureProviderElement<TemplateResponse>
    with TemplatesRef {
  _TemplatesProviderElement(super.provider);

  @override
  AccessToken get token => (origin as TemplatesProvider).token;
}

String _$dashboardHash() => r'0b286e08adc5fd037ad834e0ab5813a8752db4c2';

/// See also [dashboard].
@ProviderFor(dashboard)
const dashboardProvider = DashboardFamily();

/// See also [dashboard].
class DashboardFamily extends Family<AsyncValue<dynamic>> {
  /// See also [dashboard].
  const DashboardFamily();

  /// See also [dashboard].
  DashboardProvider call(
    AccessToken token,
  ) {
    return DashboardProvider(
      token,
    );
  }

  @override
  DashboardProvider getProviderOverride(
    covariant DashboardProvider provider,
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
  String? get name => r'dashboardProvider';
}

/// See also [dashboard].
class DashboardProvider extends AutoDisposeFutureProvider<dynamic> {
  /// See also [dashboard].
  DashboardProvider(
    AccessToken token,
  ) : this._internal(
          (ref) => dashboard(
            ref as DashboardRef,
            token,
          ),
          from: dashboardProvider,
          name: r'dashboardProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$dashboardHash,
          dependencies: DashboardFamily._dependencies,
          allTransitiveDependencies: DashboardFamily._allTransitiveDependencies,
          token: token,
        );

  DashboardProvider._internal(
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
  Override overrideWith(
    FutureOr<dynamic> Function(DashboardRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: DashboardProvider._internal(
        (ref) => create(ref as DashboardRef),
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
  AutoDisposeFutureProviderElement<dynamic> createElement() {
    return _DashboardProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is DashboardProvider && other.token == token;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, token.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin DashboardRef on AutoDisposeFutureProviderRef<dynamic> {
  /// The parameter `token` of this provider.
  AccessToken get token;
}

class _DashboardProviderElement
    extends AutoDisposeFutureProviderElement<dynamic> with DashboardRef {
  _DashboardProviderElement(super.provider);

  @override
  AccessToken get token => (origin as DashboardProvider).token;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
