import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:playing_cards/playing_cards.dart';
import 'package:flutter/services.dart';
import 'package:turns/MyPlayingCards.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'Dominoes.dart';
import 'NoHearts.dart';
import 'NoKingOfSpades.dart';
import 'NoLastOne.dart';
import 'NoQueens.dart';
import 'Trumps.dart';

class NoTrick extends StatefulWidget {
  const NoTrick({Key key}) : super(key: key);

  @override
  _NoTrickState createState() => _NoTrickState();
}

class _NoTrickState extends State<NoTrick> {
  int rank1, rank2, rank3, rank4;

  String uid1, uid2, uid3, uid4;

  String userName1, userName2, userName3, userName4;

  String leftUsername, rightUsername, topUsername, currentPlayerUsername;

  User user;

  List<MyPlayingCard> display = [];

  List<Text> games = [];

  List<String> textGame = [];

  List<bool> enabledGame = [];

  bool isClicked;

  int displayedPlayer;

  List<MyPlayingCard> player4 = [];
  List<MyPlayingCard> player1 = [];
  List<MyPlayingCard> player3 = [];
  List<MyPlayingCard> player2 = [];

  //to store the player's rank
  int player1Rank;
  int player2Rank;
  int player3Rank;
  int player4Rank;

  List<MyPlayingCard> center = [];

  var left, top, right;

  Suit suitRequired;

  //to display the player's rank
  int displayedPlayerRank;
  int topRank;
  int rightRank;
  int leftRank;

  int player1Card;
  int player2Card;
  int player3Card;
  int player4Card;

  Suit player1Suit;
  Suit player2Suit;
  Suit player3Suit;
  Suit player4Suit;

  int gotTrick;

  @override
  void initState() {
    getUsers();

//fill the array of the games
    textGame.add('No Tricks');
    textGame.add('No king of spades');
    textGame.add('No last one');
    textGame.add('No hearts');
    textGame.add('No queens');
    textGame.add('Dominoes');
    textGame.add('Trumps');

    displayedPlayerRank = 0;
    topRank = 0;
    rightRank = 0;
    leftRank = 0;

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

    //intializing all the games to true which means that are not chosen
    enabledGame.add(true);
    enabledGame.add(true);
    enabledGame.add(true);
    enabledGame.add(true);
    enabledGame.add(true);
    enabledGame.add(true);
    enabledGame.add(true);

    userName1 = '';
    userName2 = '';
    userName3 = '';
    userName4 = '';

    leftUsername = '';
    rightUsername = '';
    topUsername = '';
    currentPlayerUsername = '';

    user = FirebaseAuth.instance.currentUser;

    displayCards();

    center.add(MyPlayingCard.emptyCard());
    center.add(MyPlayingCard.emptyCard());
    center.add(MyPlayingCard.emptyCard());
    center.add(MyPlayingCard.emptyCard());
  }

  Future<void> addTricks(
      QuerySnapshot snapshotGames,
      Map<String, dynamic> trick1,
      Map<String, dynamic> trick2,
      Map<String, dynamic> trick3,
      Map<String, dynamic> trick4) async {
    if (snapshotGames.docs[0]['trickCard1']['val'] != 0 &&
        snapshotGames.docs[0]['trickCard1']['suit'] != "") {
      center[0] = MyPlayingCard(
          suit: MyPlayingCard.StringToSuit(trick1['suit']),
          value: MyPlayingCard.IntToCardValue(trick1['val']));
      center[0].showBack = snapshotGames.docs[0]['showCard'];
    } else {
      center[0] = MyPlayingCard.emptyCard();
    }

    if (snapshotGames.docs[0]['trickCard2']['val'] != 0 &&
        snapshotGames.docs[0]['trickCard2']['suit'] != "") {
      center[1] = MyPlayingCard(
          suit: MyPlayingCard.StringToSuit(trick2['suit']),
          value: MyPlayingCard.IntToCardValue(trick2['val']));
      center[1].showBack = snapshotGames.docs[0]['showCard'];
    } else {
      center[1] = MyPlayingCard.emptyCard();
    }
    if (snapshotGames.docs[0]['trickCard3']['val'] != 0 &&
        snapshotGames.docs[0]['trickCard3']['suit'] != "") {
      center[2] = MyPlayingCard(
          suit: MyPlayingCard.StringToSuit(trick3['suit']),
          value: MyPlayingCard.IntToCardValue(trick3['val']));
      center[2].showBack = snapshotGames.docs[0]['showCard'];
    } else {
      center[2] = MyPlayingCard.emptyCard();
    }

    if (snapshotGames.docs[0]['trickCard4']['val'] != 0 &&
        snapshotGames.docs[0]['trickCard4']['suit'] != "") {
      center[3] = MyPlayingCard(
          suit: MyPlayingCard.StringToSuit(trick4['suit']),
          value: MyPlayingCard.IntToCardValue(trick4['val']));
      center[3].showBack = snapshotGames.docs[0]['showCard'];
    } else {
      center[3] = MyPlayingCard.emptyCard();
    }
  }

