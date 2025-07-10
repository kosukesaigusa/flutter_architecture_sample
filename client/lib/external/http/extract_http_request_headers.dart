import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'extract_http_request_headers.g.dart';

/// リクエストヘッダを生成する関数を提供する。
///
/// 実際のアプリやユニットテストなどの動作環境によって適切な `ProviderScope` でオーバーライド
/// して使用される。
@riverpod
Future<Map<String, String>> Function() extractHttpRequestHeaders(Ref ref) =>
    throw UnimplementedError();
