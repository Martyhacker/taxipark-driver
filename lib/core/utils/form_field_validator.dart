class CustomFormFieldValidator {
  String? isNotEmpty(String? data) {
    return (data?.isNotEmpty ?? false) ? null : 'Не может быть пустым!';
  }

  String? phoneValidator(String? data) {
    if (data?.isNotEmpty ?? false) {
      if (data!.length < 8) {
        return 'Входить полностью!';
      } else {
        return null;
      }
    } else {
      return 'Не может быть пустым!';
    }
  }
}
