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

  List<MyPlayingCard> center = [];
  Map<String, dynamic> cen;

  User user;
  String uid1, uid2, uid3, uid4;

  Map<String, dynamic> p1;
  Map<String, dynamic> p2;
  Map<String, dynamic> p3;
  Map<String, dynamic> p4;
  MyPlayingCard c1;
  MyPlayingCard c2;
  MyPlayingCard c3;
  MyPlayingCard c4;

  Map<String, dynamic> shuffledDeck;

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

  void getCenter() async {
    final res = await FirebaseFirestore.instance.collection('games').get();

    cen = await res.docs[0]['center'] as Map<String, dynamic>;
    center[0] = MyPlayingCard(
        value: MyPlayingCard.IntToCardValue(cen['card1']['val']),
        suit: MyPlayingCard.StringToSuit(cen['card1']['suit']));
    center[0].showBack = cen['showback'];
    center[1] = MyPlayingCard(
        value: MyPlayingCard.IntToCardValue(cen['card2']['val']),
        suit: MyPlayingCard.StringToSuit(cen['card2']['suit']));
    center[1].showBack = cen['showback'];
    center[2] = MyPlayingCard(
        value: MyPlayingCard.IntToCardValue(cen['card3']['val']),
        suit: MyPlayingCard.StringToSuit(cen['card3']['suit']));
    center[2].showBack = cen['showback'];
    center[3] = MyPlayingCard(
        value: MyPlayingCard.IntToCardValue(cen['card4']['val']),
        suit: MyPlayingCard.StringToSuit(cen['card4']['suit']));
    center[3].showBack = cen['showback'];
  }

  String userName1, userName2, userName3, userName4;
  @override
  void initState() {
    super.initState();
    getCenter();

    user = FirebaseAuth.instance.currentUser;

    userName1 = '';
    userName2 = '';
    userName3 = '';
    userName4 = '';

    rank.add(0);
    rank.add(0);
    rank.add(0);
    rank.add(0);

    SystemChrome.setEnabledSystemUIOverlays([]);

    center.add(MyPlayingCard.emptyCard());
    center.add(MyPlayingCard.emptyCard());
    center.add(MyPlayingCard.emptyCard());
    center.add(MyPlayingCard.emptyCard());

    deck.add(MyPlayingCard.emptyCard());
    right.add(MyPlayingCard.emptyCard());
    top.add(MyPlayingCard.emptyCard());
    left.add(MyPlayingCard.emptyCard());
    //MyPlayingCard.ALL_CARDS.shuffle();

    _enabled = true;

    SystemChrome.setEnabledSystemUIOverlays([]);
  }

  bool isInit = false;
  @override
  void didchangeDependencies() {
    super.didChangeDependencies();
    if (!isInit) {
      isInit = true;
      initState();
    }
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

  @override
  Widget build(BuildContext context) {
    ShapeBorder shape = RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
        side: BorderSide(color: Colors.black, width: 0.5));

    return FutureBuilder(
        future: FirebaseFirestore.instance.collection('room').get(),
        builder: (context, snapshotRoom) {
          if (snapshotRoom.connectionState == ConnectionState.waiting) {
            CircularProgressIndicator();
          } else
            return FutureBuilder(
                future: getUsers(),
                builder: (context, snapshotUsers) {
                  if (snapshotUsers.connectionState ==
                      ConnectionState.waiting) {
                    CircularProgressIndicator();
                  } else
                    return StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection('games')
                            .snapshots(),
                        builder: (context, snapshotGames) {
                          if (snapshotGames.data == null ||
                              snapshotRoom.data == null ||
                              snapshotUsers.data == null ||
                              snapshotUsers.data.docs[3]['username'] == null) {
                            Center(
                              child: CircularProgressIndicator(),
                            );
                          }

                          print(snapshotGames.data.docs[0]['deck']['card1']);
                          print(snapshotGames.data.docs[0]['deck']['card2']);
                          print(snapshotGames.data.docs[0]['deck']['card3']);
                          print(snapshotGames.data.docs[0]['deck']['card4']);
                          print("*****************");
                          print("$shuffledDeck['card1']");
                          print("$shuffledDeck['card2']");
                          print("$shuffledDeck['card3']");
                          print("$shuffledDeck['card4']");
                          return buildGameBoard(
                              snapshotGames, snapshotUsers, snapshotRoom);
                        });
                });
        });
  }

  Future<void> addDeck() async {
    MyPlayingCard.ALL_CARDS.shuffle();
    await FirebaseFirestore.instance
        .collection('games')
        .doc('YpyyMAaFcRzCPbphEfYR')
        .update({
      'deck': {
        'card1': {
          'val': MyPlayingCard.CardValueToInt(
              MyPlayingCard.ALL_CARDS[0].cardValue),
          'suit':
              MyPlayingCard.SuitToString(MyPlayingCard.ALL_CARDS[0].cardSuit),
        },
        'card2': {
          'val': MyPlayingCard.CardValueToInt(
              MyPlayingCard.ALL_CARDS[1].cardValue),
          'suit':
              MyPlayingCard.SuitToString(MyPlayingCard.ALL_CARDS[1].cardSuit),
        },
        'card3': {
          'val': MyPlayingCard.CardValueToInt(
              MyPlayingCard.ALL_CARDS[2].cardValue),
          'suit':
              MyPlayingCard.SuitToString(MyPlayingCard.ALL_CARDS[2].cardSuit),
        },
        'card4': {
          'val': MyPlayingCard.CardValueToInt(
              MyPlayingCard.ALL_CARDS[3].cardValue),
          'suit':
              MyPlayingCard.SuitToString(MyPlayingCard.ALL_CARDS[3].cardSuit),
        },
        'card5': {
          'val': MyPlayingCard.CardValueToInt(
              MyPlayingCard.ALL_CARDS[4].cardValue),
          'suit':
              MyPlayingCard.SuitToString(MyPlayingCard.ALL_CARDS[4].cardSuit),
        },
        'card6': {
          'val': MyPlayingCard.CardValueToInt(
              MyPlayingCard.ALL_CARDS[5].cardValue),
          'suit':
              MyPlayingCard.SuitToString(MyPlayingCard.ALL_CARDS[5].cardSuit),
        },
        'card7': {
          'val': MyPlayingCard.CardValueToInt(
              MyPlayingCard.ALL_CARDS[6].cardValue),
          'suit':
              MyPlayingCard.SuitToString(MyPlayingCard.ALL_CARDS[6].cardSuit),
        },
        'card8': {
          'val': MyPlayingCard.CardValueToInt(
              MyPlayingCard.ALL_CARDS[7].cardValue),
          'suit':
              MyPlayingCard.SuitToString(MyPlayingCard.ALL_CARDS[7].cardSuit),
        },
        'card9': {
          'val': MyPlayingCard.CardValueToInt(
              MyPlayingCard.ALL_CARDS[8].cardValue),
          'suit':
              MyPlayingCard.SuitToString(MyPlayingCard.ALL_CARDS[8].cardSuit),
        },
        'card10': {
          'val': MyPlayingCard.CardValueToInt(
              MyPlayingCard.ALL_CARDS[9].cardValue),
          'suit':
              MyPlayingCard.SuitToString(MyPlayingCard.ALL_CARDS[9].cardSuit),
        },
        'card11': {
          'val': MyPlayingCard.CardValueToInt(
              MyPlayingCard.ALL_CARDS[10].cardValue),
          'suit':
              MyPlayingCard.SuitToString(MyPlayingCard.ALL_CARDS[10].cardSuit),
        },
        'card12': {
          'val': MyPlayingCard.CardValueToInt(
              MyPlayingCard.ALL_CARDS[11].cardValue),
          'suit':
              MyPlayingCard.SuitToString(MyPlayingCard.ALL_CARDS[11].cardSuit),
        },
        'card13': {
          'val': MyPlayingCard.CardValueToInt(
              MyPlayingCard.ALL_CARDS[12].cardValue),
          'suit':
              MyPlayingCard.SuitToString(MyPlayingCard.ALL_CARDS[12].cardSuit),
        },
        'card14': {
          'val': MyPlayingCard.CardValueToInt(
              MyPlayingCard.ALL_CARDS[13].cardValue),
          'suit':
              MyPlayingCard.SuitToString(MyPlayingCard.ALL_CARDS[13].cardSuit),
        },
        'card15': {
          'val': MyPlayingCard.CardValueToInt(
              MyPlayingCard.ALL_CARDS[14].cardValue),
          'suit':
              MyPlayingCard.SuitToString(MyPlayingCard.ALL_CARDS[14].cardSuit),
        },
        'card16': {
          'val': MyPlayingCard.CardValueToInt(
              MyPlayingCard.ALL_CARDS[15].cardValue),
          'suit':
              MyPlayingCard.SuitToString(MyPlayingCard.ALL_CARDS[15].cardSuit),
        },
        'card17': {
          'val': MyPlayingCard.CardValueToInt(
              MyPlayingCard.ALL_CARDS[16].cardValue),
          'suit':
              MyPlayingCard.SuitToString(MyPlayingCard.ALL_CARDS[16].cardSuit),
        },
        'card18': {
          'val': MyPlayingCard.CardValueToInt(
              MyPlayingCard.ALL_CARDS[17].cardValue),
          'suit':
              MyPlayingCard.SuitToString(MyPlayingCard.ALL_CARDS[17].cardSuit),
        },
        'card19': {
          'val': MyPlayingCard.CardValueToInt(
              MyPlayingCard.ALL_CARDS[18].cardValue),
          'suit':
              MyPlayingCard.SuitToString(MyPlayingCard.ALL_CARDS[18].cardSuit),
        },
        'card20': {
          'val': MyPlayingCard.CardValueToInt(
              MyPlayingCard.ALL_CARDS[19].cardValue),
          'suit':
              MyPlayingCard.SuitToString(MyPlayingCard.ALL_CARDS[19].cardSuit),
        },
        'card21': {
          'val': MyPlayingCard.CardValueToInt(
              MyPlayingCard.ALL_CARDS[20].cardValue),
          'suit':
              MyPlayingCard.SuitToString(MyPlayingCard.ALL_CARDS[20].cardSuit),
        },
        'card22': {
          'val': MyPlayingCard.CardValueToInt(
              MyPlayingCard.ALL_CARDS[21].cardValue),
          'suit':
              MyPlayingCard.SuitToString(MyPlayingCard.ALL_CARDS[21].cardSuit),
        },
        'card23': {
          'val': MyPlayingCard.CardValueToInt(
              MyPlayingCard.ALL_CARDS[22].cardValue),
          'suit':
              MyPlayingCard.SuitToString(MyPlayingCard.ALL_CARDS[22].cardSuit),
        },
        'card24': {
          'val': MyPlayingCard.CardValueToInt(
              MyPlayingCard.ALL_CARDS[23].cardValue),
          'suit':
              MyPlayingCard.SuitToString(MyPlayingCard.ALL_CARDS[23].cardSuit),
        },
        'card25': {
          'val': MyPlayingCard.CardValueToInt(
              MyPlayingCard.ALL_CARDS[24].cardValue),
          'suit':
              MyPlayingCard.SuitToString(MyPlayingCard.ALL_CARDS[24].cardSuit),
        },
        'card26': {
          'val': MyPlayingCard.CardValueToInt(
              MyPlayingCard.ALL_CARDS[25].cardValue),
          'suit':
              MyPlayingCard.SuitToString(MyPlayingCard.ALL_CARDS[25].cardSuit),
        },
        'card27': {
          'val': MyPlayingCard.CardValueToInt(
              MyPlayingCard.ALL_CARDS[26].cardValue),
          'suit':
              MyPlayingCard.SuitToString(MyPlayingCard.ALL_CARDS[26].cardSuit),
        },
        'card28': {
          'val': MyPlayingCard.CardValueToInt(
              MyPlayingCard.ALL_CARDS[27].cardValue),
          'suit':
              MyPlayingCard.SuitToString(MyPlayingCard.ALL_CARDS[27].cardSuit),
        },
      }
    });
  }

  Future<void> displayerCards(snapshotGames) async {
    final res = await FirebaseFirestore.instance.collection('games').get();

    setState(() {
      shuffledDeck = res.docs[0]['deck'] as Map<String, dynamic>;
    });
    if (user.uid == uid1) {
      deck.clear();
      deck.add(MyPlayingCard(
          suit: MyPlayingCard.StringToSuit(shuffledDeck['card1']['suit']),
          value: MyPlayingCard.IntToCardValue(shuffledDeck['card1']['val'])));
      left.clear();
      left.add(MyPlayingCard(
          suit: MyPlayingCard.StringToSuit(shuffledDeck['card2']['suit']),
          value: MyPlayingCard.IntToCardValue(shuffledDeck['card2']['val'])));
      top.clear();
      top.add(MyPlayingCard(
          suit: MyPlayingCard.StringToSuit(shuffledDeck['card3']['suit']),
          value: MyPlayingCard.IntToCardValue(shuffledDeck['card3']['val'])));
      right.clear();
      right.add(MyPlayingCard(
          suit: MyPlayingCard.StringToSuit(shuffledDeck['card4']['suit']),
          value: MyPlayingCard.IntToCardValue(shuffledDeck['card4']['val'])));
      rank[0] = shuffledDeck['card1']['val'];
      rank[1] = shuffledDeck['card2']['val'];
      rank[2] = shuffledDeck['card3']['val'];
      rank[3] = shuffledDeck['card4']['val'];
      deck[0].showBack = snapshotGames.data.docs[0]['showCard'];
      left[0].showBack = snapshotGames.data.docs[0]['showCard'];
      right[0].showBack = snapshotGames.data.docs[0]['showCard'];
      top[0].showBack = snapshotGames.data.docs[0]['showCard'];
      setState(() {});
    }
    if (user.uid == uid2) {
      deck.clear();
      deck.add(MyPlayingCard(
          suit: MyPlayingCard.StringToSuit(shuffledDeck['card2']['suit']),
          value: MyPlayingCard.IntToCardValue(shuffledDeck['card2']['val'])));
      left.clear();
      left.add(MyPlayingCard(
          suit: MyPlayingCard.StringToSuit(shuffledDeck['card3']['suit']),
          value: MyPlayingCard.IntToCardValue(shuffledDeck['card3']['val'])));
      top.clear();
      top.add(MyPlayingCard(
          suit: MyPlayingCard.StringToSuit(shuffledDeck['card4']['suit']),
          value: MyPlayingCard.IntToCardValue(shuffledDeck['card4']['val'])));
      right.clear();
      right.add(MyPlayingCard(
          suit: MyPlayingCard.StringToSuit(shuffledDeck['card1']['suit']),
          value: MyPlayingCard.IntToCardValue(shuffledDeck['card1']['val'])));
      rank[0] = shuffledDeck['card1']['val'];
      rank[1] = shuffledDeck['card2']['val'];
      rank[2] = shuffledDeck['card3']['val'];
      rank[3] = shuffledDeck['card4']['val'];
      deck[0].showBack = snapshotGames.data.docs[0]['showCard'];
      left[0].showBack = snapshotGames.data.docs[0]['showCard'];
      right[0].showBack = snapshotGames.data.docs[0]['showCard'];
      top[0].showBack = snapshotGames.data.docs[0]['showCard'];
      setState(() {});
    }
    if (user.uid == uid3) {
      deck.clear();
      deck.add(MyPlayingCard(
          suit: MyPlayingCard.StringToSuit(shuffledDeck['card3']['suit']),
          value: MyPlayingCard.IntToCardValue(shuffledDeck['card3']['val'])));
      left.clear();
      left.add(MyPlayingCard(
          suit: MyPlayingCard.StringToSuit(shuffledDeck['card4']['suit']),
          value: MyPlayingCard.IntToCardValue(shuffledDeck['card4']['val'])));
      top.clear();
      top.add(MyPlayingCard(
          suit: MyPlayingCard.StringToSuit(shuffledDeck['card1']['suit']),
          value: MyPlayingCard.IntToCardValue(shuffledDeck['card1']['val'])));
      right.clear();
      right.add(MyPlayingCard(
          suit: MyPlayingCard.StringToSuit(shuffledDeck['card2']['suit']),
          value: MyPlayingCard.IntToCardValue(shuffledDeck['card2']['val'])));
      rank[0] = shuffledDeck['card1']['val'];
      rank[1] = shuffledDeck['card2']['val'];
      rank[2] = shuffledDeck['card3']['val'];
      rank[3] = shuffledDeck['card4']['val'];
      deck[0].showBack = snapshotGames.data.docs[0]['showCard'];
      left[0].showBack = snapshotGames.data.docs[0]['showCard'];
      right[0].showBack = snapshotGames.data.docs[0]['showCard'];
      top[0].showBack = snapshotGames.data.docs[0]['showCard'];
      setState(() {});
    }
    if (user.uid == uid4) {
      deck.clear();
      deck.add(MyPlayingCard(
          suit: MyPlayingCard.StringToSuit(shuffledDeck['card4']['suit']),
          value: MyPlayingCard.IntToCardValue(shuffledDeck['card4']['val'])));
      left.clear();
      left.add(MyPlayingCard(
          suit: MyPlayingCard.StringToSuit(shuffledDeck['card1']['suit']),
          value: MyPlayingCard.IntToCardValue(shuffledDeck['card1']['val'])));
      top.clear();
      top.add(MyPlayingCard(
          suit: MyPlayingCard.StringToSuit(shuffledDeck['card2']['suit']),
          value: MyPlayingCard.IntToCardValue(shuffledDeck['card2']['val'])));
      right.clear();
      right.add(MyPlayingCard(
          suit: MyPlayingCard.StringToSuit(shuffledDeck['card3']['suit']),
          value: MyPlayingCard.IntToCardValue(shuffledDeck['card3']['val'])));
      rank[0] = shuffledDeck['card1']['val'];
      rank[1] = shuffledDeck['card2']['val'];
      rank[2] = shuffledDeck['card3']['val'];
      rank[3] = shuffledDeck['card4']['val'];
      deck[0].showBack = snapshotGames.data.docs[0]['showCard'];
      left[0].showBack = snapshotGames.data.docs[0]['showCard'];
      right[0].showBack = snapshotGames.data.docs[0]['showCard'];
      top[0].showBack = snapshotGames.data.docs[0]['showCard'];
      setState(() {});
    }
  }

  Future<void> getFirstPlayer() async {
    indexOfPlayer = 0;
    maxVal = rank[0];
    for (int index = 1; index < rank.length; index++) {
      if (rank.elementAt(index) < maxVal) {
        maxVal = rank.elementAt(index);
        indexOfPlayer = index;
      }
      print(maxVal);
    }
    switch (indexOfPlayer) {
      case 0:
        Future.delayed(Duration(seconds: 2), () {
          Fluttertoast.showToast(
            msg: userName1 + ' will start the game !!',
            backgroundColor: Colors.black,
            gravity: ToastGravity.CENTER,
            toastLength: Toast.LENGTH_LONG,
            textColor: Colors.white,
            timeInSecForIosWeb: 1,
            fontSize: 17,
          );
        });
        await FirebaseFirestore.instance
            .collection('games')
            .doc('YpyyMAaFcRzCPbphEfYR')
            .update({'firstPlayer': uid1});

        break;

      case 1:
        Future.delayed(Duration(seconds: 2), () {
          Fluttertoast.showToast(
            msg: userName2 + ' will start the game !!',
            backgroundColor: Colors.black,
            gravity: ToastGravity.CENTER,
            toastLength: Toast.LENGTH_LONG,
            textColor: Colors.white,
            timeInSecForIosWeb: 1,
            fontSize: 17,
          );
        });
        await FirebaseFirestore.instance
            .collection('games')
            .doc('YpyyMAaFcRzCPbphEfYR')
            .update({'firstPlayer': uid2});

        break;

      case 2:
        Future.delayed(Duration(seconds: 2), () {
          Fluttertoast.showToast(
            msg: userName3 + ' will start the game !!',
            backgroundColor: Colors.black,
            gravity: ToastGravity.CENTER,
            toastLength: Toast.LENGTH_LONG,
            textColor: Colors.white,
            timeInSecForIosWeb: 1,
            fontSize: 17,
          );
        });
        await FirebaseFirestore.instance
            .collection('games')
            .doc('YpyyMAaFcRzCPbphEfYR')
            .update({'firstPlayer': uid3});

        break;

      case 3:
        Future.delayed(Duration(seconds: 2), () {
          Fluttertoast.showToast(
            msg: userName4 + ' will start the game !!',
            backgroundColor: Colors.black,
            gravity: ToastGravity.CENTER,
            toastLength: Toast.LENGTH_LONG,
            textColor: Colors.white,
            timeInSecForIosWeb: 1,
            fontSize: 17,
          );
        });
        await FirebaseFirestore.instance
            .collection('games')
            .doc('YpyyMAaFcRzCPbphEfYR')
            .update({'firstPlayer': uid4});
        break;
      default:
    }
  }

  Widget buildGameBoard(snapshotGames, snapshotUsers, snapshotRoom) {
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
              padding: EdgeInsets.all(4),
              width: 80,
              child: left.elementAt(0),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.all(0),
                width: 100,
                child: top.elementAt(0),
              ),
              GestureDetector(
                child: Transform.rotate(
                  angle: 3.14 / 2,
                  child: Container(
                    padding: EdgeInsets.all(0),
                    width: 200,
                    child: FlatCardFan(
                      children: center
                          .map(
                            (e) => Container(
                              width: 70,
                              child: e,
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ),
                onTap: () async {
                  await addDeck();

                  await displayerCards(snapshotGames);
                  await getFirstPlayer();
                  if (snapshotRoom.data.docs[0]['numOfPlayer'] == -1) {
                    return AuthScreen(
                      numOfPlayers: snapshotRoom.data.docs[0]['numOfPlayer'],
                    );
                  }
                },
              ),
              Container(
                padding: EdgeInsets.all(0),
                width: 100,
                child: deck.elementAt(0),
              ),
            ],
          ),
          Transform.rotate(
            angle: 3.14 / 2,
            child: Container(
              padding: EdgeInsets.all(0),
              width: 100,
              child: right.elementAt(0),
            ),
          ),
        ]),
      ),
    ));
  }
}
