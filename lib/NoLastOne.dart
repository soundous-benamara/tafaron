import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:playing_cards/playing_cards.dart';
import 'package:flutter/services.dart';
import 'package:turns/MyPlayingCards.dart';
import 'package:fluttertoast/fluttertoast.dart';

// ignore: must_be_immutable
class NoLastOne extends StatefulWidget {
  int firstPlayer;

  List<MyPlayingCard> player4 = [];
  List<MyPlayingCard> player1 = [];
  List<MyPlayingCard> player3 = [];
  List<MyPlayingCard> player2 = [];

  //to store the player's rank
  int player1Rank;
  int player2Rank;
  int player3Rank;
  int player4Rank;

  List<bool> enabledGame = [];

  NoLastOne({
    Key key,
    this.firstPlayer,
    this.title,
    this.player1,
    this.player2,
    this.player3,
    this.player4,
    this.player1Rank,
    this.player2Rank,
    this.player3Rank,
    this.player4Rank,
    this.enabledGame,
  }) : super(key: key);

  final String title;
  @override
  _NoLastOne createState() => _NoLastOne();
}

class _NoLastOne extends State<NoLastOne> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {}
}
