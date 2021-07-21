import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:playing_cards/playing_cards.dart';
import 'package:flutter/services.dart';
import 'package:turns/Dominoes.dart';
import 'package:turns/MyPlayingCards.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:turns/NoHearts.dart';
import 'package:turns/NoKingOfSpades.dart';
import 'package:turns/NoQueens.dart';

import 'package:turns/NoLastOne.dart';
import 'package:turns/Trumps.dart';

// ignore: must_be_immutable
class StartNewGame extends StatefulWidget {
  int firstPlayer;
  StartNewGame({Key key, this.firstPlayer, this.title}) : super(key: key);

  final String title;
  @override
  _StartNewGame createState() => _StartNewGame();
}

class _StartNewGame extends State<StartNewGame> {
  List<MyPlayingCard> player4 = [];
  List<MyPlayingCard> player1 = [];
  List<MyPlayingCard> player3 = [];
  List<MyPlayingCard> player2 = [];

  //a list to disable and enable the games that were allready chosen
  List<bool> enabledGame = [];

  List<MyPlayingCard> display = []; //the cards of the current player

  int displayedPlayer; //the first player that was chosen in the main class

  var left, top, right; //placemnt of the player in the UI

  List<String> textGame = []; //an array that has all the name s of the 7 games

  List<Text> games = []; //an arry to display the games

  String currentGame; //to store the chosen game

  //to display the player's rank
  int displayedPlayerRank;
  int displayedTopRank;
  int displayedRightRank;
  int displayedLeftRank;

  //to store the player's rank
  int player1Rank;
  int player2Rank;
  int player3Rank;
  int player4Rank;

  //to know if the game is clickes
  bool isClicked;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    //making the screen lanscape
    SystemChrome.setEnabledSystemUIOverlays([]);

    MyPlayingCard.ALL_CARDS.shuffle(); //shuffling the cards

    currentGame = ''; //intialising the chosen game to an empty array

    //giving eachplayer his 8 cards
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

    //intialising each player's rank to zero
    player1Rank = 0;
    player2Rank = 0;
    player3Rank = 0;
    player4Rank = 0;
    displayedPlayerRank = 0;
    displayedTopRank = 0;
    displayedRightRank = 0;
    displayedLeftRank = 0;

    //assigning the firstplayer and giving it its cards
    switch (widget.firstPlayer) {
      case 1:
        display.addAll(player1);
        displayedPlayer = 1;
        displayedPlayerRank = player1Rank;
        right = 'Player 2';
        displayedRightRank = player2Rank;
        top = 'Player 3';
        displayedTopRank = player3Rank;
        left = 'Player 4';
        displayedLeftRank = player2Rank;
        break;
      case 2:
        display.addAll(player2);
        displayedPlayer = 2;
        displayedPlayerRank = player2Rank;
        right = 'Player 3';
        displayedRightRank = player3Rank;
        top = 'Player 4';
        displayedTopRank = player4Rank;
        left = 'Player 1';
        displayedLeftRank = player1Rank;
        break;
      case 3:
        display.addAll(player3);
        displayedPlayer = 3;
        displayedPlayerRank = player3Rank;
        right = 'Player 4';
        displayedRightRank = player4Rank;
        top = 'Player 1';
        displayedTopRank = player1Rank;
        left = 'Player 2';
        displayedLeftRank = player2Rank;
        break;
      case 4:
        display.addAll(player4);
        displayedPlayer = 4;
        displayedPlayerRank = player4Rank;
        right = 'Player 1';
        displayedRightRank = player1Rank;
        top = 'Player 2';
        displayedTopRank = player2Rank;
        left = 'Player 3';
        displayedLeftRank = player3Rank;
        break;
      default:
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

    //fill the array of the games
    textGame.add('No Tricks');
    textGame.add('No king of spades');
    textGame.add('No last one');
    textGame.add('No hearts');
    textGame.add('No queens');
    textGame.add('Dominoes');
    textGame.add('Trumps');

    //intializing the back of the cards to false
    for (int i = 0; i < 8; i++) {
      player1[i].setShowBack(false);
      player2[i].setShowBack(false);
      player3[i].setShowBack(false);
      player4[i].setShowBack(false);
    }

    //giving the games text a style
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

    //fixing the sceen on landscape
    SystemChrome.setEnabledSystemUIOverlays([]);

    //intializing all the games to true which means that are not chosen
    enabledGame.add(true);
    enabledGame.add(true);
    enabledGame.add(true);
    enabledGame.add(true);
    enabledGame.add(true);
    enabledGame.add(true);
    enabledGame.add(true);

    //intializing the isClicked to false
    isClicked = false;
  }

