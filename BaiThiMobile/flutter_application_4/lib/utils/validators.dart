class Validators {
  // Email validation
  static bool isValidEmail(String email) {
    return RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
        .hasMatch(email);
  }

  // Password validation - tối thiểu 8 ký tự, 1 hoa, 1 số, 1 ký tự đặc biệt
  static bool isValidPassword(String password) {
    return RegExp(
      r'^(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$',
    ).hasMatch(password);
  }

  static String getPasswordErrorMessage(String password) {
    if (password.isEmpty) return '';
    if (password.length < 8) return 'Tối thiểu 8 ký tự';
    if (!password.contains(RegExp(r'[A-Z]'))) return 'Phải có ít nhất 1 chữ hoa';
    if (!password.contains(RegExp(r'\d'))) return 'Phải có ít nhất 1 số';
    if (!password.contains(RegExp(r'[@\$!%*?&]'))) return 'Phải có ký tự đặc biệt';
    return '';
  }
}
