import 'dart:io';

import 'package:flutter/material.dart';
import 'package:lorcost/components/card_data_loader.dart';
import 'package:test/test.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  test("set load has dat", () async {
    var cd = CardDataLoader();
    var sets = [1, 2];
    for (var set in sets) {
      var f = File("assets/sets/set${set}-en_us.json");
      var data = f.readAsStringSync();
      cd.processSetData(data);
    }
    expect(cd.cardData, isNotEmpty);
  });
}
