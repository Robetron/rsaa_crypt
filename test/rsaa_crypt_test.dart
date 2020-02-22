import 'package:flutter_test/flutter_test.dart';
import 'package:rsaa_crypt/rsaa_crypt.dart';

void main() {
  group('Text Encryption and Decryption', () {
    test('values should match', () {
      String message = 'Hello! Cześć! 🐻🎌 你好! ご挨拶！Привет! ℌ𝔢𝔩𝔩𝔬!';
      String key = '🐻🎌';

      print('Key: $key');
      print('Message Text: $message');
      String cipher = RSAACrypt().encryptText(key, message);
      print('Cipher Text: $cipher');
      String output = RSAACrypt().decryptText(key, cipher);
      print('Decrypted Text: $message');
      expect(message, output);
    });
  });
}
