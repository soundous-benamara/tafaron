import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:playing_cards/playing_cards.dart';
import 'package:flutter/services.dart';
import 'package:turns/MyPlayingCards.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:turns/NoTricks.dart';

// ignore: must_be_immutable
class StartGame extends StatefulWidget {
  int firstPlayer;
  StartGame({Key key, this.firstPlayer, this.title}) : super(key: key);

  final String title;
  @override
  _StartGame createState() => _StartGame();
}

class _StartGame extends State<StartGame> {
  List<Suit> suits = [];
  List<CardValue> cardValues = [];

  List<String> players = [];

  Suit suitRequired;

  String currentGame;

  List<bool> _enabledGame = [];

  int displayedPlayerRank;
  int displayedTopRank;
  int displayedRightRank;
  int displayedLeftRank;

  int player1Rank;
  int player2Rank;
  int player3Rank;
  int player4Rank;
  
  int player1Card;
  int player2Card;
  int player3Card;
  int player4Card;

  Suit player1Suit;
  Suit player2Suit;
  Suit player3Suit;
  Suit player4Suit;

  int gotTrick;

  List<MyPlayingCard> player4 = [];
  List<MyPlayingCard> player1 = [];
  List<MyPlayingCard> player3 = [];
  List<MyPlayingCard> player2 = [];

  List<MyPlayingCard> center = [];
  List<MyPlayingCard> display = [];

  List<String> textGame = [];
  var left, top, right;

  int displayedPlayer;

  String card;

  String clearCenter;

  int player;

