RegExp validPassword = new RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#\$%\^&\*]).{8,24}$');

bool validatePassword(String password) {
  return validPassword.hasMatch(password);
}
