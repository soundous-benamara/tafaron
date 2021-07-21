import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:playing_cards/playing_cards.dart';
import 'package:flutter/services.dart';
import 'package:turns/MyPlayingCards.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:turns/StartNewGame.dart';
import 'package:turns/auth_screen.dart';

import 'Dominoes.dart';
import 'NoHearts.dart';
import 'NoKingOfSpades.dart';
import 'NoLastOne.dart';
import 'NoQueens.dart';
import 'NoTrick.dart';
import 'Trumps.dart';

class ChooseGame extends StatefulWidget {
  @override
  _ChooseGameState createState() => _ChooseGameState();
}

class _ChooseGameState extends State<ChooseGame> {
  Map<String, dynamic> shuffledDeck;

  String uid1, uid2, uid3, uid4;

  String userName1, userName2, userName3, userName4;

  String leftUsername, rightUsername, topUsername, currentPlayerUsername;

  User user;

  List<MyPlayingCard> display = [];

  List<Text> games = [];

  List<String> textGame = [];

  List<bool> enabledGame = [];

  bool isClicked;

  String currentGame;

  @override
  void initState() {
    addDeck();
    getUsers();
//fill the array of the games
    textGame.add('No Tricks');
    textGame.add('No king of spades');
    textGame.add('No last one');
    textGame.add('No hearts');
    textGame.add('No queens');
    textGame.add('Dominoes');
    textGame.add('Trumps');
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

    display.add(MyPlayingCard.emptyCard());
    display.add(MyPlayingCard.emptyCard());
    display.add(MyPlayingCard.emptyCard());
    display.add(MyPlayingCard.emptyCard());
    display.add(MyPlayingCard.emptyCard());
    display.add(MyPlayingCard.emptyCard());
    display.add(MyPlayingCard.emptyCard());
    display.add(MyPlayingCard.emptyCard());

    isClicked = false;

    currentGame = '';

    SystemChrome.setEnabledSystemUIOverlays([]);
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
                          final currentDeck = snapshotGames.data.docs[0]['deck']
                              as Map<String, dynamic>;

                          if (snapshotGames.data.docs[0]['isDistributed'] ==
                              true) {
                            displayCards(snapshotGames.data, currentDeck);
                            updateData('isDistributed', false);
                          }
                          if (snapshotGames.data.docs[0]['isGameChosen'] ==
                              true) {
                            Fluttertoast.showToast(
                              msg: snapshotGames.data.docs[0]['currentGame'],
                              backgroundColor: Colors.black,
                              gravity: ToastGravity.CENTER,
                              toastLength: Toast.LENGTH_LONG,
                              textColor: Colors.white,
                              timeInSecForIosWeb: 1,
                              fontSize: 20,
                            );

                            Future.delayed(Duration(seconds: 2), () {
                              updateData('isGameChosen', false);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => NoTrick()),
                              );
                            });
                          }

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
                                        leftUsername,
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
                                            topUsername,
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
                                              child: Text(currentPlayerUsername,
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
                                            rightUsername,
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

  Future<void> addDeck() async {
    MyPlayingCard.ALL_CARDS.shuffle();
    final newDeckDoc = {
      'deck': MyPlayingCard.ALL_CARDS.asMap().map(
            (i, value) => MapEntry("card${i + 1}", {
              'val': MyPlayingCard.CardValueToInt(value.cardValue),
              'suit': MyPlayingCard.SuitToString(value.cardSuit),
            }),
          ),
    };
    await FirebaseFirestore.instance
        .collection('games')
        .doc('YpyyMAaFcRzCPbphEfYR')
        .update(newDeckDoc);

    updateData('isDistributed', true);
  }

  void displayCards(
      QuerySnapshot snapshotGames, Map<String, dynamic> currentDeck) {
    if (user.uid == uid1) {
      display[0] = MyPlayingCard(
          suit: MyPlayingCard.StringToSuit(currentDeck['card1']['suit']),
          value: MyPlayingCard.IntToCardValue(currentDeck['card1']['val']));
      display[1] = MyPlayingCard(
          suit: MyPlayingCard.StringToSuit(currentDeck['card2']['suit']),
          value: MyPlayingCard.IntToCardValue(currentDeck['card2']['val']));
      display[2] = MyPlayingCard(
          suit: MyPlayingCard.StringToSuit(currentDeck['card3']['suit']),
          value: MyPlayingCard.IntToCardValue(currentDeck['card3']['val']));
      display[3] = MyPlayingCard(
          suit: MyPlayingCard.StringToSuit(currentDeck['card4']['suit']),
          value: MyPlayingCard.IntToCardValue(currentDeck['card4']['val']));
      display[4] = MyPlayingCard(
          suit: MyPlayingCard.StringToSuit(currentDeck['card5']['suit']),
          value: MyPlayingCard.IntToCardValue(currentDeck['card5']['val']));
      display[5] = MyPlayingCard(
          suit: MyPlayingCard.StringToSuit(currentDeck['card6']['suit']),
          value: MyPlayingCard.IntToCardValue(currentDeck['card6']['val']));
      display[6] = MyPlayingCard(
          suit: MyPlayingCard.StringToSuit(currentDeck['card7']['suit']),
          value: MyPlayingCard.IntToCardValue(currentDeck['card7']['val']));
      display[7] = MyPlayingCard(
          suit: MyPlayingCard.StringToSuit(currentDeck['card8']['suit']),
          value: MyPlayingCard.IntToCardValue(currentDeck['card8']['val']));
      currentPlayerUsername = userName1;
      leftUsername = userName2;
      topUsername = userName3;
      rightUsername = userName4;
    }
    if (user.uid == uid2) {
      display[0] = MyPlayingCard(
          suit: MyPlayingCard.StringToSuit(currentDeck['card9']['suit']),
          value: MyPlayingCard.IntToCardValue(currentDeck['card9']['val']));
      display[1] = MyPlayingCard(
          suit: MyPlayingCard.StringToSuit(currentDeck['card10']['suit']),
          value: MyPlayingCard.IntToCardValue(currentDeck['card10']['val']));
      display[2] = MyPlayingCard(
          suit: MyPlayingCard.StringToSuit(currentDeck['card11']['suit']),
          value: MyPlayingCard.IntToCardValue(currentDeck['card11']['val']));
      display[3] = MyPlayingCard(
          suit: MyPlayingCard.StringToSuit(currentDeck['card12']['suit']),
          value: MyPlayingCard.IntToCardValue(currentDeck['card12']['val']));
      display[4] = MyPlayingCard(
          suit: MyPlayingCard.StringToSuit(currentDeck['card13']['suit']),
          value: MyPlayingCard.IntToCardValue(currentDeck['card13']['val']));
      display[5] = MyPlayingCard(
          suit: MyPlayingCard.StringToSuit(currentDeck['card14']['suit']),
          value: MyPlayingCard.IntToCardValue(currentDeck['card14']['val']));
      display[6] = MyPlayingCard(
          suit: MyPlayingCard.StringToSuit(currentDeck['card15']['suit']),
          value: MyPlayingCard.IntToCardValue(currentDeck['card15']['val']));
      display[7] = MyPlayingCard(
          suit: MyPlayingCard.StringToSuit(currentDeck['card16']['suit']),
          value: MyPlayingCard.IntToCardValue(currentDeck['card16']['val']));
      currentPlayerUsername = userName2;
      leftUsername = userName3;
      topUsername = userName4;
      rightUsername = userName1;
    }
    if (user.uid == uid3) {
      display[0] = MyPlayingCard(
          suit: MyPlayingCard.StringToSuit(currentDeck['card17']['suit']),
          value: MyPlayingCard.IntToCardValue(currentDeck['card17']['val']));
      display[1] = MyPlayingCard(
          suit: MyPlayingCard.StringToSuit(currentDeck['card18']['suit']),
          value: MyPlayingCard.IntToCardValue(currentDeck['card18']['val']));
      display[2] = MyPlayingCard(
          suit: MyPlayingCard.StringToSuit(currentDeck['card19']['suit']),
          value: MyPlayingCard.IntToCardValue(currentDeck['card19']['val']));
      display[3] = MyPlayingCard(
          suit: MyPlayingCard.StringToSuit(currentDeck['card20']['suit']),
          value: MyPlayingCard.IntToCardValue(currentDeck['card20']['val']));
      display[4] = MyPlayingCard(
          suit: MyPlayingCard.StringToSuit(currentDeck['card21']['suit']),
          value: MyPlayingCard.IntToCardValue(currentDeck['card21']['val']));
      display[5] = MyPlayingCard(
          suit: MyPlayingCard.StringToSuit(currentDeck['card22']['suit']),
          value: MyPlayingCard.IntToCardValue(currentDeck['card22']['val']));
      display[6] = MyPlayingCard(
          suit: MyPlayingCard.StringToSuit(currentDeck['card23']['suit']),
          value: MyPlayingCard.IntToCardValue(currentDeck['card23']['val']));
      display[7] = MyPlayingCard(
          suit: MyPlayingCard.StringToSuit(currentDeck['card24']['suit']),
          value: MyPlayingCard.IntToCardValue(currentDeck['card24']['val']));
      currentPlayerUsername = userName3;
      leftUsername = userName4;
      topUsername = userName1;
      rightUsername = userName2;
    }
    if (user.uid == uid4) {
      display[0] = MyPlayingCard(
          suit: MyPlayingCard.StringToSuit(currentDeck['card25']['suit']),
          value: MyPlayingCard.IntToCardValue(currentDeck['card25']['val']));
      display[1] = MyPlayingCard(
          suit: MyPlayingCard.StringToSuit(currentDeck['card26']['suit']),
          value: MyPlayingCard.IntToCardValue(currentDeck['card26']['val']));
      display[2] = MyPlayingCard(
          suit: MyPlayingCard.StringToSuit(currentDeck['card27']['suit']),
          value: MyPlayingCard.IntToCardValue(currentDeck['card27']['val']));
      display[3] = MyPlayingCard(
          suit: MyPlayingCard.StringToSuit(currentDeck['card28']['suit']),
          value: MyPlayingCard.IntToCardValue(currentDeck['card28']['val']));
      display[4] = MyPlayingCard(
          suit: MyPlayingCard.StringToSuit(currentDeck['card29']['suit']),
          value: MyPlayingCard.IntToCardValue(currentDeck['card29']['val']));
      display[5] = MyPlayingCard(
          suit: MyPlayingCard.StringToSuit(currentDeck['card30']['suit']),
          value: MyPlayingCard.IntToCardValue(currentDeck['card30']['val']));
      display[6] = MyPlayingCard(
          suit: MyPlayingCard.StringToSuit(currentDeck['card31']['suit']),
          value: MyPlayingCard.IntToCardValue(currentDeck['card31']['val']));
      display[7] = MyPlayingCard(
          suit: MyPlayingCard.StringToSuit(currentDeck['card32']['suit']),
          value: MyPlayingCard.IntToCardValue(currentDeck['card32']['val']));
      currentPlayerUsername = userName4;
      leftUsername = userName1;
      topUsername = userName2;
      rightUsername = userName3;
    }
    display[0].showBack = false;
    display[1].showBack = false;
    display[2].showBack = false;
    display[3].showBack = false;
    display[4].showBack = false;
    display[5].showBack = false;
    display[6].showBack = false;
    display[7].showBack = false;
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

  Future<void> chosenGame(String clicked) async {
    currentGame = clicked;
    switch (clicked) {
      case 'No Tricks':
        await FirebaseFirestore.instance
            .collection('games')
            .doc('YpyyMAaFcRzCPbphEfYR')
            .update({'currentGame': 'No Tricks', 'isGameChosen': true});
        break;
      case 'No king of spades':
        break;
      case 'No last one':
        break;
      case 'No hearts':
        break;
      case 'No queens':
        break;
      case 'Dominoes':
        break;
      case 'Trumps':
        break;
    }
  }

  Future<void> _onTap(Text z) async {
    isClicked = true;
    switch (z.data) {
      case 'No Tricks':
        enabledGame[0] = false;
        await FirebaseFirestore.instance
            .collection('games')
            .doc('YpyyMAaFcRzCPbphEfYR')
            .update({'currentGame': 'No Tricks', 'isGameChosen': true});
        break;
      case 'No king of spades':
        enabledGame[1] = false;
        Future.delayed(Duration(seconds: 3), () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => NoKingOfSpades()),
          );
        });
        break;
      case 'No last one':
        enabledGame[2] = false;
        Future.delayed(Duration(seconds: 3), () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => NoLastOne()),
          );
        });
        break;
      case 'No hearts':
        enabledGame[3] = false;
        Future.delayed(Duration(seconds: 3), () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => NoHearts()),
          );
        });
        break;
      case 'No queens':
        enabledGame[4] = false;
        Future.delayed(Duration(seconds: 3), () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => NoQueens()),
          );
        });
        break;
      case 'Dominoes':
        enabledGame[5] = false;
        Future.delayed(Duration(seconds: 3), () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Dominoes()),
          );
        });
        break;
      case 'Trumps':
        enabledGame[6] = false;
        Future.delayed(Duration(seconds: 3), () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Trumps()),
          );
        });
        break;
    }
  }

  Future<void> updateData(String str, bool b) async {
    await FirebaseFirestore.instance
        .collection('games')
        .doc('YpyyMAaFcRzCPbphEfYR')
        .update({str: b});
  }
}
