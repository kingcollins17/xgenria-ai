// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$chatNotifierHash() => r'3f096c67f590ef0b0127e1179b828e1801402499';

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

abstract class _$ChatNotifier
    extends BuildlessAsyncNotifier<FetchChatResponse> {
  late final AccessToken token;

  FutureOr<FetchChatResponse> build(
    AccessToken token,
  );
}

/// See also [ChatNotifier].
@ProviderFor(ChatNotifier)
const chatNotifierProvider = ChatNotifierFamily();

/// See also [ChatNotifier].
class ChatNotifierFamily extends Family<AsyncValue<FetchChatResponse>> {
  /// See also [ChatNotifier].
  const ChatNotifierFamily();

  /// See also [ChatNotifier].
  ChatNotifierProvider call(
    AccessToken token,
  ) {
    return ChatNotifierProvider(
      token,
    );
  }

  @override
  ChatNotifierProvider getProviderOverride(
    covariant ChatNotifierProvider provider,
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
  String? get name => r'chatNotifierProvider';
}

/// See also [ChatNotifier].
class ChatNotifierProvider
    extends AsyncNotifierProviderImpl<ChatNotifier, FetchChatResponse> {
  /// See also [ChatNotifier].
  ChatNotifierProvider(
    AccessToken token,
  ) : this._internal(
          () => ChatNotifier()..token = token,
          from: chatNotifierProvider,
          name: r'chatNotifierProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$chatNotifierHash,
          dependencies: ChatNotifierFamily._dependencies,
          allTransitiveDependencies:
              ChatNotifierFamily._allTransitiveDependencies,
          token: token,
        );

  ChatNotifierProvider._internal(
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
  FutureOr<FetchChatResponse> runNotifierBuild(
    covariant ChatNotifier notifier,
  ) {
    return notifier.build(
      token,
    );
  }

  @override
  Override overrideWith(ChatNotifier Function() create) {
    return ProviderOverride(
      origin: this,
      override: ChatNotifierProvider._internal(
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
  AsyncNotifierProviderElement<ChatNotifier, FetchChatResponse>
      createElement() {
    return _ChatNotifierProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ChatNotifierProvider && other.token == token;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, token.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin ChatNotifierRef on AsyncNotifierProviderRef<FetchChatResponse> {
  /// The parameter `token` of this provider.
  AccessToken get token;
}

class _ChatNotifierProviderElement
    extends AsyncNotifierProviderElement<ChatNotifier, FetchChatResponse>
    with ChatNotifierRef {
  _ChatNotifierProviderElement(super.provider);

  @override
  AccessToken get token => (origin as ChatNotifierProvider).token;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
