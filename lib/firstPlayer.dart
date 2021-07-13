import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:playing_cards/playing_cards.dart';
import 'package:flutter/services.dart';
import 'package:turns/MyPlayingCards.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:turns/StartNewGame.dart';

class FirstPlayer extends StatefulWidget {
  FirstPlayer({Key key, this.title}) : super(key: key);

  final String title;
  @override
  _FirstPlayerState createState() => _FirstPlayerState();
}

class _FirstPlayerState extends State<FirstPlayer> {
  List<Suit> suits = [];
  List<CardValue> cardValues = [];

  bool _enabled;

  List<MyPlayingCard> deck = [];
  List<MyPlayingCard> left = [];
  List<MyPlayingCard> right = [];
  List<MyPlayingCard> top = [];

  @override
  void initState() {
    super.initState();

    SystemChrome.setEnabledSystemUIOverlays([]);

    deck.add(MyPlayingCard.emptyCard());
    right.add(MyPlayingCard.emptyCard());
    top.add(MyPlayingCard.emptyCard());
    left.add(MyPlayingCard.emptyCard());
    //MyPlayingCard.ALL_CARDS.shuffle();

    MyPlayingCard.ALL_CARDS.shuffle();

    _enabled = true;

    games.add(Text(
      'No Trtricks',
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    ));
    games.add(Text(
      'No king of Spades',
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    ));
    games.add(Text(
      'No last one',
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    ));
    games.add(Text(
      'No hearts',
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    ));
    games.add(Text(
      'No queens',
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    ));
    games.add(Text(
      'Dominoes',
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    ));
    games.add(Text(
      'Trumps',
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    ));

    SystemChrome.setEnabledSystemUIOverlays([]);
  }

  List<int> rank = [];
  List<Text> games = [];

  int maxVal, indexOfPlayer;

  void firstTurn() {
    setState(() {
      indexOfPlayer = 0;
      maxVal = rank.elementAt(indexOfPlayer);
      print('i converted values !!');
      for (int index = 1; index < rank.length; index++) {
        if (rank.elementAt(index) < maxVal) {
          maxVal = rank.elementAt(index);
          indexOfPlayer = index;
        }
        print(maxVal);
      }
    });
    Future.delayed(Duration(seconds: 2), () {
      Fluttertoast.showToast(
        msg: 'player ' +
            (indexOfPlayer + 1).toString() +
            ' will start the game !!',
        backgroundColor: Colors.black,
        gravity: ToastGravity.CENTER,
        toastLength: Toast.LENGTH_LONG,
        textColor: Colors.white,
        timeInSecForIosWeb: 1,
        fontSize: 17,
      );
    });

    Future.delayed(Duration(seconds: 5), () {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => StartNewGame(
                  firstPlayer: indexOfPlayer + 1,
                )),
      );
    });

    print('after toast');
  }

  void playerLeft() {
    Future.delayed(Duration(milliseconds: 100), () {
      setState(() {
        left.removeAt(0);
        left.add(MyPlayingCard.ALL_CARDS[0]);
        left.elementAt(0).setShowBack(false);
        rank.add(MyPlayingCard.CardValueToInt(left.elementAt(0).cardValue));
      });
    });
  }

  void playerTop() {
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        top.removeAt(0);
        top.add(MyPlayingCard.ALL_CARDS[1]);
        top.elementAt(0).setShowBack(false);
        rank.add(MyPlayingCard.CardValueToInt(top.elementAt(0).cardValue));
      });
    });
  }

  void playerDeck() {
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        right.removeAt(0);
        right.add(MyPlayingCard.ALL_CARDS[2]);
        right.elementAt(0).setShowBack(false);
        rank.add(MyPlayingCard.CardValueToInt(right.elementAt(0).cardValue));
      });
    });
  }

  void playerRight() {
    Future.delayed(Duration(seconds: 3), () {
      setState(() {
        deck.removeAt(0);
        deck.add(MyPlayingCard.ALL_CARDS[3]);
        deck.elementAt(0).setShowBack(false);
        rank.add(MyPlayingCard.CardValueToInt(deck.elementAt(0).cardValue));
      });
      firstTurn();
    });
  }

  void _onTap() {
    // Disable GestureDetector's 'onTap' property.

    setState(() => _enabled = false);
    // Enable it after 1s.
    print('I TAPPED !!!');
    playerLeft();
    playerTop();
    playerRight();
    playerDeck();
    firstTurn();
  }

  var val = '';
  var s = '';

  @override
  Widget build(BuildContext context) {
    ShapeBorder shape = RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
        side: BorderSide(color: Colors.black, width: 0.5));

    return MaterialApp(
        home: Scaffold(
      backgroundColor: Color.fromRGBO(44, 62, 80, 1.0),
      body: Align(
        alignment: Alignment.center,
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Transform.rotate(
            angle: 3.14 / 2,
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              padding: EdgeInsets.all(4),
              width: 100,
              child: left.elementAt(0),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.all(4),
                width: 100,
                child: top.elementAt(0),
              ),
              GestureDetector(
                child: Transform.rotate(
                  angle: 3.14 / 2,
                  child: Container(
                    height: 120,
                    child: PlayingCardView(
                        card: PlayingCard(Suit.spades, CardValue.ace),
                        showBack: true,
                        elevation: 0.5,
                        shape: shape),
                  ),
                ),
                onTap: _enabled ? _onTap : null,
              ),
              Container(
                padding: EdgeInsets.all(4),
                width: 100,
                child: deck.elementAt(0),
              ),
            ],
          ),
          Transform.rotate(
            angle: 3.14 / 2,
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              padding: EdgeInsets.all(4),
              width: 100,
              child: right.elementAt(0),
            ),
          ),
        ]),
      ),
    ));
  }
}
