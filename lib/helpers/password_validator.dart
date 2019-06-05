class PasswordValidator {
  static RegExp validPassword = new RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#\$%\^&\*]).{8,24}$');

  static bool validate(String password) {
    return validPassword.hasMatch(password);
  }
}
