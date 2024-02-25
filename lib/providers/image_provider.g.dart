// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$imagesHash() => r'4dafc7401016a3a07c7245f4de590f8d71f25ff4';

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

/// See also [images].
@ProviderFor(images)
const imagesProvider = ImagesFamily();

/// See also [images].
class ImagesFamily extends Family<AsyncValue<List<ImageData>?>> {
  /// See also [images].
  const ImagesFamily();

  /// See also [images].
  ImagesProvider call(
    AccessToken token,
  ) {
    return ImagesProvider(
      token,
    );
  }

  @override
  ImagesProvider getProviderOverride(
    covariant ImagesProvider provider,
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
  String? get name => r'imagesProvider';
}

/// See also [images].
class ImagesProvider extends FutureProvider<List<ImageData>?> {
  /// See also [images].
  ImagesProvider(
    AccessToken token,
  ) : this._internal(
          (ref) => images(
            ref as ImagesRef,
            token,
          ),
          from: imagesProvider,
          name: r'imagesProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$imagesHash,
          dependencies: ImagesFamily._dependencies,
          allTransitiveDependencies: ImagesFamily._allTransitiveDependencies,
          token: token,
        );

  ImagesProvider._internal(
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
    FutureOr<List<ImageData>?> Function(ImagesRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ImagesProvider._internal(
        (ref) => create(ref as ImagesRef),
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
  FutureProviderElement<List<ImageData>?> createElement() {
    return _ImagesProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ImagesProvider && other.token == token;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, token.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin ImagesRef on FutureProviderRef<List<ImageData>?> {
  /// The parameter `token` of this provider.
  AccessToken get token;
}

class _ImagesProviderElement extends FutureProviderElement<List<ImageData>?>
    with ImagesRef {
  _ImagesProviderElement(super.provider);

  @override
  AccessToken get token => (origin as ImagesProvider).token;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
