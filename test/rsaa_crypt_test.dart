import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:logger/logger.dart';
import 'package:rsaa_crypt/rsaa_crypt.dart';

void main() {
  final Logger log = Logger();

  group('text', () {
    String key = '🐻🎌';
    String message = 'Hello! Cześć! 🐻🎌 你好! ご挨拶！Привет! ℌ𝔢𝔩𝔩𝔬!';
    String cipher;
    String decipher;

    test('encrypt', () {
      cipher = RSAACrypt().encryptText(key, message);
      log.i('Cipher Text: $cipher');
    });

    test('decrypt', () {
      decipher = RSAACrypt().decryptText(key, cipher);
      log.i('Deciphered Text: $decipher');
    });

    test('compare', () {
      expect(message, decipher);
    });
  });

  group('file', () {
    String key = '🐻🎌';
    String inputFilePath = 'assets/file-original.svg';
    String encryptedFilePath = 'assets/file-encrypted.svg';
    String decryptedFilePath = 'assets/file-decrypted.svg';

    test('encrypt', () {
      RSAACrypt().encryptFile(key, File(inputFilePath), encryptedFilePath);
    });

    test('decrypt', () {
      RSAACrypt().decryptFile(key, File(encryptedFilePath), decryptedFilePath);
    });

    test('compare', () {
      expect(File(inputFilePath).readAsBytesSync(),
          File(decryptedFilePath).readAsBytesSync());
    });
  });
}
