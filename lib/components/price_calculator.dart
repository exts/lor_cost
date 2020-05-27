import 'package:lorcost/domain/deck/card_rarity.dart';
import 'package:lorcost/domain/deck/expandable_card.dart';

class PriceCalculator {
  int shards = 0;
  int coins = 0;

  List<ExpandableCard> _cards;

  PriceCalculator(this._cards) {
    _calculateCards();
  }

  void _calculateCards() {
    for (var expandableCard in _cards) {
      for (var count = 0; count < expandableCard.count; count++) {
        coins += _typeToCoins(expandableCard.card.rarity);
        shards += _typeToShards(expandableCard.card.rarity);
      }
    }
  }

  int _typeToShards(CardRarity type) {
    switch (type) {
      case CardRarity.Champion:
        return 3000;
      case CardRarity.Epic:
        return 1200;
      case CardRarity.Rare:
        return 300;
      case CardRarity.Common:
        return 100;
    }
    return 0;
  }

  int _typeToCoins(CardRarity type) {
    switch (type) {
      case CardRarity.Champion:
        return 300;
      case CardRarity.Epic:
        return 120;
      case CardRarity.Rare:
        return 30;
      case CardRarity.Common:
        return 10;
    }
    return 0;
  }
}
