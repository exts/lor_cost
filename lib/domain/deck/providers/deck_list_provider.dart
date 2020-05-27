import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:lor_deck_codes/deck_encoder.dart';
import 'package:lorcost/components/card_data_loader.dart';
import 'package:lorcost/components/price_calculator.dart';
import 'package:lorcost/domain/deck/expandable_card.dart';

class DeckListProvider extends ChangeNotifier {
  List<ExpandableCard> spells = List<ExpandableCard>();
  List<ExpandableCard> champions = List<ExpandableCard>();
  List<ExpandableCard> followers = List<ExpandableCard>();

  int coins = 0;
  int shards = 0;

  bool champsExpanded = false;
  bool spellsExpanded = false;
  bool followersExpanded = false;

  bool deckLoaded = false;

  String errorMessage;

  final CardDataLoader cards = CardDataLoader();

  DeckListProvider() {
    cardLoader();
  }

  void cardLoader() async {
    await cards.loadSetData();
  }

  void resetDeckDataLists() {
    coins = 0;
    shards = 0;
    errorMessage = null;
    deckLoaded = false;
    champsExpanded = false;
    spellsExpanded = false;
    followersExpanded = false;
    spells = List<ExpandableCard>();
    champions = List<ExpandableCard>();
    followers = List<ExpandableCard>();
  }

  void deckLoader(String code) {
    resetDeckDataLists();
//    var code = "CEBQCAQEAMCACBABBALTUBYCAYEASDQYFUXDOAICAECB6MIA"; // temp
    try {
      var lor = DeckEncoder();
      var deck = lor.getDeckFromCode(code);
      for (var card in deck) {
        var cardInfo = cards.findCard(card.CardCode);
        if (cardInfo == null) continue;
        if (cardInfo.isFollower) {
          followers.add(ExpandableCard(cardInfo, card.Count));
        } else if (cardInfo.isChampion) {
          champions.add(ExpandableCard(cardInfo, card.Count));
        } else {
          spells.add(ExpandableCard(cardInfo, card.Count));
        }
      }

      if ((followers + champions + spells).length > 0) {
        deckLoaded = true;
        var calculator =
            PriceCalculator([...followers, ...champions, ...spells].toList());
        coins = calculator.coins;
        shards = calculator.shards;
      }
    } catch (_) {
      errorMessage = "Problem parsing deck code";
    }
    notifyListeners();
  }

  void toggleBasePanels(int index, bool expanded) {
    var count = 0;
    var indexes = Map<String, int>();

    if (champions.length > 0) {
      indexes["champs"] = count;
      ++count;
    }

    if (followers.length > 0) {
      indexes["followers"] = count;
      ++count;
    }

    if (spells.length > 0) {
      indexes["spells"] = count;
      ++count;
    }

    if (indexes["champs"] == index) {
      champsExpanded = !expanded;
    }

    if (indexes["followers"] == index) {
      followersExpanded = !expanded;
    }

    if (indexes["spells"] == index) {
      spellsExpanded = !expanded;
    }
    notifyListeners();
  }

  void toggleCardPanels(int type, int index, bool expanded) {
    switch (type) {
      case 0:
        champions[index].isExpanded = !expanded;
        break;
      case 1:
        followers[index].isExpanded = !expanded;
        break;
      case 2:
        spells[index].isExpanded = !expanded;
        break;
    }
    notifyListeners();
  }

  int getChampionCount() {
    var count = 0;
    for (var champ in champions) {
      count += champ.count;
    }
    return count;
  }

  int getFollowerCount() {
    var count = 0;
    for (var follower in followers) {
      count += follower.count;
    }
    return count;
  }

  int getSpellCount() {
    var count = 0;
    for (var spell in spells) {
      count += spell.count;
    }
    return count;
  }

  String getErrorMessage() {
    return errorMessage != null && errorMessage.isNotEmpty
        ? errorMessage
        : null;
  }
}
