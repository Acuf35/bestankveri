import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:bestank/home.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:toast/toast.dart';

class Datalog extends StatefulWidget {
  @override
  _DatalogState createState() => _DatalogState();
}

class _DatalogState extends State<Datalog> {
  String logDonguSuresi = "5";

  DateTime tarihIlk = DateTime.now();
  DateTime tarihSon = DateTime.now();

  int kayitTuruIndex = 1;
  int kayitAdet = 0;

  List<String> gelenZaman = [];
  List<String> gelenUrunTipi = [];
  List<String> gelenSeviye = [];
  List<String> gelenMiktar = [];
  List<String> gelenSanSen = [];
  List<String> gelenSens1 = [];
  List<String> gelenSens2 = [];
  List<String> gelenSens3 = [];
  List<String> gelenOrt = [];

  bool timerCancel = false;
  int timerSayac = 0;
  bool baglanti = false;

  int yazmaSonrasiGecikmeSayaci = 4;

  String baglantiDurum = "";

  @override
  Widget build(BuildContext context) {
    var oran = MediaQuery.of(context).size.width / 731.4;
    if (oran == 0.0) {
      oran = 1265.6 / 731.4;
      //grafikVisibility = false;
    } else {
      //grafikVisibility = true;
    }

    return Scaffold(
      body: Container(
        color: Colors.yellow,
        child: //Log verileri
            Container(
          padding: EdgeInsets.all(3 * oran),
          margin: EdgeInsets.all(3 * oran),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15 * oran),
              color: Colors.grey[400]),
          child: Row(
            children: [
              //Log parametreleri
              Expanded(
                flex: 3,
                child: Column(
                  children: <Widget>[
                    //Tank Seç
                    Expanded(
                      flex: 1,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            flex: 2,
                            child: SizedBox(
                              child: Container(
                                alignment: Alignment.bottomCenter,
                                child: AutoSizeText(
                                  "Tank Seç",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: 'Kelly Slab',
                                    color: Colors.black,
                                    fontSize: 20,
                                  ),
                                  maxLines: 1,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: Align(
                              alignment: Alignment.center,
                              child: Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.circular(5 * oran),
                                    color: Colors.blue),
                                margin: EdgeInsets.only(
                                    left: 2 * oran, right: 2 * oran),
                                child: RawMaterialButton(
                                  constraints:
                                      BoxConstraints(minWidth: double.infinity),
                                  padding: EdgeInsets.all(0),
                                  child: SizedBox(
                                    child: Container(
                                      alignment: Alignment.center,
                                      child: AutoSizeText(
                                        kayitTuru(kayitTuruIndex),
                                        style: TextStyle(
                                          //fontFamily: 'Kelly Slab',
                                          color: Colors.yellow,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 25,
                                        ),
                                        maxLines: 1,
                                      ),
                                    ),
                                  ),
                                  onPressed: () {
                                    showModalBottomSheet<void>(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return StatefulBuilder(
                                            builder: (context, state) {
                                              return Container(
                                                color: Colors.orange,
                                                height: double.infinity,
                                                child: Column(
                                                  children: <Widget>[
                                                    //Başlık bölümü
                                                    Expanded(
                                                      flex: 1,
                                                      child: SizedBox(
                                                          child: Container(
                                                        child: AutoSizeText(
                                                          "Tank Seçimi",
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  'Kelly Slab',
                                                              fontSize: 30,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      )),
                                                    ),
                                                    //Kayıt türü seçim bölümü
                                                    Expanded(
                                                      flex: 10,
                                                      child: Container(
                                                        color: Colors.white,
                                                        child: Column(
                                                          children: <Widget>[
                                                            Spacer(
                                                              flex: 1,
                                                            ),
                                                            //TANK 1 - TANK2
                                                            Expanded(
                                                              flex: 3,
                                                              child: Row(
                                                                children: <
                                                                    Widget>[
                                                                  Spacer(),
                                                                  //TANK 1
                                                                  Expanded(
                                                                      flex: 4,
                                                                      child:
                                                                          Container(
                                                                        alignment:
                                                                            Alignment.center,
                                                                        margin:
                                                                            EdgeInsets.all(3),
                                                                        decoration: BoxDecoration(
                                                                            borderRadius:
                                                                                BorderRadius.circular(10),
                                                                            color: Colors.blue),
                                                                        child:
                                                                            Column(
                                                                          children: <
                                                                              Widget>[
                                                                            Spacer(),
                                                                            Expanded(
                                                                              flex: 6,
                                                                              child: RawMaterialButton(
                                                                                constraints: BoxConstraints(minWidth: double.infinity),
                                                                                padding: EdgeInsets.all(0),
                                                                                onPressed: () {
                                                                                  kayitTuruIndex = 1;
                                                                                  kayitAdet = 0;
                                                                                  gelenZaman = [];
                                                                                  gelenSeviye = [];
                                                                                  gelenMiktar = [];
                                                                                  gelenSanSen = [];
                                                                                  gelenSens1 = [];
                                                                                  gelenSens2 = [];
                                                                                  gelenSens3 = [];
                                                                                  gelenOrt = [];
                                                                                  setState(() {
                                                                                    Navigator.pop(context);
                                                                                  });
                                                                                },
                                                                                child: SizedBox(
                                                                                  child: Container(
                                                                                    child: AutoSizeText(
                                                                                      "Tank 1",
                                                                                      style: TextStyle(fontFamily: 'Kelly Slab', fontSize: 35, color: Colors.white),
                                                                                      maxLines: 1,
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            Spacer()
                                                                          ],
                                                                        ),
                                                                      )),
                                                                  Spacer(),
                                                                  //TANK 2
                                                                  Expanded(
                                                                      flex: 4,
                                                                      child:
                                                                          Container(
                                                                        alignment:
                                                                            Alignment.center,
                                                                        margin:
                                                                            EdgeInsets.all(3),
                                                                        decoration: BoxDecoration(
                                                                            borderRadius:
                                                                                BorderRadius.circular(10),
                                                                            color: Colors.blue),
                                                                        child:
                                                                            Column(
                                                                          children: <
                                                                              Widget>[
                                                                            Spacer(),
                                                                            Expanded(
                                                                              flex: 6,
                                                                              child: RawMaterialButton(
                                                                                constraints: BoxConstraints(minWidth: double.infinity),
                                                                                padding: EdgeInsets.all(0),
                                                                                onPressed: () {
                                                                                  kayitTuruIndex = 2;
                                                                                  kayitAdet = 0;
                                                                                  gelenZaman = [];
                                                                                  gelenSeviye = [];
                                                                                  gelenMiktar = [];
                                                                                  gelenSanSen = [];
                                                                                  gelenSens1 = [];
                                                                                  gelenSens2 = [];
                                                                                  gelenSens3 = [];
                                                                                  gelenOrt = [];
                                                                                  setState(() {
                                                                                    Navigator.pop(context);
                                                                                  });
                                                                                },
                                                                                child: SizedBox(
                                                                                  child: Container(
                                                                                    child: AutoSizeText(
                                                                                      "Tank 2",
                                                                                      style: TextStyle(fontFamily: 'Kelly Slab', fontSize: 35, color: Colors.white),
                                                                                      maxLines: 1,
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            Spacer()
                                                                          ],
                                                                        ),
                                                                      )),
                                                                  Spacer(),
                                                                ],
                                                              ),
                                                            ),
                                                            Spacer(),
                                                            //TANK 3 - TANK 4
                                                            Expanded(
                                                              flex: 3,
                                                              child: Row(
                                                                children: <
                                                                    Widget>[
                                                                  Spacer(),
                                                                  //TANK 3
                                                                  Expanded(
                                                                      flex: 4,
                                                                      child:
                                                                          Container(
                                                                        alignment:
                                                                            Alignment.center,
                                                                        margin:
                                                                            EdgeInsets.all(3),
                                                                        decoration: BoxDecoration(
                                                                            borderRadius:
                                                                                BorderRadius.circular(10),
                                                                            color: Colors.blue),
                                                                        child:
                                                                            Column(
                                                                          children: <
                                                                              Widget>[
                                                                            Spacer(),
                                                                            Expanded(
                                                                              flex: 6,
                                                                              child: RawMaterialButton(
                                                                                constraints: BoxConstraints(minWidth: double.infinity),
                                                                                padding: EdgeInsets.all(0),
                                                                                onPressed: () {
                                                                                  kayitTuruIndex = 3;
                                                                                  kayitAdet = 0;
                                                                                  gelenZaman = [];
                                                                                  gelenSeviye = [];
                                                                                  gelenMiktar = [];
                                                                                  gelenSanSen = [];
                                                                                  gelenSens1 = [];
                                                                                  gelenSens2 = [];
                                                                                  gelenSens3 = [];
                                                                                  gelenOrt = [];
                                                                                  setState(() {
                                                                                    Navigator.pop(context);
                                                                                  });
                                                                                },
                                                                                child: SizedBox(
                                                                                  child: Container(
                                                                                    child: AutoSizeText(
                                                                                      "Tank 3",
                                                                                      style: TextStyle(fontFamily: 'Kelly Slab', fontSize: 35, color: Colors.white),
                                                                                      maxLines: 1,
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            Spacer()
                                                                          ],
                                                                        ),
                                                                      )),
                                                                  Spacer(),
                                                                  //TANK 4
                                                                  Expanded(
                                                                      flex: 4,
                                                                      child:
                                                                          Container(
                                                                        alignment:
                                                                            Alignment.center,
                                                                        margin:
                                                                            EdgeInsets.all(3),
                                                                        decoration: BoxDecoration(
                                                                            borderRadius:
                                                                                BorderRadius.circular(10),
                                                                            color: Colors.blue),
                                                                        child:
                                                                            Column(
                                                                          children: <
                                                                              Widget>[
                                                                            Spacer(),
                                                                            Expanded(
                                                                              flex: 6,
                                                                              child: RawMaterialButton(
                                                                                constraints: BoxConstraints(minWidth: double.infinity),
                                                                                padding: EdgeInsets.all(0),
                                                                                onPressed: () {
                                                                                  kayitTuruIndex = 4;

                                                                                  kayitAdet = 0;
                                                                                  gelenZaman = [];
                                                                                  gelenSeviye = [];
                                                                                  gelenMiktar = [];
                                                                                  gelenSanSen = [];
                                                                                  gelenSens1 = [];
                                                                                  gelenSens2 = [];
                                                                                  gelenSens3 = [];
                                                                                  gelenOrt = [];
                                                                                  setState(() {
                                                                                    Navigator.pop(context);
                                                                                  });
                                                                                },
                                                                                child: SizedBox(
                                                                                  child: Container(
                                                                                    child: AutoSizeText(
                                                                                      "Tank 4",
                                                                                      style: TextStyle(fontFamily: 'Kelly Slab', fontSize: 35, color: Colors.white),
                                                                                      maxLines: 1,
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            Spacer()
                                                                          ],
                                                                        ),
                                                                      )),
                                                                  Spacer(),
                                                                ],
                                                              ),
                                                            ),
                                                            Spacer(),
                                                            //TANK 5
                                                            Expanded(
                                                              flex: 3,
                                                              child: Row(
                                                                children: <
                                                                    Widget>[
                                                                  Spacer(),
                                                                  //TANK 5
                                                                  Expanded(
                                                                      flex: 4,
                                                                      child:
                                                                          Container(
                                                                        alignment:
                                                                            Alignment.center,
                                                                        margin:
                                                                            EdgeInsets.all(3),
                                                                        decoration: BoxDecoration(
                                                                            borderRadius:
                                                                                BorderRadius.circular(10),
                                                                            color: Colors.blue),
                                                                        child:
                                                                            Column(
                                                                          children: <
                                                                              Widget>[
                                                                            Spacer(),
                                                                            Expanded(
                                                                              flex: 6,
                                                                              child: RawMaterialButton(
                                                                                constraints: BoxConstraints(minWidth: double.infinity),
                                                                                padding: EdgeInsets.all(0),
                                                                                onPressed: () {
                                                                                  kayitTuruIndex = 5;
                                                                                  kayitAdet = 0;
                                                                                  gelenZaman = [];
                                                                                  gelenSeviye = [];
                                                                                  gelenMiktar = [];
                                                                                  gelenSanSen = [];
                                                                                  gelenSens1 = [];
                                                                                  gelenSens2 = [];
                                                                                  gelenSens3 = [];
                                                                                  gelenOrt = [];
                                                                                  setState(() {
                                                                                    Navigator.pop(context);
                                                                                  });
                                                                                },
                                                                                child: SizedBox(
                                                                                  child: Container(
                                                                                    child: AutoSizeText(
                                                                                      "Tank 5",
                                                                                      style: TextStyle(fontFamily: 'Kelly Slab', fontSize: 35, color: Colors.white),
                                                                                      maxLines: 1,
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            Spacer()
                                                                          ],
                                                                        ),
                                                                      )),

                                                                  Spacer(
                                                                    flex: 6,
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            Spacer(
                                                              flex: 1,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            },
                                          );
                                        });
                                  },
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    //Log periyot
                    Expanded(
                      flex: 1,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            flex: 2,
                            child: SizedBox(
                              child: Container(
                                alignment: Alignment.bottomCenter,
                                child: AutoSizeText(
                                  "Log Periyot",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: 'Kelly Slab',
                                    color: Colors.black,
                                    fontSize: 20,
                                  ),
                                  maxLines: 1,
                                  minFontSize: 8,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: Align(
                              alignment: Alignment.topCenter,
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.circular(5 * oran),
                                    color: Colors.blue),
                                margin: EdgeInsets.only(
                                    left: 2 * oran, right: 2 * oran),
                                child: RawMaterialButton(
                                  constraints:
                                      BoxConstraints(minWidth: double.infinity),
                                  padding: EdgeInsets.all(0),
                                  child: SizedBox(
                                    child: Container(
                                      child: AutoSizeText(
                                        logDonguSuresi + " dk",
                                        style: TextStyle(
                                          fontFamily: 'Kelly Slab',
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          fontSize: 25,
                                        ),
                                        maxLines: 1,
                                      ),
                                    ),
                                  ),
                                  onPressed: () {
                                    showModalBottomSheet<void>(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return StatefulBuilder(
                                            builder: (context, state) {
                                              return Container(
                                                color: Colors.orange,
                                                height: double.infinity,
                                                child: Column(
                                                  children: <Widget>[
                                                    //Başlık bölümü
                                                    Expanded(
                                                      flex: 1,
                                                      child: SizedBox(
                                                          child: Container(
                                                        child: AutoSizeText(
                                                          "Log Periyot",
                                                          maxLines: 1,
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  'Kelly Slab',
                                                              fontSize: 30,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      )),
                                                    ),
                                                    //Log periyot
                                                    Expanded(
                                                      flex: 10,
                                                      child: Container(
                                                        color: Colors.white,
                                                        child: Column(
                                                          children: <Widget>[
                                                            Spacer(
                                                              flex: 3,
                                                            ),
                                                            Expanded(
                                                              flex: 2,
                                                              child: Row(
                                                                children: <
                                                                    Widget>[
                                                                  //5 dk
                                                                  Expanded(
                                                                      child:
                                                                          Container(
                                                                    alignment:
                                                                        Alignment
                                                                            .center,
                                                                    margin: EdgeInsets
                                                                        .all(5 *
                                                                            oran),
                                                                    decoration: BoxDecoration(
                                                                        borderRadius:
                                                                            BorderRadius.circular(10 *
                                                                                oran),
                                                                        color: Colors
                                                                            .blue),
                                                                    child:
                                                                        Column(
                                                                      children: <
                                                                          Widget>[
                                                                        Spacer(),
                                                                        Expanded(
                                                                          flex:
                                                                              6,
                                                                          child:
                                                                              RawMaterialButton(
                                                                            constraints:
                                                                                BoxConstraints(minWidth: double.infinity),
                                                                            padding:
                                                                                EdgeInsets.all(0),
                                                                            onPressed:
                                                                                () {
                                                                              logDonguSuresi = "5";
                                                                              setState(() {
                                                                                Navigator.pop(context);
                                                                              });
                                                                            },
                                                                            child:
                                                                                SizedBox(
                                                                              child: Container(
                                                                                child: AutoSizeText(
                                                                                  "5 " + "Dk",
                                                                                  style: TextStyle(fontFamily: 'Kelly Slab', fontSize: 50, color: Colors.white),
                                                                                  maxLines: 1,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        Spacer(),
                                                                      ],
                                                                    ),
                                                                  )),
                                                                  //10 dk
                                                                  Expanded(
                                                                      child:
                                                                          Container(
                                                                    alignment:
                                                                        Alignment
                                                                            .center,
                                                                    margin: EdgeInsets
                                                                        .all(5 *
                                                                            oran),
                                                                    decoration: BoxDecoration(
                                                                        borderRadius:
                                                                            BorderRadius.circular(10 *
                                                                                oran),
                                                                        color: Colors
                                                                            .blue),
                                                                    child:
                                                                        Column(
                                                                      children: <
                                                                          Widget>[
                                                                        Spacer(),
                                                                        Expanded(
                                                                          flex:
                                                                              6,
                                                                          child:
                                                                              RawMaterialButton(
                                                                            constraints:
                                                                                BoxConstraints(minWidth: double.infinity),
                                                                            padding:
                                                                                EdgeInsets.all(0),
                                                                            onPressed:
                                                                                () {
                                                                              logDonguSuresi = "10";
                                                                              setState(() {
                                                                                Navigator.pop(context);
                                                                              });
                                                                            },
                                                                            child:
                                                                                SizedBox(
                                                                              child: Container(
                                                                                child: AutoSizeText(
                                                                                  "10 " + "Dk",
                                                                                  style: TextStyle(fontFamily: 'Kelly Slab', fontSize: 50, color: Colors.white),
                                                                                  maxLines: 1,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        Spacer()
                                                                      ],
                                                                    ),
                                                                  )),
                                                                  //15 dk
                                                                  Expanded(
                                                                      child:
                                                                          Container(
                                                                    alignment:
                                                                        Alignment
                                                                            .center,
                                                                    margin: EdgeInsets
                                                                        .all(5 *
                                                                            oran),
                                                                    decoration: BoxDecoration(
                                                                        borderRadius:
                                                                            BorderRadius.circular(10 *
                                                                                oran),
                                                                        color: Colors
                                                                            .blue),
                                                                    child:
                                                                        Column(
                                                                      children: <
                                                                          Widget>[
                                                                        Spacer(),
                                                                        Expanded(
                                                                          flex:
                                                                              6,
                                                                          child:
                                                                              RawMaterialButton(
                                                                            constraints:
                                                                                BoxConstraints(minWidth: double.infinity),
                                                                            padding:
                                                                                EdgeInsets.all(0),
                                                                            onPressed:
                                                                                () {
                                                                              logDonguSuresi = "15";
                                                                              setState(() {
                                                                                Navigator.pop(context);
                                                                              });
                                                                            },
                                                                            child:
                                                                                SizedBox(
                                                                              child: Container(
                                                                                child: AutoSizeText(
                                                                                  "15 " + "Dk",
                                                                                  style: TextStyle(fontFamily: 'Kelly Slab', fontSize: 50, color: Colors.white),
                                                                                  maxLines: 1,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        Spacer()
                                                                      ],
                                                                    ),
                                                                  )),
                                                                  //30 dk
                                                                  Expanded(
                                                                      child:
                                                                          Container(
                                                                    alignment:
                                                                        Alignment
                                                                            .center,
                                                                    margin: EdgeInsets
                                                                        .all(5 *
                                                                            oran),
                                                                    decoration: BoxDecoration(
                                                                        borderRadius:
                                                                            BorderRadius.circular(10 *
                                                                                oran),
                                                                        color: Colors
                                                                            .blue),
                                                                    child:
                                                                        Column(
                                                                      children: <
                                                                          Widget>[
                                                                        Spacer(),
                                                                        Expanded(
                                                                          flex:
                                                                              6,
                                                                          child:
                                                                              RawMaterialButton(
                                                                            constraints:
                                                                                BoxConstraints(minWidth: double.infinity),
                                                                            padding:
                                                                                EdgeInsets.all(0),
                                                                            onPressed:
                                                                                () {
                                                                              logDonguSuresi = "30";
                                                                              setState(() {
                                                                                Navigator.pop(context);
                                                                              });
                                                                            },
                                                                            child:
                                                                                SizedBox(
                                                                              child: Container(
                                                                                child: AutoSizeText(
                                                                                  "30 " + "Dk",
                                                                                  style: TextStyle(fontFamily: 'Kelly Slab', fontSize: 50, color: Colors.white),
                                                                                  maxLines: 1,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        Spacer()
                                                                      ],
                                                                    ),
                                                                  )),
                                                                  //60 dk
                                                                  Expanded(
                                                                      child:
                                                                          Container(
                                                                    alignment:
                                                                        Alignment
                                                                            .center,
                                                                    margin: EdgeInsets
                                                                        .all(5 *
                                                                            oran),
                                                                    decoration: BoxDecoration(
                                                                        borderRadius:
                                                                            BorderRadius.circular(10 *
                                                                                oran),
                                                                        color: Colors
                                                                            .blue),
                                                                    child:
                                                                        Column(
                                                                      children: <
                                                                          Widget>[
                                                                        Spacer(),
                                                                        Expanded(
                                                                          flex:
                                                                              6,
                                                                          child:
                                                                              RawMaterialButton(
                                                                            constraints:
                                                                                BoxConstraints(minWidth: double.infinity),
                                                                            padding:
                                                                                EdgeInsets.all(0),
                                                                            onPressed:
                                                                                () {
                                                                              logDonguSuresi = "60";
                                                                              setState(() {
                                                                                Navigator.pop(context);
                                                                              });
                                                                            },
                                                                            child:
                                                                                SizedBox(
                                                                              child: Container(
                                                                                child: AutoSizeText(
                                                                                  "60 " + "Dk",
                                                                                  style: TextStyle(fontFamily: 'Kelly Slab', fontSize: 50, color: Colors.white),
                                                                                  maxLines: 1,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        Spacer()
                                                                      ],
                                                                    ),
                                                                  )),
                                                                ],
                                                              ),
                                                            ),
                                                            Spacer(
                                                              flex: 5,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            },
                                          );
                                        });
                                  },
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    //Tarih ilk
                    Expanded(
                      flex: 1,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            flex: 2,
                            child: SizedBox(
                              child: Container(
                                alignment: Alignment.bottomCenter,
                                child: AutoSizeText(
                                  "Tarih İlk",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: 'Kelly Slab',
                                    color: Colors.black,
                                    fontSize: 20,
                                  ),
                                  maxLines: 1,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: Align(
                              alignment: Alignment.topCenter,
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.circular(5 * oran),
                                    color: Colors.blue),
                                margin: EdgeInsets.only(
                                    left: 2 * oran, right: 2 * oran),
                                child: RawMaterialButton(
                                  constraints:
                                      BoxConstraints(minWidth: double.infinity),
                                  padding: EdgeInsets.all(0),
                                  child: SizedBox(
                                    child: Container(
                                      child: AutoSizeText(
                                        DateFormat('dd-MM-yyyy')
                                            .format(tarihIlk),
                                        style: TextStyle(
                                          fontFamily: 'Kelly Slab',
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          fontSize: 25,
                                        ),
                                        maxLines: 1,
                                      ),
                                    ),
                                  ),
                                  onPressed: () {
                                    _selectDate(context, 1, tarihIlk);
                                  },
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    //Tarih Son
                    Expanded(
                      flex: 1,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            flex: 2,
                            child: SizedBox(
                              child: Container(
                                alignment: Alignment.bottomCenter,
                                child: AutoSizeText(
                                  "Tarih Son",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: 'Kelly Slab',
                                    color: Colors.black,
                                    fontSize: 20,
                                  ),
                                  maxLines: 1,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: Align(
                              alignment: Alignment.topCenter,
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.circular(5 * oran),
                                    color: Colors.blue),
                                margin: EdgeInsets.only(
                                    left: 2 * oran, right: 2 * oran),
                                child: RawMaterialButton(
                                  constraints:
                                      BoxConstraints(minWidth: double.infinity),
                                  padding: EdgeInsets.all(0),
                                  child: SizedBox(
                                    child: Container(
                                      child: AutoSizeText(
                                        DateFormat('dd-MM-yyyy')
                                            .format(tarihSon),
                                        style: TextStyle(
                                          fontFamily: 'Kelly Slab',
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          fontSize: 25,
                                        ),
                                        maxLines: 1,
                                      ),
                                    ),
                                  ),
                                  onPressed: () {
                                    _selectDate(context, 2, tarihSon);
                                  },
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    //Veri getir
                    Expanded(
                      flex: 1,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Spacer(
                            flex: 1,
                          ),
                          Expanded(
                            flex: 3,
                            child: Align(
                              alignment: Alignment.center,
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.circular(5 * oran),
                                    color: Colors.green[700]),
                                margin: EdgeInsets.only(
                                    left: 2 * oran, right: 2 * oran),
                                child: RawMaterialButton(
                                  constraints:
                                      BoxConstraints(minWidth: double.infinity),
                                  padding: EdgeInsets.all(0),
                                  child: SizedBox(
                                    child: Container(
                                      child: AutoSizeText(
                                        "GETİR",
                                        style: TextStyle(
                                            fontFamily: 'Kelly Slab',
                                            fontWeight: FontWeight.bold,
                                            fontSize: 25,
                                            color: Colors.white),
                                        maxLines: 1,
                                      ),
                                    ),
                                  ),
                                  onLongPress: () {
                                    kayitAdet = 0;
                                    gelenZaman = [];
                                    gelenSeviye = [];
                                    gelenMiktar = [];
                                    gelenSanSen = [];
                                    gelenSens1 = [];
                                    gelenSens2 = [];
                                    gelenSens3 = [];
                                    gelenOrt = [];
                                    Toast.show(
                                        "Log tablosu sıfırlandı", context,
                                        duration: 2);
                                    setState(() {});
                                  },
                                  onPressed: () {
                                    if (tarihIlk.month != tarihSon.month ||
                                        tarihIlk.year != tarihSon.year) {
                                      Toast.show(
                                          "Tarih İlk ve Tarih Son parametrelerine aynı ay ve yıl girilmelidir!",
                                          context,
                                          duration: 3);
                                    } else if (tarihSon.day - tarihIlk.day >
                                            2 &&
                                        logDonguSuresi == "5") {
                                      Toast.show(
                                          "5 dk\'lık periyot için bir defada en fazla 3 günlük veri çekebilirsiniz.",
                                          context,
                                          duration: 3);
                                    } else if (tarihSon.day - tarihIlk.day >
                                            5 &&
                                        logDonguSuresi == "10") {
                                      Toast.show(
                                          "10 dk\'lık periyot için bir defada en fazla 6 günlük veri çekebilirsiniz.",
                                          context,
                                          duration: 3);
                                    } else if (tarihSon.day - tarihIlk.day >
                                            8 &&
                                        logDonguSuresi == "15") {
                                      Toast.show(
                                          "15 dk\'lık periyot için bir defada en fazla 9 günlük veri çekebilirsiniz.",
                                          context,
                                          duration: 3);
                                    } else if (tarihSon.day - tarihIlk.day >
                                            11 &&
                                        logDonguSuresi == "20") {
                                      Toast.show(
                                          "20 dk\'lık periyot için bir defada en fazla 12 günlük veri çekebilirsiniz.",
                                          context,
                                          duration: 3);
                                    } else if (tarihSon.day - tarihIlk.day >
                                            17 &&
                                        logDonguSuresi == "30") {
                                      Toast.show(
                                          "30 dk\'lık periyot için bir defada en fazla 18 günlük veri çekebilirsiniz.",
                                          context,
                                          duration: 3);
                                    } else {
                                      String gunIlk = tarihIlk.day.toString();
                                      String gunSon = tarihSon.day.toString();
                                      String ayy = tarihIlk.month.toString();
                                      String yil = tarihIlk.year.toString();
                                      String tabloAdi = "dlog$kayitTuruIndex" +
                                          (ayy.length == 1
                                              ? ("0" + ayy)
                                              : ayy) +
                                          yil;
                                      print(tabloAdi);

                                      yazmaSonrasiGecikmeSayaci = 0;
                                      String komut =
                                          '1*$tabloAdi*$logDonguSuresi*$gunIlk*$gunSon';
                                      veriGonder(komut, 3002).then((value) {
                                        if (value.split("*")[0] == "error") {
                                          Toast.show(
                                              "Yazdırma hatası! Yazdırma portu kapalı.Ağ hatası yoksa Server PC\'yi yeniden başlatınız.",
                                              context,
                                              duration: 3);
                                        } else {
                                          Toast.show("Başarılı", context,
                                              duration: 3);

                                          veriIslemeLog(value);
                                          baglantiDurum = "";
                                        }
                                      });
                                    }
                                  },
                                ),
                              ),
                            ),
                          ),
                          Spacer()
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              //Logların listelendiği kısım
              Expanded(
                flex: 16,
                child: Container(
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Column(
                          children: <Widget>[
                            //Liste başlıkları
                            Expanded(
                              child: Row(
                                children: <Widget>[
                                  //Kayıt no
                                  Expanded(
                                    flex: 1,
                                    child: Column(
                                      children: [
                                        Spacer(),
                                        Expanded(flex: 2,
                                          child: SizedBox(
                                            child: Container(
                                              alignment: Alignment.center,
                                              child: AutoSizeText(
                                                "KAYIT NO",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  decoration:
                                                      TextDecoration.underline,
                                                ),
                                                maxLines: 1,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Spacer()
                                      ],
                                    ),
                                  ),
                                  //ZAMAN
                                  Expanded(
                                    flex: 2,
                                    child: Column(
                                      children: [
                                        Spacer(),
                                        Expanded(flex: 2,
                                          child: SizedBox(
                                            child: Container(
                                              alignment: Alignment.center,
                                              child: AutoSizeText(
                                                "ZAMAN",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  decoration:
                                                      TextDecoration.underline,
                                                ),
                                                maxLines: 1,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Spacer()
                                      ],
                                    ),
                                  ),
                                  //Ürün Tİpi
                                  Expanded(
                                    flex: 1,
                                    child: Column(
                                      children: [
                                        Spacer(),
                                        Expanded(flex: 2,
                                          child: SizedBox(
                                            child: Container(
                                              alignment: Alignment.center,
                                              child: AutoSizeText(
                                                "ÜRÜN TİPİ",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  decoration:
                                                      TextDecoration.underline,
                                                ),
                                                maxLines: 1,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Spacer()
                                      ],
                                    ),
                                  ),
                                  //Seviye
                                  Expanded(
                                    flex: 1,
                                    child: Column(
                                      children: [
                                        Spacer(),
                                        Expanded(flex: 2,
                                          child: SizedBox(
                                            child: Container(
                                              child: AutoSizeText(
                                                "SEVİYE",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  decoration:
                                                      TextDecoration.underline,
                                                ),
                                                maxLines: 1,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Spacer()
                                      ],
                                    ),
                                  ),

                                  //Miktar
                                  Expanded(
                                    flex: 1,
                                    child: Column(
                                      children: [
                                        Spacer(),
                                        Expanded(flex: 2,
                                          child: SizedBox(
                                            child: Container(
                                              child: AutoSizeText(
                                                "MİKTAR",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  decoration:
                                                      TextDecoration.underline,
                                                ),
                                                maxLines: 1,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Spacer()
                                      ],
                                    ),
                                  ),
                                  //Sanal sensor
                                  Expanded(
                                    flex: 1,
                                    child: Column(
                                      children: [
                                        Spacer(),
                                        Expanded(flex: 2,
                                          child: SizedBox(
                                            child: Container(
                                              child: AutoSizeText(
                                                "SAN.SEN.",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  decoration:
                                                      TextDecoration.underline,
                                                ),
                                                maxLines: 1,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Spacer()
                                      ],
                                    ),
                                  ),

                                  //Sensör 1
                                  Expanded(
                                    flex: 1,
                                    child: Column(
                                      children: [
                                        Spacer(),
                                        Expanded(flex: 2,
                                          child: SizedBox(
                                            child: Container(
                                              child: AutoSizeText(
                                                "SENS 1",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  decoration:
                                                      TextDecoration.underline,
                                                ),
                                                maxLines: 1,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Spacer()
                                      ],
                                    ),
                                  ),
                                  //Sensör 2
                                  Expanded(
                                    flex: 1,
                                    child: Column(
                                      children: [
                                        Spacer(),
                                        Expanded(flex: 2,
                                          child: SizedBox(
                                            child: Container(
                                              child: AutoSizeText(
                                                "SENS 2",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  decoration:
                                                      TextDecoration.underline,
                                                ),
                                                maxLines: 1,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Spacer()
                                      ],
                                    ),
                                  ),
                                  //Sensör 3
                                  Expanded(
                                    flex: 1,
                                    child: Column(
                                      children: [
                                        Spacer(),
                                        Expanded(flex: 2,
                                          child: SizedBox(
                                            child: Container(
                                              child: AutoSizeText(
                                                "SENS 3",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  decoration:
                                                      TextDecoration.underline,
                                                ),
                                                maxLines: 1,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Spacer()
                                      ],
                                    ),
                                  ),
                                  //Ortalama Sıcaklık
                                  Expanded(
                                    flex: 1,
                                    child: Column(
                                      children: [
                                        Spacer(),
                                        Expanded(flex: 2,
                                          child: SizedBox(
                                            child: Container(
                                              child: AutoSizeText(
                                                "ORT.SIC.",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  decoration:
                                                      TextDecoration.underline,
                                                ),
                                                maxLines: 1,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Spacer()
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            //Liste
                            Expanded(
                              flex: 13,
                              child: ListView.builder(
                                  itemCount: kayitAdet,
                                  itemBuilder: (BuildContext ctxt, int index) {
                                    return Container(
                                      color: index % 2 == 1
                                          ? Colors.grey[300]
                                          : Colors.grey[400],
                                      child: Row(
                                        children: <Widget>[
                                          //Kayıt No
                                          Expanded(
                                            flex: 1,
                                            child: SizedBox(
                                              height: 10 * oran,
                                              child: Container(
                                                child: AutoSizeText(
                                                  (index + 1).toString(),
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontSize: 40,
                                                    color: Colors.black,
                                                  ),
                                                  maxLines: 1,
                                                ),
                                              ),
                                            ),
                                          ),
                                          //Zaman
                                          Expanded(
                                            flex: 2,
                                            child: SizedBox(
                                              height: 10 * oran,
                                              child: Container(
                                                child: AutoSizeText(
                                                  gelenZaman[index],
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontSize: 40,
                                                    color: Colors.black,
                                                  ),
                                                  maxLines: 1,
                                                ),
                                              ),
                                            ),
                                          ),
                                          //Ürün Tipi
                                          Expanded(
                                            flex: 1,
                                            child: SizedBox(
                                              height: 10 * oran,
                                              child: Container(
                                                child: AutoSizeText(
                                                  urunTipi(
                                                      gelenUrunTipi[index]),
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontSize: 40,
                                                  ),
                                                  maxLines: 1,
                                                ),
                                              ),
                                            ),
                                          ),

                                          //Seviye
                                          Expanded(
                                            flex: 1,
                                            child: SizedBox(
                                              height: 10 * oran,
                                              child: Container(
                                                child: AutoSizeText(
                                                  gelenSeviye[index] + " mt",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontSize: 40,
                                                  ),
                                                  maxLines: 1,
                                                ),
                                              ),
                                            ),
                                          ),
                                          //Miktar
                                          Expanded(
                                            flex: 1,
                                            child: SizedBox(
                                              height: 10 * oran,
                                              child: Container(
                                                child: AutoSizeText(
                                                  gelenMiktar[index] + " Kg",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontSize: 40,
                                                  ),
                                                  maxLines: 1,
                                                ),
                                              ),
                                            ),
                                          ),
                                          //San Sensor
                                          Expanded(
                                            flex: 1,
                                            child: SizedBox(
                                              height: 10 * oran,
                                              child: Container(
                                                child: AutoSizeText(
                                                  gelenSanSen[index] + " °C",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontSize: 40,
                                                  ),
                                                  maxLines: 1,
                                                ),
                                              ),
                                            ),
                                          ),
                                          //Sens 1
                                          Expanded(
                                            flex: 1,
                                            child: SizedBox(
                                              height: 10 * oran,
                                              child: Container(
                                                child: AutoSizeText(
                                                  gelenSens1[index] + " °C",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontSize: 40,
                                                  ),
                                                  maxLines: 1,
                                                ),
                                              ),
                                            ),
                                          ),
                                          //Sens 2
                                          Expanded(
                                            flex: 1,
                                            child: SizedBox(
                                              height: 10 * oran,
                                              child: Container(
                                                child: AutoSizeText(
                                                  gelenSens2[index] + " °C",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontSize: 40,
                                                  ),
                                                  maxLines: 1,
                                                ),
                                              ),
                                            ),
                                          ),
                                          //Sens 3
                                          Expanded(
                                            flex: 1,
                                            child: SizedBox(
                                              height: 10 * oran,
                                              child: Container(
                                                child: AutoSizeText(
                                                  gelenSens3[index] + " °C",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontSize: 40,
                                                  ),
                                                  maxLines: 1,
                                                ),
                                              ),
                                            ),
                                          ),
                                          //Ortalama
                                          Expanded(
                                            flex: 1,
                                            child: SizedBox(
                                              height: 10 * oran,
                                              child: Container(
                                                child: AutoSizeText(
                                                  gelenOrt[index] + " °C",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontSize: 40,
                                                  ),
                                                  maxLines: 1,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  }),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Container(
        width: 40 * oran,
        height: 40 * oran,
        child: FittedBox(
          child: FloatingActionButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => HomePage()),
              );
            },
            backgroundColor: Colors.blue,
            child: Icon(
              Icons.arrow_back,
              size: 50,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Future<String> veriGonder(String komut, int portNo) async {
    String _donusDegeri;

    print("Request has data");

    // =============================================================
    Socket _socket;
    await Socket.connect("192.168.1.110", portNo, timeout: Duration(seconds: 5))
        .then((Socket sock) {
      _socket = sock;
    }).then((_) {
      // SENT TO SERVER ************************
      _socket.write(komut);
      return _socket.first;
    }).then((data) {
      // GET FROM SERVER ********************

      _donusDegeri = new String.fromCharCodes(data).trim() + "*";
      _socket.close();
    }).catchError((error) {
      _donusDegeri = "error*" + error.toString().trim();
      //_socket.close();
    });
    // ==============================================================

    return _donusDegeri;
  }

  veriIslemeLog(String gelenMesaj) {
    print(gelenMesaj);
    var degerler = gelenMesaj.split('#');
    kayitAdet = degerler.length - 1;
    gelenZaman = [];
    gelenSeviye = [];
    gelenMiktar = [];
    gelenSanSen = [];
    gelenSens1 = [];
    gelenSens2 = [];
    gelenSens3 = [];
    gelenOrt = [];
    if (gelenMesaj.contains("yok1")) {
      Toast.show(
          "Girilen gün aralığında herhangi bir log kaydı bulunmamaktadır.",
          context,
          duration: 3);
    } else if (gelenMesaj.contains("yok2")) {
      Toast.show(
          "Girilen ayda herhangi bir log kaydı bulunmamaktadır.", context,
          duration: 3);
    } else {
      for (var i = 1; i < degerler.length; i++) {
        String xx = degerler[i].split("*")[0];
        String saat = xx.length == 1 ? "0" + xx : xx;
        String yy = degerler[i].split("*")[1];
        String dk = yy.length == 1 ? "0" + yy : yy;
        String zz = degerler[i].split("*")[2];
        String gun = zz.length == 1 ? "0" + zz : zz;
        String tt = tarihIlk.month.toString();
        String ay = tt.length == 1 ? "0" + tt : tt;
        String yil = tarihIlk.year.toString();

        gelenZaman.add(saat + ":" + dk + "  " + gun + "." + ay + "." + yil);

        gelenUrunTipi.add(degerler[i].split("*")[3]);
        gelenSeviye.add(degerler[i].split("*")[4]);
        gelenMiktar.add(degerler[i].split("*")[5]);
        gelenSanSen.add(degerler[i].split("*")[6]);
        gelenSens1.add(degerler[i].split("*")[7]);
        gelenSens2.add(degerler[i].split("*")[8]);
        gelenSens3.add(degerler[i].split("*")[9]);
        gelenOrt.add(degerler[i].split("*")[10]);
      }
    }

    baglanti = false;
    if (!timerCancel) {
      setState(() {});
    }
  }

  Future<Null> _selectDate(
      BuildContext context, int index, DateTime selectedDate) async {
    final DateTime picked = await showDatePicker(
        helpText: "Seçilen Tarih",
        cancelText: "ÇIKIŞ",
        confirmText: "ONAY",
        locale: Locale('tr', 'TR'),
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      if (picked.compareTo(DateTime.now()) <= 0) {
        if (index == 1) {
          setState(() {
            tarihIlk = picked;
          });
        }

        if (index == 2) {
          setState(() {
            tarihSon = picked;
          });
        }
      } else {
        Toast.show("Geçersiz tarih hatası! Lütfen geçmiş bir tarih giriniz...",
            context,
            duration: 3);
      }
    }
  }

  String urunTipi(String index) {
    String sonuc = "";
    if (index == "1") {
      sonuc = "PAMUK";
    } else if (index == "2") {
      sonuc = "SOYA";
    } else if (index == "3") {
      sonuc = "AYÇİÇEĞİ";
    } else if (index == "4") {
      sonuc = "KANOLA";
    }

    return sonuc;
  }

  String kayitTuru(int index) {
    String sonuc = "";

    if (index == 1) {
      sonuc = "Tank 1";
    } else if (index == 2) {
      sonuc = "Tank 2";
    } else if (index == 3) {
      sonuc = "Tank 3";
    } else if (index == 4) {
      sonuc = "Tank 4";
    } else if (index == 5) {
      sonuc = "Tank 5";
    }

    return sonuc;
  }
}
