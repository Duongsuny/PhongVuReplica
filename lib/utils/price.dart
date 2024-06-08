class PriceUtils {
  static String formatPrice(String amount) {
    StringBuffer formatted = StringBuffer();
    int length = amount.length;

    for (int i = 0; i < length; i++) {
      if (i > 0 && i % 3 == 0) {
        formatted.write('.');
      }
      formatted.write(amount[length - 1 - i]);
    }
    return formatted.toString().split('').reversed.join('');
  }
}