  @override
  void initState() {
    super.initState();
    MyPlayingCard.ALL_CARDS.shuffle();

    currentGame = '';

    center.add(MyPlayingCard.emptyCard());

    print('CURRENT PLAYER' + widget.firstPlayer.toString());

    card = '';

    gotTrick = widget.firstPlayer;

    _enabledGame.add(true);
    _enabledGame.add(true);
    _enabledGame.add(true);
    _enabledGame.add(true);
    _enabledGame.add(true);
    _enabledGame.add(true);
    _enabledGame.add(true);

    player1Rank = 0;
    player2Rank = 0;
    player3Rank = 0;
    player4Rank = 0;

    displayedPlayerRank = 0;
    displayedTopRank = 0;
    displayedRightRank = 0;
    displayedLeftRank = 0;

    player = widget.firstPlayer;

    players.add('Player' + player.toString());
    if (player < 4) {
      player++;
    } else {
      player = 1;
    }
    players.add('Player' + player.toString());
    if (player < 4) {
      player++;
    } else {
      player = 1;
    }
    players.add('Player' + player.toString());
    if (player < 4) {
      player++;
    } else {
      player = 1;
    }
    players.add('Player' + player.toString());

    print('PLAYERS ADDED');

    for (int i = 0; i < 4; i++) {
      print('PLAYERRRR ' + players.elementAt(i).toString());
    }

    Fluttertoast.showToast(
      msg: 'Player ' +
          widget.firstPlayer.toString() +
          ' check your cards before choosing the game',
      backgroundColor: Colors.black,
      gravity: ToastGravity.CENTER,
      toastLength: Toast.LENGTH_LONG,
      textColor: Colors.white,
      timeInSecForIosWeb: 1,
      fontSize: 16,
    );

    textGame.add('No Tricks');
    textGame.add('No king of spades');
    textGame.add('No last one');
    textGame.add('No hearts');
    textGame.add('No queens');
    textGame.add('Dominoes');
    textGame.add('Trumps');

    player4.add(MyPlayingCard.ALL_CARDS[0]);
    player4.add(MyPlayingCard.ALL_CARDS[1]);
    player4.add(MyPlayingCard.ALL_CARDS[2]);
    player4.add(MyPlayingCard.ALL_CARDS[3]);
    player4.add(MyPlayingCard.ALL_CARDS[4]);
    player4.add(MyPlayingCard.ALL_CARDS[5]);
    player4.add(MyPlayingCard.ALL_CARDS[6]);
    player4.add(MyPlayingCard.ALL_CARDS[7]);

    player3.add(MyPlayingCard.ALL_CARDS[8]);
    player3.add(MyPlayingCard.ALL_CARDS[9]);
    player3.add(MyPlayingCard.ALL_CARDS[10]);
    player3.add(MyPlayingCard.ALL_CARDS[11]);
    player3.add(MyPlayingCard.ALL_CARDS[12]);
    player3.add(MyPlayingCard.ALL_CARDS[13]);
    player3.add(MyPlayingCard.ALL_CARDS[14]);
    player3.add(MyPlayingCard.ALL_CARDS[15]);

    player2.add(MyPlayingCard.ALL_CARDS[16]);
    player2.add(MyPlayingCard.ALL_CARDS[17]);
    player2.add(MyPlayingCard.ALL_CARDS[18]);
    player2.add(MyPlayingCard.ALL_CARDS[19]);
    player2.add(MyPlayingCard.ALL_CARDS[20]);
    player2.add(MyPlayingCard.ALL_CARDS[21]);
    player2.add(MyPlayingCard.ALL_CARDS[22]);
    player2.add(MyPlayingCard.ALL_CARDS[23]);

    player1.add(MyPlayingCard.ALL_CARDS[24]);
    player1.add(MyPlayingCard.ALL_CARDS[25]);
    player1.add(MyPlayingCard.ALL_CARDS[26]);
    player1.add(MyPlayingCard.ALL_CARDS[27]);
    player1.add(MyPlayingCard.ALL_CARDS[28]);
    player1.add(MyPlayingCard.ALL_CARDS[29]);
    player1.add(MyPlayingCard.ALL_CARDS[30]);
    player1.add(MyPlayingCard.ALL_CARDS[31]);

    switch (widget.firstPlayer) {
      case 1:
        display.addAll(player1);
        displayedPlayer = 1;
        right = 'Player 2';
        top = 'Player 3';
        left = 'Player 4';
        break;
      case 2:
        display.addAll(player2);
        displayedPlayer = 2;

        right = 'Player 3';
        top = 'Player 4';
        left = 'Player 1';
        break;
      case 3:
        display.addAll(player3);
        displayedPlayer = 3;
        right = 'Player 4';
        top = 'Player 1';
        left = 'Player 2';
        break;
      case 4:
        display.addAll(player4);
        displayedPlayer = 4;
        right = 'Player 1';
        top = 'Player 2';
        left = 'Player 3';
        break;
      default:
    }

    for (int i = 0; i < 8; i++) {
      player1[i].setShowBack(false);
      player2[i].setShowBack(false);
      player3[i].setShowBack(false);
      player4[i].setShowBack(false);
    }

    games.add(Text(
      textGame.elementAt(0),
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Colors.white,
        fontSize: 15,
        fontWeight: FontWeight.bold,
      ),
    ));
    games.add(Text(
      textGame.elementAt(1),
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Colors.white,
        fontSize: 15,
        fontWeight: FontWeight.bold,
      ),
    ));
    games.add(Text(
      textGame.elementAt(2),
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Colors.white,
        fontSize: 15,
        fontWeight: FontWeight.bold,
      ),
    ));
    games.add(Text(
      textGame.elementAt(3),
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Colors.white,
        fontSize: 15,
        fontWeight: FontWeight.bold,
      ),
    ));
    games.add(Text(
      textGame.elementAt(4),
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Colors.white,
        fontSize: 15,
        fontWeight: FontWeight.bold,
      ),
    ));
    games.add(Text(
      textGame.elementAt(5),
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Colors.white,
        fontSize: 15,
        fontWeight: FontWeight.bold,
      ),
    ));
    games.add(Text(
      textGame.elementAt(6),
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Colors.white,
        fontSize: 15,
        fontWeight: FontWeight.bold,
      ),
    ));

    //showGames();
    SystemChrome.setEnabledSystemUIOverlays([]);
  }

  bool isclicked = false;

  void chosenGame(String clicked) {
    currentGame = clicked;
    switch (clicked) {
      case 'No Tricks':
        Navigator.of(context, rootNavigator: true).pop('dialog');
        Fluttertoast.showToast(
          msg: clicked,
          backgroundColor: Colors.black,
          gravity: ToastGravity.CENTER,
          toastLength: Toast.LENGTH_LONG,
          textColor: Colors.white,
          timeInSecForIosWeb: 1,
          fontSize: 20,
        );
        break;
      case 'No king of spades':
        Navigator.of(context, rootNavigator: true).pop('dialog');
        Fluttertoast.showToast(
          msg: clicked,
          backgroundColor: Colors.black,
          gravity: ToastGravity.CENTER,
          toastLength: Toast.LENGTH_LONG,
          textColor: Colors.white,
          timeInSecForIosWeb: 1,
          fontSize: 20,
        );
        break;
      case 'No last one':
        Navigator.of(context, rootNavigator: true).pop('dialog');
        Fluttertoast.showToast(
          msg: clicked,
          backgroundColor: Colors.black,
          gravity: ToastGravity.CENTER,
          toastLength: Toast.LENGTH_LONG,
          textColor: Colors.white,
          timeInSecForIosWeb: 1,
          fontSize: 20,
        );
        break;
      case 'No hearts':
        Navigator.of(context, rootNavigator: true).pop('dialog');
        Fluttertoast.showToast(
          msg: clicked,
          backgroundColor: Colors.black,
          gravity: ToastGravity.CENTER,
          toastLength: Toast.LENGTH_LONG,
          textColor: Colors.white,
          timeInSecForIosWeb: 1,
          fontSize: 20,
        );
        break;
      case 'No queens':
        Navigator.of(context, rootNavigator: true).pop('dialog');
        Fluttertoast.showToast(
          msg: clicked,
          backgroundColor: Colors.black,
          gravity: ToastGravity.CENTER,
          toastLength: Toast.LENGTH_LONG,
          textColor: Colors.white,
          timeInSecForIosWeb: 1,
          fontSize: 20,
        );
        break;
      case 'Dominoes':
        Navigator.of(context, rootNavigator: true).pop('dialog');
        Fluttertoast.showToast(
          msg: clicked,
          backgroundColor: Colors.black,
          gravity: ToastGravity.CENTER,
          toastLength: Toast.LENGTH_LONG,
          textColor: Colors.white,
          timeInSecForIosWeb: 1,
          fontSize: 20,
        );
        break;
      case 'Trumps':
        Navigator.of(context, rootNavigator: true).pop('dialog');
        Fluttertoast.showToast(
          msg: clicked,
          backgroundColor: Colors.black,
          gravity: ToastGravity.CENTER,
          toastLength: Toast.LENGTH_LONG,
          textColor: Colors.white,
          timeInSecForIosWeb: 1,
          fontSize: 20,
        );
        break;
    }
  }

  List<int> rank = [];
  List<Text> games = [];

  int maxVal, indexOfPlayer;

  int getIndex(String s) {
    switch (s) {
      case 'No Tricks':
        return 0;
        break;
      case 'No king of spades':
        return 1;
        break;
      case 'No last one':
        return 2;
        break;
      case 'No hearts':
        return 3;
        break;
      case 'No queens':
        return 4;
        break;
      case 'Dominoes':
        return 5;
        break;
      case 'Trumps':
        return 6;
        break;
    }
  }

  void _onTap(Text z) {
    setState(() {
      isclicked = true;
      switch (z.data) {
        case 'No Tricks':
          _enabledGame[0] = false;
          z.style.color.red;
          break;
        case 'No king of spades':
          _enabledGame[1] = false;
          break;
        case 'No last one':
          _enabledGame[2] = false;
          break;
        case 'No hearts':
          _enabledGame[3] = false;
          break;
        case 'No queens':
          _enabledGame[4] = false;
          break;
        case 'Dominoes':
          _enabledGame[5] = false;
          break;
        case 'Trumps':
          _enabledGame[6] = false;
          break;
      }
    });
    chosenGame(z.data);
  }

  void showGames() {
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            elevation: 5,
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Text(
                    'Choose the game you want to play:',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Container(
                height: 250,
                width: 400,
                padding: EdgeInsets.all(3),
                margin: EdgeInsets.all(3),
                child: GridView.count(
                  childAspectRatio: (1 / 1),
                  crossAxisCount: 4,
                  crossAxisSpacing: 2,
                  mainAxisSpacing: 2,
                  padding: EdgeInsets.all(3.0),
                  children: games.map((z) {
                    return GestureDetector(
                      onTap: () => _enabledGame.elementAt(getIndex(z.data))
                          ? _onTap(z)
                          : null,
                      child: Card(
                        margin: EdgeInsets.all(8),
                        //padding: EdgeInsets.all(10),
                        color: Color(0xFF424242),
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Center(
                            child: z,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ]),
          );
        });
  }

  void playerTrick(List<MyPlayingCard> display, CardValue val, Suit s) {
    int maxPlayer;
    int max;
    setState(() {
      maxPlayer = player1Card;
      max = 1;

      if (player2Card > maxPlayer) {
        maxPlayer = player2Card;
        max = 2;
      }
      if (player3Card > maxPlayer) {
        maxPlayer = player3Card;
        max = 3;
      }
      if (player4Card > maxPlayer) {
        maxPlayer = player4Card;
        max = 4;
      }

      print('I AM MAX PLAYER :$maxPlayer');
      print('I AM MAX :$max');

      switch (max) {
        case 1:
          player1Rank++;
          Fluttertoast.showToast(
            msg: 'Player ' + (max).toString() + ' will start the next round !!',
            backgroundColor: Colors.black,
            gravity: ToastGravity.CENTER,
            toastLength: Toast.LENGTH_SHORT,
            textColor: Colors.white,
            timeInSecForIosWeb: 1,
            fontSize: 17,
          );
          print('DISPLAY1 $display');
          display.clear();
          print('DISPLAY2 $display');
          display.addAll(player1);
          print('DISPLAY3 $display');
          print('DISPLAYplayer1 $displayedPlayer');
          displayedPlayer = 1;
          gotTrick = 1;
          displayedPlayerRank = player1Rank;
          print('DISPLAYplayer2 $displayedPlayer');
          right = 'Player 2';
          top = 'Player 3';
          left = 'Player 4';
          displayedTopRank = player3Rank;
          displayedRightRank = player2Rank;
          displayedLeftRank = player4Rank;
          if (player1.isEmpty) {
            player1.add(MyPlayingCard.emptyCard());
          }
          break;
        case 2:
          player2Rank++;
          Fluttertoast.showToast(
            msg: 'Player ' + (max).toString() + ' will start the next round !!',
            backgroundColor: Colors.black,
            gravity: ToastGravity.CENTER,
            toastLength: Toast.LENGTH_SHORT,
            textColor: Colors.white,
            timeInSecForIosWeb: 1,
            fontSize: 17,
          );
          print('DISPLAY1 $display');
          display.clear();
          print('DISPLAY2 $display');
          display.addAll(player2);
          print('DISPLAY3 $display');
          print('DISPLAYplayer1 $displayedPlayer');
          displayedPlayer = 2;
          gotTrick = 2;
          displayedPlayerRank = player2Rank;
          print('DISPLAYplayer2 $displayedPlayer');
          right = 'Player 3';
          top = 'Player 4';
          left = 'Player 1';
          displayedTopRank = player4Rank;
          displayedRightRank = player3Rank;
          displayedLeftRank = player1Rank;
          if (player2.isEmpty) {
            player2.add(MyPlayingCard.emptyCard());
          }
          break;
        case 3:
          player3Rank++;
          Fluttertoast.showToast(
            msg: 'Player ' + (max).toString() + ' will start the next round !!',
            backgroundColor: Colors.black,
            gravity: ToastGravity.CENTER,
            toastLength: Toast.LENGTH_SHORT,
            textColor: Colors.white,
            timeInSecForIosWeb: 1,
            fontSize: 17,
          );
          print('DISPLAY1 $display');
          display.clear();
          print('DISPLAY2 $display');
          display.addAll(player3);
          print('DISPLAY3 $display');
          print('DISPLAYplayer1 $displayedPlayer');
          displayedPlayer = 3;
          gotTrick = 3;
          displayedPlayerRank = player3Rank;
          print('DISPLAYplayer2 $displayedPlayer');
          right = 'Player 4';
          top = 'Player 1';
          left = 'Player 2';
          displayedTopRank = player1Rank;
          displayedRightRank = player4Rank;
          displayedLeftRank = player2Rank;
          if (player3.isEmpty) {
            player3.add(MyPlayingCard.emptyCard());
          }
          break;
        case 4:
          player4Rank++;
          Fluttertoast.showToast(
            msg: 'Player ' + (max).toString() + ' will start the next round !!',
            backgroundColor: Colors.black,
            gravity: ToastGravity.CENTER,
            toastLength: Toast.LENGTH_SHORT,
            textColor: Colors.white,
            timeInSecForIosWeb: 1,
            fontSize: 17,
          );
          print('DISPLAY1 $display');
          display.clear();
          print('DISPLAY2 $display');
          display.addAll(player4);
          print('DISPLAY3 $display');
          print('DISPLAYplayer1 $displayedPlayer');
          displayedPlayer = 4;
          gotTrick = 4;
          displayedPlayerRank = player4Rank;
          print('DISPLAYplayer2 $displayedPlayer');
          right = 'Player 1';
          top = 'Player 2';
          left = 'Player 3';
          displayedTopRank = player2Rank;
          displayedRightRank = player1Rank;
          displayedLeftRank = player3Rank;
          if (player4.isEmpty) {
            player4.add(MyPlayingCard.emptyCard());
          }
          break;
        default:
      }
    });
  }

  void nextPlayer(List<MyPlayingCard> list, CardValue val, Suit s) {
    setState(() {
      switch (displayedPlayer) {
        case 1:
          center.add(MyPlayingCard.getCard(player1, s, val));
          display.clear();
          display.addAll(player2);
          displayedPlayer = 2;
          displayedPlayerRank = player2Rank;
          right = 'Player 3';
          displayedRightRank = player3Rank;
          top = 'Player 4';
          displayedTopRank = player4Rank;
          left = 'Player 1';
          displayedLeftRank = player1Rank;
          if (player1.isEmpty) {
            player1.add(MyPlayingCard.emptyCard());
          }
          break;
        case 2:
          center.add(MyPlayingCard.getCard(player2, s, val));
          display.clear();
          display.addAll(player3);
          displayedPlayer = 3;
          displayedPlayerRank = player3Rank;
          right = 'Player 4';
          displayedRightRank = player4Rank;
          top = 'Player 1';
          displayedTopRank = player1Rank;
          left = 'Player 2';
          displayedLeftRank = player2Rank;
          if (player2.isEmpty) {
            player2.add(MyPlayingCard.emptyCard());
          }
          break;
        case 3:
          center.add(MyPlayingCard.getCard(player3, s, val));
          display.clear();
          display.addAll(player4);

          displayedPlayer = 4;
          displayedPlayerRank = player4Rank;
          right = 'Player 1';
          displayedRightRank = player1Rank;
          top = 'Player 2';
          displayedTopRank = player2Rank;
          left = 'Player 3';
          displayedLeftRank = player3Rank;

          if (player3.isEmpty) {
            player3.add(MyPlayingCard.emptyCard());
          }
          break;
        case 4:
          center.add(MyPlayingCard.getCard(player4, s, val));
          display.clear();
          display.addAll(player1);
          displayedPlayer = 1;
          displayedPlayerRank = player1Rank;
          right = 'Player 2';
          displayedRightRank = player2Rank;
          top = 'Player 3';
          displayedTopRank = player3Rank;
          left = 'Player 4';
          displayedLeftRank = player4Rank;

          if (player4.isEmpty) {
            player4.add(MyPlayingCard.emptyCard());
          }
          break;
        default:
      }
    });
  }

  void lastTrick(List<MyPlayingCard> display) {
    int maxPlayer = player1Card;
    int max = 1;

    setState(() {
      if (player2Card > maxPlayer) {
        maxPlayer = player2Card;
        max = 2;
      }
      if (player3Card > maxPlayer) {
        maxPlayer = player3Card;
        max = 3;
      }
      if (player4Card > maxPlayer) {
        maxPlayer = player4Card;
        max = 4;
      }
    });

    switch (max) {
      case 1:
        player1Rank++;
        Fluttertoast.showToast(
          msg: 'Player ' + (max).toString() + ' will take the last trick!!',
          backgroundColor: Colors.black,
          gravity: ToastGravity.CENTER,
          toastLength: Toast.LENGTH_SHORT,
          textColor: Colors.white,
          timeInSecForIosWeb: 1,
          fontSize: 17,
        );
        switch (widget.firstPlayer) {
          case 1:
            display.clear();
            display.add(MyPlayingCard.emptyCard());
            displayedPlayer = widget.firstPlayer;
            right = 'Player 2';
            top = 'Player 3';
            left = 'Player 4';
            displayedPlayerRank = player1Rank;
            displayedRightRank = player2Rank;
            displayedTopRank = player3Rank;
            displayedLeftRank = player4Rank;
            if (player1.isEmpty) {
              player1.add(MyPlayingCard.emptyCard());
            }
            break;
          case 2:
            display.clear();
            display.add(MyPlayingCard.emptyCard());
            displayedPlayer = widget.firstPlayer;
            right = 'Player 3';
            top = 'Player 4';
            left = 'Player 1';
            displayedPlayerRank = player2Rank;
            displayedRightRank = player3Rank;
            displayedTopRank = player4Rank;
            displayedLeftRank = player1Rank;
            if (player2.isEmpty) {
              player2.add(MyPlayingCard.emptyCard());
            }
            break;
          case 3:
            display.clear();
            display.add(MyPlayingCard.emptyCard());
            displayedPlayer = widget.firstPlayer;
            right = 'Player 4';
            top = 'Player 1';
            left = 'Player 2';
            displayedPlayerRank = player3Rank;
            displayedRightRank = player4Rank;
            displayedTopRank = player1Rank;
            displayedLeftRank = player2Rank;
            if (player3.isEmpty) {
              player3.add(MyPlayingCard.emptyCard());
            }
            break;
          case 4:
            display.clear();
            display.add(MyPlayingCard.emptyCard());
            displayedPlayer = widget.firstPlayer;
            right = 'Player 1';
            top = 'Player 2';
            left = 'Player 3';
            displayedPlayerRank = player4Rank;
            displayedRightRank = player1Rank;
            displayedTopRank = player2Rank;
            displayedLeftRank = player3Rank;
            if (player4.isEmpty) {
              player4.add(MyPlayingCard.emptyCard());
            }
            break;
          default:
        }
        break;
      case 2:
        player2Rank++;
        Fluttertoast.showToast(
          msg: 'Player ' + (max).toString() + ' will take the last trick !!',
          backgroundColor: Colors.black,
          gravity: ToastGravity.CENTER,
          toastLength: Toast.LENGTH_SHORT,
          textColor: Colors.white,
          timeInSecForIosWeb: 1,
          fontSize: 17,
        );
        switch (widget.firstPlayer) {
          case 1:
            display.clear();
            display.add(MyPlayingCard.emptyCard());
            displayedPlayer = widget.firstPlayer;
            right = 'Player 2';
            top = 'Player 3';
            left = 'Player 4';
            displayedPlayerRank = player1Rank;
            displayedRightRank = player2Rank;
            displayedTopRank = player3Rank;
            displayedLeftRank = player4Rank;
            if (player1.isEmpty) {
              player1.add(MyPlayingCard.emptyCard());
            }
            break;
          case 2:
            display.clear();
            display.add(MyPlayingCard.emptyCard());
            displayedPlayer = widget.firstPlayer;
            right = 'Player 3';
            top = 'Player 4';
            left = 'Player 1';
            displayedPlayerRank = player2Rank;
            displayedRightRank = player3Rank;
            displayedTopRank = player4Rank;
            displayedLeftRank = player1Rank;
            if (player2.isEmpty) {
              player2.add(MyPlayingCard.emptyCard());
            }
            break;
          case 3:
            display.clear();
            display.add(MyPlayingCard.emptyCard());
            displayedPlayer = widget.firstPlayer;
            right = 'Player 4';
            top = 'player 1';
            left = 'Player 2';
            displayedPlayerRank = player3Rank;
            displayedRightRank = player4Rank;
            displayedTopRank = player1Rank;
            displayedLeftRank = player2Rank;
            if (player3.isEmpty) {
              player3.add(MyPlayingCard.emptyCard());
            }
            break;
          case 4:
            display.clear();
            display.add(MyPlayingCard.emptyCard());
            displayedPlayer = widget.firstPlayer;
            right = 'Player 1';
            top = 'Player 2';
            left = 'Player 3';
            displayedPlayerRank = player4Rank;
            displayedRightRank = player1Rank;
            displayedTopRank = player2Rank;
            displayedLeftRank = player3Rank;
            if (player4.isEmpty) {
              player4.add(MyPlayingCard.emptyCard());
            }
            break;
          default:
        }
        break;
      case 3:
        player3Rank++;
        Fluttertoast.showToast(
          msg: 'Player ' + (max).toString() + ' will take the last trick !!',
          backgroundColor: Colors.black,
          gravity: ToastGravity.CENTER,
          toastLength: Toast.LENGTH_SHORT,
          textColor: Colors.white,
          timeInSecForIosWeb: 1,
          fontSize: 17,
        );
        switch (widget.firstPlayer) {
          case 1:
            display.clear();
            display.add(MyPlayingCard.emptyCard());
            displayedPlayer = widget.firstPlayer;
            right = 'Player 2';
            top = 'Player 3';
            left = 'Player 4';
            displayedPlayerRank = player1Rank;
            displayedRightRank = player2Rank;
            displayedTopRank = player3Rank;
            displayedLeftRank = player4Rank;
            if (player1.isEmpty) {
              player1.add(MyPlayingCard.emptyCard());
            }
            break;
          case 2:
            display.clear();
            display.add(MyPlayingCard.emptyCard());
            displayedPlayer = widget.firstPlayer;
            right = 'Player 3';
            top = 'Player 4';
            left = 'Player 1';
            displayedPlayerRank = player2Rank;
            displayedRightRank = player3Rank;
            displayedTopRank = player4Rank;
            displayedLeftRank = player1Rank;
            if (player2.isEmpty) {
              player2.add(MyPlayingCard.emptyCard());
            }
            break;
          case 3:
            display.clear();
            display.add(MyPlayingCard.emptyCard());
            displayedPlayer = widget.firstPlayer;
            right = 'Player 4';
            top = 'Player 1';
            left = 'Player 2';
            displayedPlayerRank = player3Rank;
            displayedRightRank = player4Rank;
            displayedTopRank = player1Rank;
            displayedLeftRank = player2Rank;
            if (player3.isEmpty) {
              player3.add(MyPlayingCard.emptyCard());
            }
            break;
          case 4:
            display.clear();
            display.add(MyPlayingCard.emptyCard());
            displayedPlayer = widget.firstPlayer;
            right = 'Player 1';
            top = 'Player 2';
            left = 'Player 3';
            displayedPlayerRank = player4Rank;
            displayedRightRank = player1Rank;
            displayedTopRank = player2Rank;
            displayedLeftRank = player3Rank;
            if (player4.isEmpty) {
              player4.add(MyPlayingCard.emptyCard());
            }
            break;
          default:
        }
        break;
      case 4:
        player4Rank++;
        Fluttertoast.showToast(
          msg: 'Player ' + (max).toString() + ' will take the last trick !!',
          backgroundColor: Colors.black,
          gravity: ToastGravity.CENTER,
          toastLength: Toast.LENGTH_SHORT,
          textColor: Colors.white,
          timeInSecForIosWeb: 1,
          fontSize: 17,
        );
        switch (widget.firstPlayer) {
          case 1:
            display.clear();
            display.add(MyPlayingCard.emptyCard());
            displayedPlayer = widget.firstPlayer;
            right = 'Player 2';
            top = 'Player 3';
            left = 'Player 4';
            displayedPlayerRank = player1Rank;
            displayedRightRank = player2Rank;
            displayedTopRank = player3Rank;
            displayedLeftRank = player4Rank;
            if (player1.isEmpty) {
              player1.add(MyPlayingCard.emptyCard());
            }
            break;
          case 2:
            display.clear();
            display.add(MyPlayingCard.emptyCard());
            displayedPlayer = widget.firstPlayer;
            right = 'Player 3';
            top = 'Player 4';
            left = 'Player 1';
            displayedPlayerRank = player2Rank;
            displayedRightRank = player3Rank;
            displayedTopRank = player4Rank;
            displayedLeftRank = player1Rank;
            if (player2.isEmpty) {
              player2.add(MyPlayingCard.emptyCard());
            }
            break;
          case 3:
            display.clear();
            display.add(MyPlayingCard.emptyCard());
            displayedPlayer = widget.firstPlayer;
            right = 'Player 4';
            top = 'Player 1';
            left = 'Player 2';
            displayedPlayerRank = player3Rank;
            displayedRightRank = player4Rank;
            displayedTopRank = player1Rank;
            displayedLeftRank = player2Rank;
            if (player3.isEmpty) {
              player3.add(MyPlayingCard.emptyCard());
            }
            break;
          case 4:
            display.clear();
            display.add(MyPlayingCard.emptyCard());
            displayedPlayer = widget.firstPlayer;
            right = 'Player 1';
            top = 'Player 2';
            left = 'Player 3';
            displayedPlayerRank = player4Rank;
            displayedRightRank = player1Rank;
            displayedTopRank = player2Rank;
            displayedLeftRank = player3Rank;
            if (player4.isEmpty) {
              player4.add(MyPlayingCard.emptyCard());
            }
            break;
          default:
        }
        break;
      default:
    }
  }

  bool suitExists() {
    int i;
    switch (displayedPlayer) {
      case 1:
        for (i = 0; i < player1.length; i++) {
          if (player1[i].cardSuit == suitRequired) {
            return true;
          }
        }
        if (i == player1.length) {
          return false;
        }
        break;
      case 2:
        for (i = 0; i < player2.length; i++) {
          if (player2[i].cardSuit == suitRequired) {
            return true;
          }
        }
        if (i == player2.length) {
          return false;
        }
        break;
      case 3:
        for (i = 0; i < player3.length; i++) {
          if (player3[i].cardSuit == suitRequired) {
            return true;
          }
        }
        if (i == player3.length) {
          return false;
        }
        break;
      case 4:
        for (i = 0; i < player4.length; i++) {
          if (player4[i].cardSuit == suitRequired) {
            return true;
          }
        }
        if (i == player4.length) {
          return false;
        }
        break;
      default:
    }
  }

  double cardOpacity(Suit s) {
    bool exist = suitExists();
    if (exist) {
      if (s == suitRequired) {
        return 1;
      } else {
        return 0.5;
      }
    } else {
      return 1;
    }
  }

  bool cardEnabled(Suit s) {
    bool exist = suitExists();
    if (exist) {
      if (s == suitRequired) {
        return false;
      } else {
        return true;
      }
    } else {
      return false;
    }
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
          Padding(
            padding: const EdgeInsets.all(15),
            child: Text(
              '$left\n      $displayedLeftRank',
              style: TextStyle(
                  fontFamily: 'Raleway',
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(15),
                child: Text(
                  '$top\n      $displayedTopRank',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                child: Container(
                  padding: EdgeInsets.all(4),
                  width: (center.length == 1) ? 80 : 280,
                  child: (center.length > 1)
                      ? FlatCardFan(
                          children: center
                              .map(
                                (e) => Container(
                                  height: 100,
                                  width: 70,
                                  child: e,
                                ),
                              )
                              .toList(),
                        )
                      : Container(
                          height: 100,
                          width: 70,
                          child: center.elementAt(0),
                        ),
                ),
              ),
              Column(
                children: [
                  Container(
                      padding: EdgeInsets.all(4),
                      width: (display.length == 1) ? 100 : 280,
                      child: (display.length > 1)
                          ? FlatCardFan(
                              children: display
                                  .map((e) => GestureDetector(
                                        child: Opacity(
                                          opacity: (center.isEmpty ||
                                                  center.length == 4)
                                              ? 1
                                              : cardOpacity(e.cardSuit),
                                          child: IgnorePointer(
                                            ignoring: (center.isEmpty ||
                                                    center.length == 4)
                                                ? false
                                                : cardEnabled(e.cardSuit),
                                            child: Container(
                                              width: 95,
                                              child: e,
                                            ),
                                          ),
                                        ),
                                        onTap: () {
                                          switch (widget.firstPlayer) {
                                            case 1:
                                              if (player1.length == 8) {
                                                center.clear();
                                              }
                                              break;
                                            case 2:
                                              if (player2.length == 8) {
                                                center.clear();
                                              }
                                              break;
                                            case 3:
                                              if (player3.length == 8) {
                                                center.clear();
                                              }
                                              break;
                                            case 4:
                                              if (player4.length == 8) {
                                                center.clear();
                                              }
                                              break;
                                            default:
                                          }
                                          switch (displayedPlayer) {
                                            case 1:
                                              setState(() {
                                                if (center.isEmpty ||
                                                    center.length == 4) {
                                                  player1Card = MyPlayingCard
                                                      .CardValueToInt(
                                                          e.cardValue);
                                                  player1Suit = e.cardSuit;
                                                  print(
                                                      'player1Card = $player1Card');
                                                } else {
                                                  if (e.cardSuit ==
                                                      suitRequired) {
                                                    player1Card = MyPlayingCard
                                                        .CardValueToInt(
                                                            e.cardValue);
                                                  } else {
                                                    player1Card = 0;
                                                  }
                                                }
                                              });
                                              break;
                                            case 2:
                                              setState(() {
                                                if (center.isEmpty ||
                                                    center.length == 4) {
                                                  player2Card = MyPlayingCard
                                                      .CardValueToInt(
                                                          e.cardValue);
                                                  player2Suit = e.cardSuit;
                                                  print(
                                                      'player2Card = $player2Card');
                                                } else {
                                                  if (e.cardSuit ==
                                                      suitRequired) {
                                                    player2Card = MyPlayingCard
                                                        .CardValueToInt(
                                                            e.cardValue);
                                                  } else {
                                                    player2Card = 0;
                                                  }
                                                }
                                              });
                                              break;
                                            case 3:
                                              setState(() {
                                                if (center.isEmpty ||
                                                    center.length == 4) {
                                                  player3Card = MyPlayingCard
                                                      .CardValueToInt(
                                                          e.cardValue);
                                                  player3Suit = e.cardSuit;
                                                  print(
                                                      'player3Card = $player3Card');
                                                } else {
                                                  if (e.cardSuit ==
                                                      suitRequired) {
                                                    player3Card = MyPlayingCard
                                                        .CardValueToInt(
                                                            e.cardValue);
                                                  } else {
                                                    player3Card = 0;
                                                  }
                                                }
                                              });
                                              break;
                                            case 4:
                                              setState(() {
                                                if (center.isEmpty ||
                                                    center.length == 4) {
                                                  player4Card = MyPlayingCard
                                                      .CardValueToInt(
                                                          e.cardValue);
                                                  player4Suit = e.cardSuit;
                                                  print(
                                                      'player4Card = $player4Card');
                                                } else {
                                                  if (e.cardSuit ==
                                                      suitRequired) {
                                                    player4Card = MyPlayingCard
                                                        .CardValueToInt(
                                                            e.cardValue);
                                                  } else {
                                                    player4Card = 0;
                                                  }
                                                }
                                              });
                                              break;
                                            default:
                                          }
                                          if (center.length == 3) {
                                            switch (displayedPlayer) {
                                              case 1:
                                                print('CENTER1 $center');
                                                center.add(
                                                    MyPlayingCard.getCard(
                                                        player1,
                                                        e.cardSuit,
                                                        e.cardValue));
                                                print('CENTER $center');
                                                break;
                                              case 2:
                                                print('CENTER1 $center');
                                                center.add(
                                                    MyPlayingCard.getCard(
                                                        player2,
                                                        e.cardSuit,
                                                        e.cardValue));
                                                print('CENTER $center');
                                                break;
                                              case 3:
                                                print('CENTER1 $center');
                                                center.add(
                                                    MyPlayingCard.getCard(
                                                        player3,
                                                        e.cardSuit,
                                                        e.cardValue));
                                                print('CENTER $center');
                                                break;
                                              case 4:
                                                print('CENTER1 $center');
                                                center.add(
                                                    MyPlayingCard.getCard(
                                                        player4,
                                                        e.cardSuit,
                                                        e.cardValue));
                                                print('CENTER $center');
                                                break;
                                              default:
                                            }
                                            playerTrick(display, e.cardValue,
                                                e.cardSuit);
                                          } else if (center.length == 4 ||
                                              center.isEmpty) {
                                            center.clear();
                                            nextPlayer(display, e.cardValue,
                                                e.cardSuit);
                                            setState(() {
                                              suitRequired = e.cardSuit;
                                            });
                                            print(
                                                'REQUIRED SUIT: $suitRequired');
                                          } else {
                                            nextPlayer(display, e.cardValue,
                                                e.cardSuit);
                                          }
                                        },
                                      ))
                                  .toList(),
                            )
                          : GestureDetector(
                              child: Container(
                                width: 95,
                                child: display.elementAt(0),
                              ),
                              onTap: () {
                                switch (displayedPlayer) {
                                  case 1:
                                    setState(() {
                                      if (center.isEmpty ||
                                          center.length == 4) {
                                        player1Card =
                                            MyPlayingCard.CardValueToInt(
                                          display.elementAt(0).cardValue,
                                        );
                                        player1Suit =
                                            display.elementAt(0).cardSuit;
                                        print('player1Card = $player1Card');
                                      } else {
                                        if (display.elementAt(0).cardSuit ==
                                            suitRequired) {
                                          player1Card =
                                              MyPlayingCard.CardValueToInt(
                                                  display
                                                      .elementAt(0)
                                                      .cardValue);
                                        } else {
                                          player1Card = 0;
                                        }
                                      }
                                    });

                                    break;
                                  case 2:
                                    setState(() {
                                      if (center.isEmpty ||
                                          center.length == 4) {
                                        player2Card =
                                            MyPlayingCard.CardValueToInt(
                                          display.elementAt(0).cardValue,
                                        );
                                        player2Suit =
                                            display.elementAt(0).cardSuit;
                                        print('player2Card = $player2Card');
                                      } else {
                                        if (display.elementAt(0).cardSuit ==
                                            suitRequired) {
                                          player2Card =
                                              MyPlayingCard.CardValueToInt(
                                                  display
                                                      .elementAt(0)
                                                      .cardValue);
                                        } else {
                                          player2Card = 0;
                                        }
                                      }
                                    });
                                    break;
                                  case 3:
                                    setState(() {
                                      if (center.isEmpty ||
                                          center.length == 4) {
                                        player3Card =
                                            MyPlayingCard.CardValueToInt(
                                          display.elementAt(0).cardValue,
                                        );
                                        player3Suit =
                                            display.elementAt(0).cardSuit;
                                        print('player3Card = $player3Card');
                                      } else {
                                        if (display.elementAt(0).cardSuit ==
                                            suitRequired) {
                                          player3Card =
                                              MyPlayingCard.CardValueToInt(
                                                  display
                                                      .elementAt(0)
                                                      .cardValue);
                                        } else {
                                          player3Card = 0;
                                        }
                                      }
                                    });
                                    break;
                                  case 4:
                                    setState(() {
                                      if (center.isEmpty ||
                                          center.length == 4) {
                                        player4Card =
                                            MyPlayingCard.CardValueToInt(
                                          display.elementAt(0).cardValue,
                                        );
                                        player4Suit =
                                            display.elementAt(0).cardSuit;
                                        print('player4Card = $player4Card');
                                      } else {
                                        if (display.elementAt(0).cardSuit ==
                                            suitRequired) {
                                          player4Card =
                                              MyPlayingCard.CardValueToInt(
                                                  display
                                                      .elementAt(0)
                                                      .cardValue);
                                        } else {
                                          player4Card = 0;
                                        }
                                      }
                                    });
                                    break;
                                  default:
                                }
                                if (center.length == 3) {
                                  switch (displayedPlayer) {
                                    case 1:
                                      print('CENTER1 $center');
                                      center.add(MyPlayingCard.getCard(
                                          player1,
                                          display.elementAt(0).cardSuit,
                                          display.elementAt(0).cardValue));
                                      print('CENTER $center');
                                      break;
                                    case 2:
                                      print('CENTER1 $center');
                                      center.add(MyPlayingCard.getCard(
                                          player2,
                                          display.elementAt(0).cardSuit,
                                          display.elementAt(0).cardValue));
                                      print('CENTER $center');
                                      break;
                                    case 3:
                                      print('CENTER1 $center');
                                      center.add(MyPlayingCard.getCard(
                                          player3,
                                          display.elementAt(0).cardSuit,
                                          display.elementAt(0).cardValue));
                                      print('CENTER $center');
                                      break;
                                    case 4:
                                      print('CENTER1 $center');
                                      center.add(MyPlayingCard.getCard(
                                          player4,
                                          display.elementAt(0).cardSuit,
                                          display.elementAt(0).cardValue));
                                      print('CENTER $center');
                                      break;
                                    default:
                                  }
                                  lastTrick(display);
                                } else if (center.length == 4 ||
                                    center.isEmpty) {
                                  center.clear();
                                  setState(() {
                                    suitRequired =
                                        display.elementAt(0).cardSuit;
                                  });
                                  nextPlayer(
                                      display,
                                      display.elementAt(0).cardValue,
                                      display.elementAt(0).cardSuit);
                                  print('REQUIRED SUIT: $suitRequired');
                                } else {
                                  nextPlayer(
                                      display,
                                      display.elementAt(0).cardValue,
                                      display.elementAt(0).cardSuit);
                                }
                              },
                            )),
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Text(
                        'Player ' +
                            displayedPlayer.toString() +
                            '\n      $displayedPlayerRank',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                ],
              ),
            ],
          ),
          Column(
            //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    top: 190, right: 15, bottom: 90, left: 15),
                child: Text(
                  '$right\n      $displayedRightRank',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 10, right: 15, bottom: 10, left: 15),
                child: Container(
                  width: 100,
                  child: RaisedButton(
                      color: Colors.white,
                      onPressed: showGames,
                      child: Text(
                        'Games',
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                ),
              ),
            ],
          ),
        ]),
      ),
    ));
  }
}
