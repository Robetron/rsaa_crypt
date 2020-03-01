## Example 

```dart

import 'package:rsaa_crypt/rsaa_crypt.dart';

String key = '🐻🎌',
        message = 'Hello! Cześć! 🐻🎌 你好! ご挨拶！Привет! ℌ𝔢𝔩𝔩𝔬!',
        cipher,
        decipher;

// Text Encryption (Text Cipher)
RSAACrypt().encryptText(key, message).then((value) {
        cipher = Util().bytesToText(value);
      });
      
// Text Decryption (Text Cipher)
RSAACrypt().decryptText(key, Util().textToBytes(cipher)).then((value) {
        decipher = value;
      });
      
// Text Encryption (Base64 Cipher)
RSAACrypt().encryptText(key, message).then((value) {
        cipher = Util().bytesToBase64(value);
      });
      
// Text Decryption (Base64 Cipher)
RSAACrypt().decryptText(key, Util().base64ToBytes(cipher)).then((value) {
        decipher = value;
      });

// File Encryption
RSAACrypt().encryptFile(key, File(inputFilePath)).then((value) {
        Util().writeFile(encryptedFilePath, value);
      });

// File Decryption
RSAACrypt().decryptFile(key, File(encryptedFilePath)).then((value) {
        Util().writeFile(decryptedFilePath, value);
      });

```
