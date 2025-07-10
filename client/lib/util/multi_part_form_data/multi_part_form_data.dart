import 'dart:typed_data';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'multi_part_form_data.freezed.dart';

/// `Content-Type:multipart/form-data` 形式のリクエストのデータ。
///
/// dio パッケージにはこれを取り扱うための `FormData` クラスが存在するが、利用するパッケージが
/// 直接 dio パッケージに依存しないようにこのクラスを定義・公開している。
@freezed
class MultiPartRequestData with _$MultiPartRequestData {
  /// マップからフォームリクエストのデータを生成する。
  const factory MultiPartRequestData.fromMap(Map<String, dynamic> data) =
      _MultiPartRequestData;
}

/// `Content-Type:multipart/form-data` 形式のリクエストで用いられるマルチパートファイル。
///
/// dio パッケージにも同名の `MultiPartFile` クラスが存在するが、利用するパッケージが
/// 直接 dio パッケージに依存しないようにこのクラスを定義・公開している。
@freezed
class MultiPartFile with _$MultiPartFile {
  /// バイトデータからマルチパートファイルを生成する。
  const factory MultiPartFile.fromBytes({
    required Uint8List bytes,
    required MultiPartFileSupportedExtension extension,
    String? fileName,
  }) = _MultiPartFile;
}

/// マルチパートファイルでサポートされている拡張子。
enum MultiPartFileSupportedExtension {
  /// JPEG.
  jpeg,
}
