// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$isSignedInHash() => r'9af553ab8e606bfc8c3e41495719124f05316ae3';

/// サインインしているかどうかを取得する。
///
/// Copied from [isSignedIn].
@ProviderFor(isSignedIn)
final isSignedInProvider = AutoDisposeFutureProvider<bool>.internal(
  isSignedIn,
  name: r'isSignedInProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$isSignedInHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef IsSignedInRef = AutoDisposeFutureProviderRef<bool>;
String _$authNotifierHash() => r'5567b7b57b77859fdb281cda9df912d5068b096c';

/// 認証情報を管理する Notifier.
///
/// アプリの起動中はインスタンスを保持するために keepAlive: true を指定している。
///
/// Copied from [AuthNotifier].
@ProviderFor(AuthNotifier)
final authNotifierProvider =
    AsyncNotifierProvider<AuthNotifier, Auth?>.internal(
  AuthNotifier.new,
  name: r'authNotifierProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$authNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$AuthNotifier = AsyncNotifier<Auth?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