  @override
  Widget build(BuildContext context) {
    ShapeBorder shape = RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
        side: BorderSide(color: Colors.black, width: 0.5));

    return FutureBuilder(
        future: FirebaseFirestore.instance.collection('room').get(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshotRoom) {
          if (snapshotRoom.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else
            return FutureBuilder(
                future: getUsers(),
                builder: (context, snapshotUsers) {
                  if (snapshotUsers.connectionState ==
                      ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else
                    return StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection('games')
                            .snapshots(),
                        builder: (context, snapshotGames) {
                          final trick1 = snapshotGames.data.docs[0]
                              ['trickCard1'] as Map<String, dynamic>;
                          final trick2 = snapshotGames.data.docs[0]
                              ['trickCard2'] as Map<String, dynamic>;
                          final trick3 = snapshotGames.data.docs[0]
                              ['trickCard3'] as Map<String, dynamic>;
                          final trick4 = snapshotGames.data.docs[0]
                              ['trickCard4'] as Map<String, dynamic>;

                          addTricks(snapshotGames.data, trick1, trick2, trick3,
                              trick4);

                          return MaterialApp(
                              home: Scaffold(
                            backgroundColor: Color.fromRGBO(44, 62, 80, 1.0),
                            body: Align(
                              alignment: Alignment.center,
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(15),
                                      child: Text(
                                        leftUsername +
                                            '\n    ' +
                                            leftRank.toString(),
                                        style: TextStyle(
                                            fontFamily: 'Raleway',
                                            color: Colors.white,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(15),
                                          child: Text(
                                            topUsername +
                                                '\n    ' +
                                                topRank.toString(),
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
                                            width:
                                                (center.length == 1) ? 80 : 280,
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
                                                width: (display.length == 1)
                                                    ? 100
                                                    : 280,
                                                child: (display.length > 1)
                                                    ? FlatCardFan(
                                                        children: display
                                                            .map((e) =>
                                                                GestureDetector(
                                                                  child:
                                                                      Opacity(
                                                                    opacity:
                                                                        (center.isEmpty ||
                                                                                center.length == 4)
                                                                            ? 1
                                                                            : 1,
                                                                    child:
                                                                        IgnorePointer(
                                                                      ignoring: (center.isEmpty ||
                                                                              center.length == 4)
                                                                          ? false
                                                                          : false,
                                                                      child:
                                                                          Container(
                                                                        width:
                                                                            95,
                                                                        child:
                                                                            e,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  onTap: () {
                                                                    nextPlayer(
                                                                        display,
                                                                        e.cardValue,
                                                                        e.cardSuit);
                                                                  },
                                                                ))
                                                            .toList(),
                                                      )
                                                    : GestureDetector(
                                                        child: Container(
                                                          width: 95,
                                                          child: display
                                                              .elementAt(0),
                                                        ),
                                                        onTap: () {},
                                                      )),
                                            Padding(
                                              padding: const EdgeInsets.all(15),
                                              child: Text(
                                                  'Player ' +
                                                      currentPlayerUsername
                                                          .toString() +
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 190,
                                              right: 15,
                                              bottom: 90,
                                              left: 15),
                                          child: Text(
                                            rightUsername +
                                                '\n    ' +
                                                rightRank.toString(),
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 10,
                                              right: 15,
                                              bottom: 10,
                                              left: 15),
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
                        });
                });
        });
  }

  Future<void> nextPlayer(
      List<MyPlayingCard> list, CardValue val, Suit s) async {
    final res = await FirebaseFirestore.instance.collection('games').get();
    switch (res.docs[0]['turn']) {
      case 1:
        MyPlayingCard.getCard(display, s, val, res.docs[0]['turn']);
        FirebaseFirestore.instance
            .collection('games')
            .doc('YpyyMAaFcRzCPbphEfYR')
            .update({
          'turn': 2,
        });
        break;
      case 2:
        MyPlayingCard.getCard(display, s, val, res.docs[0]['turn']);
        FirebaseFirestore.instance
            .collection('games')
            .doc('YpyyMAaFcRzCPbphEfYR')
            .update({
          'turn': 3,
        });
        break;
      case 3:
        MyPlayingCard.getCard(display, s, val, res.docs[0]['turn']);
        FirebaseFirestore.instance
            .collection('games')
            .doc('YpyyMAaFcRzCPbphEfYR')
            .update({
          'turn': 4,
        });
        break;
      case 4:
        MyPlayingCard.getCard(display, s, val, res.docs[0]['turn']);
        FirebaseFirestore.instance
            .collection('games')
            .doc('YpyyMAaFcRzCPbphEfYR')
            .update({
          'turn': 1,
        });
        break;
      default:
    }
  }

  Future<QuerySnapshot> getUsers() async {
    final res = await FirebaseFirestore.instance.collection('users').get();
    userName1 = res.docs[0]['username'];
    userName2 = res.docs[1]['username'];
    userName3 = res.docs[2]['username'];
    userName4 = res.docs[3]['username'];
    uid1 = res.docs[0].id;
    uid2 = res.docs[1].id;
    uid3 = res.docs[2].id;
    uid4 = res.docs[3].id;
    return res;
  }

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

  Map<String, dynamic> cen;
  Future<void> displayCards() async {
    final res = await FirebaseFirestore.instance.collection('games').get();
    cen = await res.docs[0]['deck'] as Map<String, dynamic>;
    if (user.uid == uid1) {
      display.add(MyPlayingCard(
          suit: MyPlayingCard.StringToSuit(cen['card1']['suit']),
          value: MyPlayingCard.IntToCardValue(cen['card1']['val'])));
      display.add(MyPlayingCard(
          suit: MyPlayingCard.StringToSuit(cen['card2']['suit']),
          value: MyPlayingCard.IntToCardValue(cen['card2']['val'])));
      display.add(MyPlayingCard(
          suit: MyPlayingCard.StringToSuit(cen['card3']['suit']),
          value: MyPlayingCard.IntToCardValue(cen['card3']['val'])));
      display.add(MyPlayingCard(
          suit: MyPlayingCard.StringToSuit(cen['card4']['suit']),
          value: MyPlayingCard.IntToCardValue(cen['card4']['val'])));
      display.add(MyPlayingCard(
          suit: MyPlayingCard.StringToSuit(cen['card5']['suit']),
          value: MyPlayingCard.IntToCardValue(cen['card5']['val'])));
      display.add(MyPlayingCard(
          suit: MyPlayingCard.StringToSuit(cen['card6']['suit']),
          value: MyPlayingCard.IntToCardValue(cen['card6']['val'])));
      display.add(MyPlayingCard(
          suit: MyPlayingCard.StringToSuit(cen['card7']['suit']),
          value: MyPlayingCard.IntToCardValue(cen['card7']['val'])));
      display.add(MyPlayingCard(
          suit: MyPlayingCard.StringToSuit(cen['card8']['suit']),
          value: MyPlayingCard.IntToCardValue(cen['card8']['val'])));
      currentPlayerUsername = userName1;
      leftUsername = userName2;
      topUsername = userName3;
      rightUsername = userName4;
      displayedPlayerRank = res.docs[0]['rank1'];
      topRank = res.docs[0]['rank3'];
      rightRank = res.docs[0]['rank4'];
      leftRank = res.docs[0]['rank2'];
    }
    if (user.uid == uid2) {
      display.add(MyPlayingCard(
          suit: MyPlayingCard.StringToSuit(cen['card9']['suit']),
          value: MyPlayingCard.IntToCardValue(cen['card9']['val'])));
      display.add(MyPlayingCard(
          suit: MyPlayingCard.StringToSuit(cen['card10']['suit']),
          value: MyPlayingCard.IntToCardValue(cen['card10']['val'])));
      display.add(MyPlayingCard(
          suit: MyPlayingCard.StringToSuit(cen['card11']['suit']),
          value: MyPlayingCard.IntToCardValue(cen['card11']['val'])));
      display.add(MyPlayingCard(
          suit: MyPlayingCard.StringToSuit(cen['card12']['suit']),
          value: MyPlayingCard.IntToCardValue(cen['card12']['val'])));
      display.add(MyPlayingCard(
          suit: MyPlayingCard.StringToSuit(cen['card13']['suit']),
          value: MyPlayingCard.IntToCardValue(cen['card13']['val'])));
      display.add(MyPlayingCard(
          suit: MyPlayingCard.StringToSuit(cen['card14']['suit']),
          value: MyPlayingCard.IntToCardValue(cen['card14']['val'])));
      display.add(MyPlayingCard(
          suit: MyPlayingCard.StringToSuit(cen['card15']['suit']),
          value: MyPlayingCard.IntToCardValue(cen['card15']['val'])));
      display.add(MyPlayingCard(
          suit: MyPlayingCard.StringToSuit(cen['card16']['suit']),
          value: MyPlayingCard.IntToCardValue(cen['card16']['val'])));
      currentPlayerUsername = userName2;
      leftUsername = userName3;
      topUsername = userName4;
      rightUsername = userName1;
      displayedPlayerRank = res.docs[0]['rank2'];
      topRank = res.docs[0]['rank4'];
      rightRank = res.docs[0]['rank1'];
      leftRank = res.docs[0]['rank3'];
      for (int i = 0; i < 8; i++) {
        display[i].setShowBack(false);
      }
    }
    if (user.uid == uid3) {
      display.add(MyPlayingCard(
          suit: MyPlayingCard.StringToSuit(cen['card17']['suit']),
          value: MyPlayingCard.IntToCardValue(cen['card17']['val'])));
      display.add(MyPlayingCard(
          suit: MyPlayingCard.StringToSuit(cen['card18']['suit']),
          value: MyPlayingCard.IntToCardValue(cen['card18']['val'])));
      display.add(MyPlayingCard(
          suit: MyPlayingCard.StringToSuit(cen['card19']['suit']),
          value: MyPlayingCard.IntToCardValue(cen['card19']['val'])));
      display.add(MyPlayingCard(
          suit: MyPlayingCard.StringToSuit(cen['card20']['suit']),
          value: MyPlayingCard.IntToCardValue(cen['card20']['val'])));
      display.add(MyPlayingCard(
          suit: MyPlayingCard.StringToSuit(cen['card21']['suit']),
          value: MyPlayingCard.IntToCardValue(cen['card21']['val'])));
      display.add(MyPlayingCard(
          suit: MyPlayingCard.StringToSuit(cen['card22']['suit']),
          value: MyPlayingCard.IntToCardValue(cen['card22']['val'])));
      display.add(MyPlayingCard(
          suit: MyPlayingCard.StringToSuit(cen['card23']['suit']),
          value: MyPlayingCard.IntToCardValue(cen['card23']['val'])));
      display.add(MyPlayingCard(
          suit: MyPlayingCard.StringToSuit(cen['card24']['suit']),
          value: MyPlayingCard.IntToCardValue(cen['card24']['val'])));
      currentPlayerUsername = userName3;
      leftUsername = userName4;
      topUsername = userName1;
      rightUsername = userName2;
      displayedPlayerRank = res.docs[0]['rank3'];
      topRank = res.docs[0]['rank1'];
      rightRank = res.docs[0]['rank2'];
      leftRank = res.docs[0]['rank4'];
      for (int i = 0; i < 8; i++) {
        display[i].setShowBack(false);
      }
    }
    if (user.uid == uid4) {
      display.add(MyPlayingCard(
          suit: MyPlayingCard.StringToSuit(cen['card25']['suit']),
          value: MyPlayingCard.IntToCardValue(cen['card25']['val'])));
      display.add(MyPlayingCard(
          suit: MyPlayingCard.StringToSuit(cen['card26']['suit']),
          value: MyPlayingCard.IntToCardValue(cen['card26']['val'])));
      display.add(MyPlayingCard(
          suit: MyPlayingCard.StringToSuit(cen['card27']['suit']),
          value: MyPlayingCard.IntToCardValue(cen['card27']['val'])));
      display.add(MyPlayingCard(
          suit: MyPlayingCard.StringToSuit(cen['card28']['suit']),
          value: MyPlayingCard.IntToCardValue(cen['card28']['val'])));
      display.add(MyPlayingCard(
          suit: MyPlayingCard.StringToSuit(cen['card29']['suit']),
          value: MyPlayingCard.IntToCardValue(cen['card29']['val'])));
      display.add(MyPlayingCard(
          suit: MyPlayingCard.StringToSuit(cen['card30']['suit']),
          value: MyPlayingCard.IntToCardValue(cen['card30']['val'])));
      display.add(MyPlayingCard(
          suit: MyPlayingCard.StringToSuit(cen['card31']['suit']),
          value: MyPlayingCard.IntToCardValue(cen['card31']['val'])));
      display.add(MyPlayingCard(
          suit: MyPlayingCard.StringToSuit(cen['card32']['suit']),
          value: MyPlayingCard.IntToCardValue(cen['card32']['val'])));
      currentPlayerUsername = userName4;
      leftUsername = userName1;
      topUsername = userName2;
      rightUsername = userName3;
      displayedPlayerRank = res.docs[0]['rank4'];
      topRank = res.docs[0]['rank2'];
      rightRank = res.docs[0]['rank3'];
      leftRank = res.docs[0]['rank1'];
      for (int i = 0; i < 8; i++) {
        display[i].setShowBack(false);
      }
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
                    return ((player1[0] == MyPlayingCard.emptyCard() ||
                                player1 == null) &&
                            (player2[0] == MyPlayingCard.emptyCard() ||
                                player2 == null) &&
                            (player3[0] == MyPlayingCard.emptyCard() ||
                                player3 == null) &&
                            (player4[0] == MyPlayingCard.emptyCard() ||
                                player4 == null))
                        ? GestureDetector(
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
                          )
                        : Card(
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
                          );
                  }).toList(),
                ),
              ),
            ]),
          );
        });
  }

  void _onTap(Text z) {
    setState(() {
      switch (z.data) {
        case 'No Tricks':
          enabledGame[0] = false;
          print(enabledGame);
          break;
        case 'No king of spades':
          enabledGame[1] = false;
          print(enabledGame);
          break;
        case 'No last one':
          enabledGame[2] = false;
          print(enabledGame);
          break;
        case 'No hearts':
          enabledGame[3] = false;
          print(enabledGame);
          break;
        case 'No queens':
          enabledGame[4] = false;
          print(enabledGame);
          break;
        case 'Dominoes':
          enabledGame[5] = false;
          print(enabledGame);
          break;
        case 'Trumps':
          enabledGame[6] = false;
          print(enabledGame);
          break;
      }
    });
  }
}
