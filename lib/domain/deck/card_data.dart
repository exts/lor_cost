import 'package:lorcost/domain/deck/card_rarity.dart';

class CardData {
  int cost;
  int health;
  int attack;
  bool isSpell;
  bool isChampion;
  bool isFollower;
  String cardName;
  String cardDescription;
  String cardCode;
  CardRarity rarity;

  String toString() {
    return [cardName, isChampion, isFollower, isSpell].toString();
  }

  CardData.fromJson(Map data) {
    // info
    cardName = data["name"] ?? null;
    cardCode = data["cardCode"] ?? null;
    cardDescription = parseDescription(data["descriptionRaw"] ?? null);

    // stats
    cost = (data["cost"] ?? 0) as int;
    attack = (data["attack"] ?? 0) as int;
    health = (data["health"] ?? 0) as int;

    // card type
    isSpell = false;
    isChampion = false;
    isFollower = false;

    var cardType = (data["type"] ?? null) as String;
    var cardSuperType = (data["supertype"] ?? null) as String;
    if (cardType.isNotEmpty) {
      if (cardType.toLowerCase() == "spell") {
        isSpell = true;
      } else if (cardType.toLowerCase() == "unit" &&
          cardSuperType.isNotEmpty &&
          cardSuperType.toLowerCase() == "champion") {
        isChampion = true;
      } else {
        isFollower = true;
      }
    }

    if (isChampion) {
      rarity = CardRarity.Champion;
    } else {
      var cardRarity = (data["rarity"] ?? null) as String;
      _getRarity(cardRarity);
    }
  }

  static String parseDescription(String description) {
    if (description != null && description.isNotEmpty) {
      return description.replaceAll("\r\n", "").replaceAll("\n", "");
    }
    return null;
  }

  void _getRarity(String type) {
    switch (type?.toLowerCase()) {
      case "epic":
        rarity = CardRarity.Epic;
        break;
      case "rare":
        rarity = CardRarity.Rare;
        break;
      case "common":
      default:
        rarity = CardRarity.Common;
        break;
    }
  }
}
