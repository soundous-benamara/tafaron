import 'package:flutter/material.dart';
import 'package:playing_cards/playing_cards.dart';
import 'package:flutter/foundation.dart';

class MyPlayingCard extends StatelessWidget {
  final Suit suit;
  final CardValue value;
  bool showBack;

  ShapeBorder shape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(5),
      side: BorderSide(color: Colors.black, width: 0.5));

  static final List<MyPlayingCard> ALL_CARDS = [
    MyPlayingCard(suit: Suit.hearts, value: CardValue.ace),
    MyPlayingCard(suit: Suit.hearts, value: CardValue.seven),
    MyPlayingCard(suit: Suit.hearts, value: CardValue.eight),
    MyPlayingCard(suit: Suit.hearts, value: CardValue.nine),
    MyPlayingCard(suit: Suit.hearts, value: CardValue.ten),
    MyPlayingCard(suit: Suit.hearts, value: CardValue.king),
    MyPlayingCard(suit: Suit.hearts, value: CardValue.queen),
    MyPlayingCard(suit: Suit.hearts, value: CardValue.jack),
    MyPlayingCard(suit: Suit.spades, value: CardValue.ace),
    MyPlayingCard(suit: Suit.spades, value: CardValue.seven),
    MyPlayingCard(suit: Suit.spades, value: CardValue.eight),
    MyPlayingCard(suit: Suit.spades, value: CardValue.nine),
    MyPlayingCard(suit: Suit.spades, value: CardValue.ten),
    MyPlayingCard(suit: Suit.spades, value: CardValue.king),
    MyPlayingCard(suit: Suit.spades, value: CardValue.queen),
    MyPlayingCard(suit: Suit.spades, value: CardValue.jack),
    MyPlayingCard(suit: Suit.clubs, value: CardValue.ace),
    MyPlayingCard(suit: Suit.clubs, value: CardValue.seven),
    MyPlayingCard(suit: Suit.clubs, value: CardValue.eight),
    MyPlayingCard(suit: Suit.clubs, value: CardValue.nine),
    MyPlayingCard(suit: Suit.clubs, value: CardValue.ten),
    MyPlayingCard(suit: Suit.clubs, value: CardValue.king),
    MyPlayingCard(suit: Suit.clubs, value: CardValue.queen),
    MyPlayingCard(suit: Suit.clubs, value: CardValue.jack),
    MyPlayingCard(suit: Suit.diamonds, value: CardValue.ace),
    MyPlayingCard(suit: Suit.diamonds, value: CardValue.seven),
    MyPlayingCard(suit: Suit.diamonds, value: CardValue.eight),
    MyPlayingCard(suit: Suit.diamonds, value: CardValue.nine),
    MyPlayingCard(suit: Suit.diamonds, value: CardValue.ten),
    MyPlayingCard(suit: Suit.diamonds, value: CardValue.king),
    MyPlayingCard(suit: Suit.diamonds, value: CardValue.queen),
    MyPlayingCard(suit: Suit.diamonds, value: CardValue.jack),
  ];

  MyPlayingCard({
    Key key,
    @required this.value,
    @required this.suit,
  }) : super(key: key);

  get cardValue => this.value;
  get cardSuit => this.suit;

  static MyPlayingCard getCard(
      List<MyPlayingCard> list, Suit suit, CardValue value) {
    var show;
    for (int i = 0; i < list.length; i++) {
      if (list.elementAt(i).cardSuit == suit &&
          list.elementAt(i).cardValue == value) {
        show = list.elementAt(i);
        list.removeAt(i);
        return show;
      }
    }
  }

  void setShowBack(bool showBack) {
    this.showBack = showBack;
  }

  static Widget emptyCard() {
    Widget build(BuildContext context) {
      return Container(height: 125, child: Text(''));
    }
  }

  static int CardValueToInt(CardValue value) {
    switch (value) {
      case CardValue.seven:
        return 7;
        break;
      case CardValue.eight:
        return 8;
        break;
      case CardValue.nine:
        return 9;
        break;
      case CardValue.ten:
        return 10;
        break;
      case CardValue.jack:
        return 11;
        break;
      case CardValue.queen:
        return 12;
        break;
      case CardValue.king:
        return 13;
        break;
      case CardValue.ace:
        return 14;
        break;
      case CardValue.two:
        // TODO: Handle this case.
        break;
      case CardValue.three:
        // TODO: Handle this case.
        break;
      case CardValue.four:
        // TODO: Handle this case.
        break;
      case CardValue.five:
        // TODO: Handle this case.
        break;
      case CardValue.six:
        // TODO: Handle this case.
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 125,
      child: PlayingCardView(
        card: PlayingCard(this.suit, this.value),
        showBack: showBack,
        shape: shape,
        elevation: 0.5,
      ),
    );
  }
}