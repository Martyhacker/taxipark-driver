import 'package:easy_localization/easy_localization.dart';
import 'package:taxipark_driver/generated/locale_keys.g.dart';

class CustomFormFieldValidator {
  String? isNotEmpty(String? data) {
    return (data?.isNotEmpty ?? false) ? null : LocaleKeys.validator_empty.tr();
  }

  String? phoneValidator(String? data) {
    if (data?.isNotEmpty ?? false) {
      if (data!.length < 8) {
        return LocaleKeys.validator_length.tr();
      } else {
        return null;
      }
    } else {
      return LocaleKeys.validator_empty.tr();
    }
  }
}