  //get the index of the chosen game
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

  //showing the chosen game in a toast
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

  //a function to disable the chosen game
  void _onTap(Text z) {
    setState(() {
      isClicked = true;
      switch (z.data) {
        case 'No Tricks':
          enabledGame[0] = false;
          Future.delayed(Duration(seconds: 3), () {});
          break;
        case 'No king of spades':
          enabledGame[1] = false;
          Future.delayed(Duration(seconds: 3), () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => NoKingOfSpades(
                        firstPlayer: widget.firstPlayer,
                        player1: player1,
                        player2: player2,
                        player3: player3,
                        player4: player4,
                        player1Rank: player1Rank,
                        player2Rank: player2Rank,
                        player3Rank: player3Rank,
                        player4Rank: player4Rank,
                        enabledGame: enabledGame,
                      )),
            );
          });
          break;
        case 'No last one':
          enabledGame[2] = false;
          Future.delayed(Duration(seconds: 3), () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => NoLastOne(
                        firstPlayer: widget.firstPlayer,
                        player1: player1,
                        player2: player2,
                        player3: player3,
                        player4: player4,
                        player1Rank: player1Rank,
                        player2Rank: player2Rank,
                        player3Rank: player3Rank,
                        player4Rank: player4Rank,
                        enabledGame: enabledGame,
                      )),
            );
          });
          break;
        case 'No hearts':
          enabledGame[3] = false;
          Future.delayed(Duration(seconds: 3), () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => NoHearts(
                        firstPlayer: widget.firstPlayer,
                        player1: player1,
                        player2: player2,
                        player3: player3,
                        player4: player4,
                        player1Rank: player1Rank,
                        player2Rank: player2Rank,
                        player3Rank: player3Rank,
                        player4Rank: player4Rank,
                        enabledGame: enabledGame,
                      )),
            );
          });
          break;
        case 'No queens':
          enabledGame[4] = false;
          Future.delayed(Duration(seconds: 3), () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => NoQueens(
                        firstPlayer: widget.firstPlayer,
                        player1: player1,
                        player2: player2,
                        player3: player3,
                        player4: player4,
                        player1Rank: player1Rank,
                        player2Rank: player2Rank,
                        player3Rank: player3Rank,
                        player4Rank: player4Rank,
                        enabledGame: enabledGame,
                      )),
            );
          });
          break;
        case 'Dominoes':
          enabledGame[5] = false;
          Future.delayed(Duration(seconds: 3), () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Dominoes(
                        firstPlayer: widget.firstPlayer,
                        player1: player1,
                        player2: player2,
                        player3: player3,
                        player4: player4,
                        player1Rank: player1Rank,
                        player2Rank: player2Rank,
                        player3Rank: player3Rank,
                        player4Rank: player4Rank,
                        enabledGame: enabledGame,
                      )),
            );
          });
          break;
        case 'Trumps':
          enabledGame[6] = false;
          Future.delayed(Duration(seconds: 3), () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Trumps(
                        firstPlayer: widget.firstPlayer,
                        player1: player1,
                        player2: player2,
                        player3: player3,
                        player4: player4,
                        player1Rank: player1Rank,
                        player2Rank: player2Rank,
                        player3Rank: player3Rank,
                        player4Rank: player4Rank,
                        enabledGame: enabledGame,
                      )),
            );
          });
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
                      onTap: () => enabledGame.elementAt(getIndex(z.data))
                          ? _onTap(z)
                          : null,
                      child: Card(
                        margin: EdgeInsets.all(8),
                        //padding: EdgeInsets.all(10),
                        color: (enabledGame[getIndex(z.data)] == true)
                            ? Color(0xFF424242)
                            : Color(0xC1C1C1),
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
                width: 50,
                height: 50,
              ),
              Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(4),
                    width: 280,
                    child: FlatCardFan(
                      children: display
                          .map(
                            (e) => Container(
                              width: 95,
                              child: e,
                            ),
                          )
                          .toList(),
                    ),
                  ),
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
