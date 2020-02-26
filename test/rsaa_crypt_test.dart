import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:logger/logger.dart';
import 'package:rsaa_crypt/rsaa_crypt.dart';

void main() {
  final Logger log = Logger();

  group('message-text', () {
    String key = '🐻🎌',
        message = 'Hello! Cześć! 🐻🎌 你好! ご挨拶！Привет! ℌ𝔢𝔩𝔩𝔬!',
        cipher,
        decipher;

    test('encrypt', () {
      RSAACrypt().encryptText(key, message).then((value) {
        cipher = Util().bytesToText(value);
      });
      log.d('Cipher Text: $cipher');
    });

    test('decrypt', () {
      RSAACrypt().decryptText(key, Util().textToBytes(cipher)).then((value) {
        decipher = value;
      });
      log.d('Deciphered Text: $decipher');
    });

    test('compare', () {
      expect(message, decipher);
    });
  });

  group('message-base64', () {
    String key = '🐻🎌',
        message = 'Hello! Cześć! 🐻🎌 你好! ご挨拶！Привет! ℌ𝔢𝔩𝔩𝔬!',
        cipher,
        decipher;

    test('encrypt', () {
      RSAACrypt().encryptText(key, message).then((value) {
        cipher = Util().bytesToBase64(value);
      });
      log.d('Cipher Text: $cipher');
    });

    test('decrypt', () {
      RSAACrypt().decryptText(key, Util().base64ToBytes(cipher)).then((value) {
        decipher = value;
      });
      log.d('Deciphered Text: $decipher');
    });

    test('compare', () {
      expect(message, decipher);
    });
  });

  group('file', () {
    String key = '🐻🎌',
        inputFilePath = 'assets/file-original.svg',
        encryptedFilePath = 'assets/file-encrypted.svg',
        decryptedFilePath = 'assets/file-decrypted.svg';

    test('encrypt', () {
      RSAACrypt().encryptFile(key, File(inputFilePath)).then((value) {
        Util().writeFile(encryptedFilePath, value);
      });
    });

    test('decrypt', () {
      RSAACrypt().decryptFile(key, File(encryptedFilePath)).then((value) {
        Util().writeFile(decryptedFilePath, value);
      });
    });

    test('compare', () {
      expect(File(inputFilePath).readAsBytesSync(),
          File(decryptedFilePath).readAsBytesSync());
    });
  });
}
