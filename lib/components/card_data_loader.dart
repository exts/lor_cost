import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:lorcost/domain/deck/card_data.dart';

class CardDataLoader {
  List<int> sets = [1, 2];
  List<CardData> cardData = List<CardData>();
  Map<String, CardData> cardDataMap = Map<String, CardData>();

  CardDataLoader();
  CardDataLoader.load() {
    loadSetData();
  }

  Future<void> loadSetData() async {
    for (var set in sets) {
      var setData =
          await rootBundle.loadString("assets/sets/set${set}-en_us.json");
      if (setData.isNotEmpty) {
        processSetData(setData);
      }
    }
  }

  void processSetData(String data) {
    var jsonData = jsonDecode(data);
    for (var data in jsonData) {
      var card = CardData.fromJson(data);
      cardData.add(card);
      cardDataMap[card.cardCode] = card;
    }
  }

  CardData findCard(String code) {
    print(code);
    for (var card in cardData) {
      if (card.cardCode?.toLowerCase() == code.toLowerCase()) {
        return card;
      }
    }
    return null;
  }
}
