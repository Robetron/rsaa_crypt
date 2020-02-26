library rsaa_crypt;

import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:logger/logger.dart';

import 'constants.dart';
import 'rsaa.dart';

class RSAACrypt {
  static final Util util = Util();
  static final RSAA rsaa = RSAA();
  List<List<int>> ruleBox = List.generate(NUM_RULES, (i) => List(NUM_RULES));

  Future<List<int>> encryptText(String key, String inputText) async {
    rsaa.ruleGen(key); // Generate rules
    Uint8List bytes = util.textToBytes(inputText); // Read Text as bytes
    List<String> hexInput =
        util.bytesToHexList(bytes); // Convert bytes to Hex List
    rsaa.encryptRSAA(hexInput); // Perform RSAA Decryption

    return util.hexListToBytes(hexInput); // Convert Hex to bytes and return
  }

  Future<String> decryptText(String key, Uint8List bytes) async {
    rsaa.ruleGen(key); // Generate rules
    List<String> hexInput =
        util.bytesToHexList(bytes); // Convert bytes to Hex List
    rsaa.decryptRSAA(hexInput); // Perform RSAA Decryption

    return util.bytesToText(
        util.hexListToBytes(hexInput)); // Convert Hex to bytes and return
  }

  Future<List<int>> encryptFile(String key, File inputFile) async {
    Uint8List bytes = util.readFile(inputFile); // Read File as bytes

    return await decryptBytes(key, bytes); // Convert Hex to bytes and return
  }

  Future<List<int>> decryptFile(String key, File inputFile) async {
    Uint8List bytes = util.readFile(inputFile); // Read File as bytes

    return await encryptBytes(key, bytes);
  }

  Future<List<int>> encryptBytes(String key, Uint8List bytes) async {
    rsaa.ruleGen(key); // Generate Cellular Automata Rules

    List<String> hexInput =
        util.bytesToHexList(bytes); // Convert bytes to Hex List
    rsaa.encryptRSAA(hexInput); // Perform RSAA Decryption

    return util.hexListToBytes(hexInput); // Convert Hex to bytes and return
  }

  Future<List<int>> decryptBytes(String key, Uint8List bytes) async {
    rsaa.ruleGen(key); // Generate Cellular Automata Rules

    List<String> hexInput =
        util.bytesToHexList(bytes); // Convert bytes to Hex List
    rsaa.decryptRSAA(hexInput); // Perform RSAA Decryption

    return util.hexListToBytes(hexInput); // Convert Hex to bytes and return
  }
}

class Util {
  int hexToInt(String hex) {
    switch (hex) {
      case 'a':
      case 'A':
      case '0a':
      case '0A':
        return 10;
      case 'b':
      case 'B':
      case '0b':
      case '0B':
        return 11;
      case 'c':
      case 'C':
      case '0c':
      case '0C':
        return 12;
      case 'd':
      case 'D':
      case '0d':
      case '0D':
        return 13;
      case 'e':
      case 'E':
      case '0e':
      case '0E':
        return 14;
      case 'f':
      case 'F':
      case '0f':
      case '0F':
        return 15;
      default:
        return int.parse(hex, radix: 10);
    }
  }

  Uint8List textToBytes(String sourceText) {
    var byteList = List<int>();
    sourceText.runes.forEach((rune) {
      if (rune >= 0x10000) {
        rune -= 0x10000;
        int firstWord = (rune >> 10) + 0xD800;
        byteList.add(firstWord >> 8);
        byteList.add(firstWord & 0xFF);
        int secondWord = (rune & 0x3FF) + 0xDC00;
        byteList.add(secondWord >> 8);
        byteList.add(secondWord & 0xFF);
      } else {
        byteList.add(rune >> 8);
        byteList.add(rune & 0xFF);
      }
    });
    return Uint8List.fromList(byteList);
  }

  String bytesToText(Uint8List sourceBytes) {
    StringBuffer stringBuffer = StringBuffer();
    for (int i = 0; i < sourceBytes.length;) {
      int firstWord = (sourceBytes[i] << 8) + sourceBytes[i + 1];
      if (0xD800 <= firstWord && firstWord <= 0xDBFF) {
        int secondWord = (sourceBytes[i + 2] << 8) + sourceBytes[i + 3];
        stringBuffer.writeCharCode(
            ((firstWord - 0xD800) << 10) + (secondWord - 0xDC00) + 0x10000);
        i += 4;
      } else {
        stringBuffer.writeCharCode(firstWord);
        i += 2;
      }
    }
    return stringBuffer.toString();
  }

  void getFileSize(Uint8List bytes) {
    Logger log = Logger();
    int fileSize = 0, fileLength = bytes.length;
    if (fileLength >= 1000000000) {
      fileSize = fileLength ~/ 1000000000;
      log.d('File Size: $fileSize GB');
    } else if (fileLength >= 1000000) {
      fileSize = fileLength ~/ 1000000;
      log.d('File Size: $fileSize MB');
    } else if (fileLength >= 1000) {
      fileSize = fileLength ~/ 1000;
      log.d('File Size: $fileSize KB');
    } else {
      log.d('File Size: $fileSize B');
    }
  }

  Uint8List readFile(File file) {
    return file.readAsBytesSync();
  }

  Future<File> writeFile(String outputPath, List<int> bytes) {
    return File(outputPath).writeAsBytes(bytes);
  }

  List<String> bytesToHexList(Uint8List bytes) {
    String temp;
    List<String> tempList = List<String>();
    for (var byte in bytes) {
      temp = byte.toRadixString(16);
      if (temp.length == 1)
        tempList.add("0" + temp);
      else
        tempList.add(temp);
    }
    return tempList;
  }

  Uint8List hexListToBytes(List<String> hexList) {
    List<int> tempList = List<int>();
    for (var hex in hexList) {
      tempList.add(int.parse(hex, radix: 16));
    }
    return Uint8List.fromList(tempList);
  }

  String bytesToBase64(List<int> bytes) {
    return Base64Codec().encode(bytes);
  }

  Uint8List base64ToBytes(String encoded) {
    return Base64Codec().decode(encoded);
  }
}
