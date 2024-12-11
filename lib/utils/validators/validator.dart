class Validator {
  Validator._();

  bool isEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  bool isValidPassword(String password) {
    return password.length >= 8 &&
        password.contains(RegExp(r'[a-z]')) &&
        password.contains(RegExp(r'[A-Z]')) &&
        password.contains(RegExp(r'\d')) &&
        password.contains(RegExp(r'[!@#$%^&*()]'));
  }

  bool isValidName(String name) {
    return name.length >= 3 && name.contains(RegExp(r'[a-zA-Z]'));
  }

  static bool isEmailEmpty(String email) => email.trim().isEmpty;
  static bool isPasswordEmpty(String password) => password.trim().isEmpty;
  static bool isNameEmpty(String name) => name.trim().isEmpty;
}
