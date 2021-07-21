import 'package:cloud_firestore/cloud_firestore.dart';
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

  void setShowBack(bool showBack) {
    this.showBack = showBack;
  }

  static void getCard(
      List<MyPlayingCard> list, Suit suit, CardValue value, int turn) {
    for (int i = 0; i < list.length; i++) {
      if (list.elementAt(i).cardSuit == suit &&
          list.elementAt(i).cardValue == value) {
        switch (turn) {
          case 1:
            FirebaseFirestore.instance
                .collection('games')
                .doc('YpyyMAaFcRzCPbphEfYR')
                .update({
              'trickCard1': {
                'val': MyPlayingCard.CardValueToInt(value),
                'suit': MyPlayingCard.SuitToString(suit)
              }
            });
            break;
          case 2:
            FirebaseFirestore.instance
                .collection('games')
                .doc('YpyyMAaFcRzCPbphEfYR')
                .update({
              'trickCard2': {
                'val': MyPlayingCard.CardValueToInt(value),
                'suit': MyPlayingCard.SuitToString(suit)
              }
            });
            break;
          case 3:
            FirebaseFirestore.instance
                .collection('games')
                .doc('YpyyMAaFcRzCPbphEfYR')
                .update({
              'trickCard3': {
                'val': MyPlayingCard.CardValueToInt(value),
                'suit': MyPlayingCard.SuitToString(suit)
              }
            });
            break;
          case 4:
            FirebaseFirestore.instance
                .collection('games')
                .doc('YpyyMAaFcRzCPbphEfYR')
                .update({
              'trickCard4': {
                'val': MyPlayingCard.CardValueToInt(value),
                'suit': MyPlayingCard.SuitToString(suit)
              }
            });
            break;
          default:
        }
        list.removeAt(i);
        break;
      }
    }
  }

  static Widget emptyCard() {
    Widget build(BuildContext context) {
      return Container(height: 40, child: Text(''));
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

  static CardValue IntToCardValue(int value) {
    switch (value) {
      case 7:
        return CardValue.seven;
        break;
      case 8:
        return CardValue.eight;
        break;
      case 9:
        return CardValue.nine;
        break;
      case 10:
        return CardValue.ten;
        break;
      case 11:
        return CardValue.jack;
        break;
      case 12:
        return CardValue.queen;
        break;
      case 13:
        return CardValue.king;
        break;
      case 14:
        return CardValue.ace;
        break;
    }
  }

  static Suit StringToSuit(String value) {
    switch (value) {
      case 'clubs':
        return Suit.clubs;
        break;
      case 'diamonds':
        return Suit.diamonds;
        break;
      case 'spades':
        return Suit.spades;
        break;
      case 'hearts':
        return Suit.hearts;
        break;
    }
  }

  static String SuitToString(Suit value) {
    switch (value) {
      case Suit.clubs:
        return 'clubs';
        break;
      case Suit.diamonds:
        return 'diamonds';
        break;
      case Suit.spades:
        return 'spades';
        break;
      case Suit.hearts:
        return 'hearts';
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      child: PlayingCardView(
        card: PlayingCard(this.suit, this.value),
        showBack: showBack,
        shape: shape,
        elevation: 0.5,
      ),
    );
  }
}
