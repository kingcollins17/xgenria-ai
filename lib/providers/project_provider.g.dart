// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$projectNotifierHash() => r'988cc2025239513799c254934ab96b42b3e03bc2';

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

abstract class _$ProjectNotifier
    extends BuildlessAsyncNotifier<FetchProjectResponse> {
  late final AccessToken token;

  FutureOr<FetchProjectResponse> build(
    AccessToken token,
  );
}

/// See also [ProjectNotifier].
@ProviderFor(ProjectNotifier)
const projectNotifierProvider = ProjectNotifierFamily();

/// See also [ProjectNotifier].
class ProjectNotifierFamily extends Family<AsyncValue<FetchProjectResponse>> {
  /// See also [ProjectNotifier].
  const ProjectNotifierFamily();

  /// See also [ProjectNotifier].
  ProjectNotifierProvider call(
    AccessToken token,
  ) {
    return ProjectNotifierProvider(
      token,
    );
  }

  @override
  ProjectNotifierProvider getProviderOverride(
    covariant ProjectNotifierProvider provider,
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
  String? get name => r'projectNotifierProvider';
}

/// See also [ProjectNotifier].
class ProjectNotifierProvider
    extends AsyncNotifierProviderImpl<ProjectNotifier, FetchProjectResponse> {
  /// See also [ProjectNotifier].
  ProjectNotifierProvider(
    AccessToken token,
  ) : this._internal(
          () => ProjectNotifier()..token = token,
          from: projectNotifierProvider,
          name: r'projectNotifierProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$projectNotifierHash,
          dependencies: ProjectNotifierFamily._dependencies,
          allTransitiveDependencies:
              ProjectNotifierFamily._allTransitiveDependencies,
          token: token,
        );

  ProjectNotifierProvider._internal(
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
  FutureOr<FetchProjectResponse> runNotifierBuild(
    covariant ProjectNotifier notifier,
  ) {
    return notifier.build(
      token,
    );
  }

  @override
  Override overrideWith(ProjectNotifier Function() create) {
    return ProviderOverride(
      origin: this,
      override: ProjectNotifierProvider._internal(
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
  AsyncNotifierProviderElement<ProjectNotifier, FetchProjectResponse>
      createElement() {
    return _ProjectNotifierProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ProjectNotifierProvider && other.token == token;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, token.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin ProjectNotifierRef on AsyncNotifierProviderRef<FetchProjectResponse> {
  /// The parameter `token` of this provider.
  AccessToken get token;
}

class _ProjectNotifierProviderElement
    extends AsyncNotifierProviderElement<ProjectNotifier, FetchProjectResponse>
    with ProjectNotifierRef {
  _ProjectNotifierProviderElement(super.provider);

  @override
  AccessToken get token => (origin as ProjectNotifierProvider).token;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
