class AppValidators {
  static bool isValidEmail(String email) {
    return RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(email);
  }

  static bool isValidPhoneNumber(String phone) {
    return RegExp(r'^01[0125]\d{8}$').hasMatch(phone);
  }

  static bool isValidPassword(String inputPassword, String storedPassword ){
    return inputPassword == storedPassword;
  }
}