import 'dart:convert';

import 'package:basic_utils/basic_utils.dart';
import 'package:crypto/crypto.dart';

import 'constants.dart';
import 'util.dart';

class RSAA {
  static final Util util = Util();
  List<List<int>> ruleBox = List.generate(NUM_RULES, (i) => List(NUM_RULES));

  String _hashKey(String inputKey) {
    return sha512.convert(utf8.encode(inputKey)).toString() +
        sha512.convert(utf8.encode(StringUtils.reverse(inputKey))).toString();
  }

  void ruleGen(String inputKey) {
    List<List<num>> tempBox = List.generate(BOX_SIZE, (i) => List(BOX_SIZE));
    String key = _hashKey(inputKey);

    for (int i = 0, col = 0, row = 0; i < key.length; i++) {
      if (col == 16) {
        row++;
        col = 0;
      }
      tempBox[row][col++] = util.hexToInt(key[i]);
    }

    for (int line = 0; line < NUM_RULES; line++) {
      for (int pos = 0; pos < BOX_SIZE; pos++) {
        ruleBox[line][pos] = -1;
      }
    }

    for (int line = 0; line < NUM_RULES; line++) {
      int left = 0, right = 15;
      if (tempBox[line][left] == tempBox[line][right]) {
        ruleBox[line][tempBox[line][left]] = tempBox[line][left];
      } else {
        ruleBox[line][tempBox[line][right]] = tempBox[line][left];
        ruleBox[line][tempBox[line][left]] = tempBox[line][right];
      }
      while (left <= right) {
        while (left < 15 && ruleBox[line][tempBox[line][left]] != -1) {
          left++;
        }
        while (right > 0 && ruleBox[line][tempBox[line][right]] != -1) {
          right--;
        }
        if (tempBox[line][left] == tempBox[line][right]) {
          ruleBox[line][tempBox[line][left]] = tempBox[line][left];
        } else {
          ruleBox[line][tempBox[line][right]] = tempBox[line][left];
          ruleBox[line][tempBox[line][left]] = tempBox[line][right];
        }
      }
      for (int pos = 0; pos < BOX_SIZE; pos++) {
        if (ruleBox[line][pos] == -1) ruleBox[line][pos] = pos;
      }
    }
  }

  void encryptRSAA(List<String> hexInput) {
    int splitFactor = (hexInput.length < SPLIT_SETTING)
        ? 1
        : (hexInput.length ~/ SPLIT_SETTING);

    // Iterations Loop
    for (var itr = 0; itr < ITERATIONS; itr++) {
      // Step 1: Cellular Automata Swap
      for (var index = 0; index < hexInput.length; index++) {
        var word1 = hexInput[index].substring(0, 1),
            word2 = hexInput[index].substring(1, 2);
        hexInput[index] =
            ruleBox[itr][util.hexToInt(word1)].toRadixString(HEX) +
                ruleBox[itr][util.hexToInt(word2)].toRadixString(HEX);
      }

      // Step 2: Left Shift by splitFactor
      List<String> tempInput = [];
      for (var i = 0; i < splitFactor; i++) {
        tempInput.add(hexInput[i]);
      }
      hexInput.removeRange(0, splitFactor);
      hexInput.addAll(tempInput);
    }
  }

  void decryptRSAA(List<String> hexInput) {
    int splitFactor = (hexInput.length < SPLIT_SETTING)
        ? 1
        : (hexInput.length ~/ SPLIT_SETTING);

    // Iterations Loop
    for (var itr = ITERATIONS - 1; itr >= 0; itr--) {
      // Step 1: Right Shift by splitFactor
      List<String> tempInput = [];
      int startIndex = hexInput.length - splitFactor;
      for (var i = startIndex; i < hexInput.length; i++) {
        tempInput.add(hexInput[i]);
      }
      hexInput.removeRange(startIndex, hexInput.length);
      hexInput.insertAll(0, tempInput);

      // Step 1: Cellular Automata Swap
      for (var index = 0; index < hexInput.length; index++) {
        var word1 = hexInput[index].substring(0, 1),
            word2 = hexInput[index].substring(1, 2);
        hexInput[index] =
            ruleBox[itr][util.hexToInt(word1)].toRadixString(HEX) +
                ruleBox[itr][util.hexToInt(word2)].toRadixString(HEX);
      }
    }
  }
}
