import 'dart:io';

import 'package:lorcost/components/price_calculator.dart';
import 'package:lorcost/domain/deck/card_data.dart';
import 'package:lorcost/domain/deck/expandable_card.dart';
import 'package:test/test.dart';

void main() {
  test("Calculate valid count data", () async {
    var cards = [
      ExpandableCard(
          CardData.fromJson(
              {"rarity": "None", "type": "unit", "supertype": "champion"}),
          2),
    ];
    var priceCalculator = PriceCalculator(cards);
    expect(priceCalculator.coins, 600);
    expect(priceCalculator.shards, 6000);
  });
}
