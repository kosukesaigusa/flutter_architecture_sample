import 'package:dio/dio.dart';

import '../../../../util/multi_part_form_data/multi_part_form_data.dart';

/// [MultiPartRequestData] 型の拡張クラス。
extension FormRequestDataExtension on MultiPartRequestData {
  /// 自作の [MultiPartRequestData] 型から dio の [FormData] 型に変換する。
  FormData toDioFormData() {
    return FormData.fromMap({
      for (final entry in data.entries)
        if (entry.value is MultiPartFile)
          entry.key: MultipartFile.fromBytes(
            (entry.value as MultiPartFile).bytes,
            filename: 'file.${(entry.value as MultiPartFile).extension.name}',
          )
        else
          entry.key: entry.value,
    });
  }
}
