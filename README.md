# RSAA Crypt

Flutter plugin to use RSAA 1024 bit symmetric file and text on-device encryption in your app.

## Features

- 1024 bit secure symmetric encryption
- Supports all types of files for for File Encyption. 
- Supports Text and Base64 ciphers for Text Encryption.
- No change in encrypted files or Text size (in bytes using Text Mode).

### Installing

A step by step series of examples that tell you how to get a development env running

1. **Depend on it**

Add this to your package's pubspec.yaml file:

```
dependencies:
  rsaa_crypt: ^0.0.1
```

2. **Install it**

You can install packages from the command line with Flutter.

```
$ flutter pub get
```

3. **Import it**

Now in your Dart code, you can use:

```
import 'package:rsaa_crypt/rsaa_crypt.dart';
```

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

## Contributing

Contributions will be acceptied at a later time.

## Authors

* **Vishal Robertson** - *Initial work* - [Robetron](https://github.com/Robetron)

See also the list of [contributors](https://github.com/Robetron/rsaa_crypt/contributors) who participated in this project.

## License

This project is licensed under the Apache License 2.0 - see the [LICENSE.md](LICENSE.md) file for details
