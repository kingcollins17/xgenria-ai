// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$dioHash() => r'ad6138cb4b5c2559f32ef206fbb548c604f7950b';

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
String _$templatesHash() => r'33bda8bb0ad7581d6575cd8f3d7cda49a6b03197';

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
class TemplatesProvider extends FutureProvider<TemplateResponse> {
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
  FutureProviderElement<TemplateResponse> createElement() {
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

mixin TemplatesRef on FutureProviderRef<TemplateResponse> {
  /// The parameter `token` of this provider.
  AccessToken get token;
}

class _TemplatesProviderElement extends FutureProviderElement<TemplateResponse>
    with TemplatesRef {
  _TemplatesProviderElement(super.provider);

  @override
  AccessToken get token => (origin as TemplatesProvider).token;
}

String _$dashboardHash() => r'd46d42dbdbc7cf1b7efa92334765092c26430deb';

/// See also [dashboard].
@ProviderFor(dashboard)
const dashboardProvider = DashboardFamily();

/// See also [dashboard].
class DashboardFamily extends Family<AsyncValue<DashboardResponse>> {
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
class DashboardProvider extends FutureProvider<DashboardResponse> {
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
    FutureOr<DashboardResponse> Function(DashboardRef provider) create,
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
  FutureProviderElement<DashboardResponse> createElement() {
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

mixin DashboardRef on FutureProviderRef<DashboardResponse> {
  /// The parameter `token` of this provider.
  AccessToken get token;
}

class _DashboardProviderElement extends FutureProviderElement<DashboardResponse>
    with DashboardRef {
  _DashboardProviderElement(super.provider);

  @override
  AccessToken get token => (origin as DashboardProvider).token;
}

String _$userHash() => r'87a406725ad42c58f3537c35b8e770ee2837d6f6';

/// See also [user].
@ProviderFor(user)
const userProvider = UserFamily();

/// See also [user].
class UserFamily extends Family<
    AsyncValue<({UserData? data, String message, bool status})>> {
  /// See also [user].
  const UserFamily();

  /// See also [user].
  UserProvider call(
    AccessToken token,
  ) {
    return UserProvider(
      token,
    );
  }

  @override
  UserProvider getProviderOverride(
    covariant UserProvider provider,
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
  String? get name => r'userProvider';
}

/// See also [user].
class UserProvider
    extends FutureProvider<({UserData? data, String message, bool status})> {
  /// See also [user].
  UserProvider(
    AccessToken token,
  ) : this._internal(
          (ref) => user(
            ref as UserRef,
            token,
          ),
          from: userProvider,
          name: r'userProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product') ? null : _$userHash,
          dependencies: UserFamily._dependencies,
          allTransitiveDependencies: UserFamily._allTransitiveDependencies,
          token: token,
        );

  UserProvider._internal(
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
    FutureOr<({UserData? data, String message, bool status})> Function(
            UserRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: UserProvider._internal(
        (ref) => create(ref as UserRef),
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
  FutureProviderElement<({UserData? data, String message, bool status})>
      createElement() {
    return _UserProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is UserProvider && other.token == token;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, token.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin UserRef
    on FutureProviderRef<({UserData? data, String message, bool status})> {
  /// The parameter `token` of this provider.
  AccessToken get token;
}

class _UserProviderElement extends FutureProviderElement<
    ({UserData? data, String message, bool status})> with UserRef {
  _UserProviderElement(super.provider);

  @override
  AccessToken get token => (origin as UserProvider).token;
}

String _$planHash() => r'b441d20fc6e807e8a5700e130d2b5da585fe88fc';

/// See also [plan].
@ProviderFor(plan)
const planProvider = PlanFamily();

/// See also [plan].
class PlanFamily extends Family<
    AsyncValue<({List<PlanData>? data, String message, bool status})>> {
  /// See also [plan].
  const PlanFamily();

  /// See also [plan].
  PlanProvider call(
    AccessToken token,
  ) {
    return PlanProvider(
      token,
    );
  }

  @override
  PlanProvider getProviderOverride(
    covariant PlanProvider provider,
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
  String? get name => r'planProvider';
}

/// See also [plan].
class PlanProvider extends FutureProvider<
    ({List<PlanData>? data, String message, bool status})> {
  /// See also [plan].
  PlanProvider(
    AccessToken token,
  ) : this._internal(
          (ref) => plan(
            ref as PlanRef,
            token,
          ),
          from: planProvider,
          name: r'planProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product') ? null : _$planHash,
          dependencies: PlanFamily._dependencies,
          allTransitiveDependencies: PlanFamily._allTransitiveDependencies,
          token: token,
        );

  PlanProvider._internal(
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
    FutureOr<({List<PlanData>? data, String message, bool status})> Function(
            PlanRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: PlanProvider._internal(
        (ref) => create(ref as PlanRef),
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
  FutureProviderElement<({List<PlanData>? data, String message, bool status})>
      createElement() {
    return _PlanProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is PlanProvider && other.token == token;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, token.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin PlanRef on FutureProviderRef<
    ({List<PlanData>? data, String message, bool status})> {
  /// The parameter `token` of this provider.
  AccessToken get token;
}

class _PlanProviderElement extends FutureProviderElement<
    ({List<PlanData>? data, String message, bool status})> with PlanRef {
  _PlanProviderElement(super.provider);

  @override
  AccessToken get token => (origin as PlanProvider).token;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
