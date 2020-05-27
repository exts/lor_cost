import 'package:lorcost/domain/deck/card_data.dart';

class ExpandableCard {
  int count;
  bool isExpanded = false;
  CardData card;
  ExpandableCard(this.card, this.count);
}
