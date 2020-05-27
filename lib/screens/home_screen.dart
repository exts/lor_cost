import 'package:flutter/material.dart';
import 'package:lorcost/domain/deck/expandable_card.dart';
import 'package:lorcost/domain/deck/providers/deck_list_provider.dart';
import 'package:lorcost/widgets/shard_widget.dart';
import 'package:provider/provider.dart';
import 'package:lorcost/widgets/coin_widget.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen() {}
  Widget build(BuildContext context) {
    var provider = Provider.of<DeckListProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("LoR Price Checker"),
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 70),
            child: Container(
              child: Column(
                children: <Widget>[
                  TextField(
                    decoration: InputDecoration(
                      hintText: "Deck Code",
                      errorText: provider.getErrorMessage(),
                    ),
                    onSubmitted: (text) {
                      provider.deckLoader(text);
                    },
                  ),
                  Divider(
                    height: 30,
                  ),
                  if (provider.deckLoaded) ...panelBuilder(provider),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          provider.deckLoader("");
        },
        child: Text("Debug"),
      ),
    );
  }

  List<Widget> panelBuilder(DeckListProvider provider) {
    return [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          CoinWidget(provider.coins),
          ShardWidget(provider.shards),
        ],
      ),
      Divider(
        height: 30,
      ),
      ExpansionPanelList(
        expansionCallback: (index, expanded) =>
            provider.toggleBasePanels(index, expanded),
        children: [
          if (provider.champions.length > 0)
            groupPanel(
              title: Text("Champions (x${provider.getChampionCount()})"),
              expanded: provider.champsExpanded,
              cards: provider.champions,
              callback: (idx, exp) => provider.toggleCardPanels(0, idx, exp),
            ),
          if (provider.followers.length > 0)
            groupPanel(
              title: Text("Followers (x${provider.getFollowerCount()})"),
              expanded: provider.followersExpanded,
              cards: provider.followers,
              callback: (idx, exp) => provider.toggleCardPanels(1, idx, exp),
            ),
          if (provider.spells.length > 0)
            groupPanel(
              title: Text("Spells (x${provider.getSpellCount()})"),
              expanded: provider.spellsExpanded,
              cards: provider.spells,
              callback: (idx, exp) => provider.toggleCardPanels(2, idx, exp),
            ),
        ],
      ),
    ];
  }

  ExpansionPanel groupPanel({
    Text title,
    bool expanded,
    List<ExpandableCard> cards,
    Function callback,
  }) {
    return ExpansionPanel(
      isExpanded: expanded,
      headerBuilder: (_, exp) {
        return ListTile(title: title);
      },
      body: ExpansionPanelList(
        expansionCallback: callback,
        children: cards.map((card) => cardPanel(card)).toList(),
      ),
    );
  }

  ExpansionPanel cardPanel(ExpandableCard card) {
    return ExpansionPanel(
      isExpanded: card.isExpanded,
      headerBuilder: (_, expanded) => Container(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 8, 8, 8),
          child: Row(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  color: Colors.amber[100],
                  border: Border.all(
                      color: Colors.black, width: 1, style: BorderStyle.solid),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Text("x${card.count}"),
                ),
              ),
              VerticalDivider(width: 5),
              Text(card.card.cardName),
            ],
          ),
        ),
      ),
      body: Container(
        width: 200,
        child: Center(
          child: Image.asset("assets/cards/${card.card.cardCode}.png"),
        ),
      ),
    );
  }
}
