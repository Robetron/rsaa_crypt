library rsaa_crypt;

import 'dart:io';
import 'dart:typed_data';

import 'constants.dart';
import 'rsaa.dart';
import 'util.dart';

class RSAACrypt {
  static final Util util = Util();
  static final RSAA rsaa = RSAA();
  List<List<int>> ruleBox = List.generate(NUM_RULES, (i) => List(NUM_RULES));

  String encryptText(String key, String inputText) {
    rsaa.ruleGen(key); // Generate rules
    Uint8List bytes = util.textToBytes(inputText); // Read Text as bytes
    List<String> hexInput =
        util.bytesToHexList(bytes); // Convert bytes to Hex List
    rsaa.encryptRSAA(hexInput); // Perform RSAA Decryption
    return util
        .bytesToText(util.hexListToBytes(hexInput)); // Write Text from bytes
  }

  String decryptText(String key, String inputText) {
    rsaa.ruleGen(key); // Generate rules
    Uint8List bytes = util.textToBytes(inputText); // Read Text as bytes
    List<String> hexInput =
        util.bytesToHexList(bytes); // Convert bytes to Hex List
    rsaa.decryptRSAA(hexInput); // Perform RSAA Decryption
    return util
        .bytesToText(util.hexListToBytes(hexInput)); // Write Text from bytes
  }

  void encryptFile(String key, String inputPath, String outputPath) {
    List<int> byteOutput = List<int>();

    rsaa.ruleGen(key); // Generate Cellular Automata Rules
    Uint8List bytes = util.readFile(inputPath); // Read File as bytes

    List<String> hexInput =
        util.bytesToHexList(bytes); // Convert bytes to Hex List
    rsaa.encryptRSAA(hexInput); // Perform RSAA Decryption
    byteOutput = util.hexListToBytes(hexInput); // Convert Hex List to bytes

    File(outputPath).writeAsBytes(byteOutput).then((bytes) {}); // Write File
  }

  void decryptFile(String key, String inputPath, String outputPath) {
    List<int> byteOutput = List<int>();

    rsaa.ruleGen(key); // Generate Cellular Automata Rules
    Uint8List bytes = util.readFile(inputPath); // Read File as bytes
    List<String> hexInput =
        util.bytesToHexList(bytes); // Convert bytes to Hex List
    rsaa.decryptRSAA(hexInput); // Perform RSAA Decryption
    byteOutput = util.hexListToBytes(hexInput); // Convert Hex List to bytes

    File(outputPath).writeAsBytes(byteOutput).then((bytes) {}); // Write File
  }
}
