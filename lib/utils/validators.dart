String? validateRequiredField(value) {
  if (value == null || value.isEmpty || (value as String).trim().isEmpty) {
    return 'Este campo é obrigatório';
  }
  return null;
}

String? validateRequiredPhone(value) {
  String? validatedRequired = validateRequiredField(value);

  if (validatedRequired == null) {
    String phone = value as String;
    if (phone.length != 9 || !phone.startsWith('8')) {
      return 'Número de telefone inválido';
    }
  }
  return validatedRequired;
}

String? validateRequiredEmail(value) {
  String? validatedRequired = validateRequiredField(value);

  if (validatedRequired == null) {
    String email = value as String;

    bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);

    if (!emailValid) {
      return 'E-mail inválido';
    }
  }
  return validatedRequired;
}
