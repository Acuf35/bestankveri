import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:bestank/tank_grafik_veriler.dart';
import 'package:bestank/tank_grafik.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:toast/toast.dart';

import 'deger_giris_2x1.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String baglantiDurum = "";

  int _onlar = 0;
  int _birler = 0;
  int _ondalik = 0;
  int _index = 0;

  bool timerCancel = false;
  int timerSayac = 0;
  bool baglanti = false;

  int yazmaSonrasiGecikmeSayaci = 4;

  String logDonguSuresi = "5";
  int kayitTuruIndex = 1;

  DateTime tarihIlk = DateTime.now();
  DateTime tarihSon = DateTime.now();

  int kayitAdet = 0;

  List<String> gelenZaman = [];
  List<String> gelenDoluluk = [];
  List<String> gelenMiktar = [];
  List<String> gelensens1 = [];
  List<String> gelensens2 = [];
  List<String> gelensens3 = [];

  String birim = "";
  bool t1SanalSensorAktiflik = false;
  bool t2SanalSensorAktiflik = false;
  bool t3SanalSensorAktiflik = false;
  bool t4SanalSensorAktiflik = false;
  bool t5SanalSensorAktiflik = false;

  double dolulukT1 = 0.0;
  double dolulukT2 = 0.0;
  double dolulukT3 = 0.0;
  double dolulukT4 = 0.0;
  double dolulukT5 = 0.0;

  String litreT1 = "0.0";
  String litreT2 = "0.0";
  String litreT3 = "0.0";
  String litreT4 = "0.0";
  String litreT5 = "0.0";

  String t1sens1 = "0.0";
  String t1sens2 = "0.0";
  String t1sens3 = "0.0";
  String t1SanSens = "0.0";

  String t2sens1 = "0.0";
  String t2sens2 = "0.0";
  String t2sens3 = "0.0";
  String t2SanSens = "0.0";

  String t3sens1 = "0.0";
  String t3sens2 = "0.0";
  String t3sens3 = "0.0";
  String t3SanSens = "0.0";

  String t4sens1 = "0.0";
  String t4sens2 = "0.0";
  String t4sens3 = "0.0";
  String t4SanSens = "0.0";

  String t5sens1 = "0.0";
  String t5sens2 = "0.0";
  String t5sens3 = "0.0";
  String t5SanSens = "0.0";

  String ortalamaT1 = "0.0";
  String ortalamaT2 = "0.0";
  String ortalamaT3 = "0.0";
  String ortalamaT4 = "0.0";
  String ortalamaT5 = "0.0";

  String urunTipi = "1";

  String sensSev1 = "0.0";
  String sensSev2 = "0.0";
  String sensSev3 = "0.0";

  int sayac = 0;

  List<bool> t1ortalamadakiSensor = new List.filled(4, false);
  List<bool> t2ortalamadakiSensor = new List.filled(4, false);
  List<bool> t3ortalamadakiSensor = new List.filled(4, false);
  List<bool> t4ortalamadakiSensor = new List.filled(4, false);
  List<bool> t5ortalamadakiSensor = new List.filled(4, false);

  @override
  Widget build(BuildContext context) {
    //++++++++++++++++++++++++++STATUS BAR SAKLAMA ve EKRANI YATAYA SABİTLEME+++++++++++++++++++++++++++++++
    SystemChrome.setEnabledSystemUIOverlays([]);
    _landscapeModeOnly();
//--------------------------STATUS BAR SAKLAMA ve EKRANI YATAYA SABİTLEME--------------------------------

    var oran = MediaQuery.of(context).size.width / 731.4;
    var widthA = MediaQuery.of(context).size.width;
    var heightB = MediaQuery.of(context).size.height;

    List<TankGrafikVeriler> tank1 = [
      TankGrafikVeriler(
          dolulukYuzdeMetin: "%$dolulukT1",
          dolulukYuzde: dolulukT1,
          barColor: charts.ColorUtil.fromDartColor(Colors.blue)),
    ];

    List<TankGrafikVeriler> tank2 = [
      TankGrafikVeriler(
          dolulukYuzdeMetin: "%$dolulukT2",
          dolulukYuzde: dolulukT2,
          barColor: charts.ColorUtil.fromDartColor(Colors.blue)),
    ];

    List<TankGrafikVeriler> tank3 = [
      TankGrafikVeriler(
          dolulukYuzdeMetin: "%$dolulukT3",
          dolulukYuzde: dolulukT3,
          barColor: charts.ColorUtil.fromDartColor(Colors.blue)),
    ];

    List<TankGrafikVeriler> tank4 = [
      TankGrafikVeriler(
          dolulukYuzdeMetin: "%$dolulukT4",
          dolulukYuzde: dolulukT4,
          barColor: charts.ColorUtil.fromDartColor(Colors.blue)),
    ];

    List<TankGrafikVeriler> tank5 = [
      TankGrafikVeriler(
          dolulukYuzdeMetin: "%$dolulukT5",
          dolulukYuzde: dolulukT5,
          barColor: charts.ColorUtil.fromDartColor(Colors.blue)),
    ];

    if (timerSayac == 0) {
      takipEt('1*', 3001).then((veri) {
        if (veri.split("*")[0] == "error") {
          baglanti = false;
          baglantiDurum = veri.split("*")[1];
          print(baglantiDurum);
          setState(() {});
        } else {
          veriIslemeGenel(veri);
          baglantiDurum = "";
        }
      });

      Timer.periodic(Duration(seconds: 2), (timer) {
        if (baglanti) {
          sayac++;
        }

        if (sayac == 2) {
          baglanti = false;
          sayac = 0;
        }

        yazmaSonrasiGecikmeSayaci++;
        if (timerCancel) {
          timer.cancel();
        }
        if (!baglanti && yazmaSonrasiGecikmeSayaci > 3) {
          baglanti = true;

          takipEt('1*', 3001).then((veri) {
            if (veri.split("*")[0] == "error") {
              baglanti = false;
              baglantiDurum = veri.split("*")[1];
              print(baglantiDurum);
              setState(() {});
            } else {
              veriIslemeGenel(veri);
              print(veri);
              baglantiDurum = "";
            }
          });
        }
      });
    }

    timerSayac++;

    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: Container(
                color: Colors.yellow[200],
                child: Row(
                  children: [
                    Expanded(
                        child: TankGrafik(
                      "TANK 1",
                      "$litreT1 Lt",
                      t1sens1,
                      t1sens2,
                      t1sens3,
                      t1SanSens,
                      t1SanalSensorAktiflik,
                      1,
                      ortalamaT1,
                      double.parse(sensSev1),
                      double.parse(sensSev2),
                      double.parse(sensSev3),
                      t1ortalamadakiSensor[1],
                      t1ortalamadakiSensor[2],
                      t1ortalamadakiSensor[3],
                      oran,
                      data: tank1,
                    )),
                    Expanded(
                        child: TankGrafik(
                      "TANK 2",
                      "$litreT2 Lt",
                      t2sens1,
                      t2sens2,
                      t2sens3,
                      t2SanSens,
                      t2SanalSensorAktiflik,
                      2,
                      ortalamaT2,
                      double.parse(sensSev1),
                      double.parse(sensSev2),
                      double.parse(sensSev3),
                      t2ortalamadakiSensor[1],
                      t2ortalamadakiSensor[2],
                      t2ortalamadakiSensor[3],
                      oran,
                      data: tank2,
                    )),
                    Expanded(
                        child: TankGrafik(
                      "TANK 3",
                      "$litreT3 Lt",
                      t3sens1,
                      t3sens2,
                      t3sens3,
                      t3SanSens,
                      t3SanalSensorAktiflik,
                      3,
                      ortalamaT3,
                      double.parse(sensSev1),
                      double.parse(sensSev2),
                      double.parse(sensSev3),
                      t3ortalamadakiSensor[1],
                      t3ortalamadakiSensor[2],
                      t3ortalamadakiSensor[3],
                      oran,
                      data: tank3,
                    )),
                    Expanded(
                        child: TankGrafik(
                      "TANK 4",
                      "$litreT4 Lt",
                      t4sens1,
                      t4sens2,
                      t4sens3,
                      t4SanSens,
                      t4SanalSensorAktiflik,
                      4,
                      ortalamaT4,
                      double.parse(sensSev1),
                      double.parse(sensSev2),
                      double.parse(sensSev3),
                      t4ortalamadakiSensor[1],
                      t4ortalamadakiSensor[2],
                      t4ortalamadakiSensor[3],
                      oran,
                      data: tank4,
                    )),
                    Expanded(
                        child: TankGrafik(
                      "TANK 5",
                      "$litreT5 Lt",
                      t5sens1,
                      t5sens2,
                      t5sens3,
                      t5SanSens,
                      t5SanalSensorAktiflik,
                      5,
                      ortalamaT5,
                      double.parse(sensSev1),
                      double.parse(sensSev2),
                      double.parse(sensSev3),
                      t5ortalamadakiSensor[1],
                      t5ortalamadakiSensor[2],
                      t5ortalamadakiSensor[3],
                      oran,
                      data: tank5,
                    )),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                //color: Colors.grey[300],
                child: Row(
                  children: [
                    //PAMUK ve SOYA SEÇİM ALANI ve SANAL SENSÖR AKTİFLİK
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            flex: 2,
                            child: SizedBox(
                              child: Container(
                                alignment: Alignment.bottomCenter,
                                child: AutoSizeText(
                                  "Sanal Sensör Aktiflik",
                                  style: TextStyle(fontSize: 15*oran),
                                  maxLines: 1,
                                ),
                              ),
                            ),
                          ),
                          //Sanal Sensör Aktiflik
                          Expanded(
                            flex: 6,
                            child: Column(
                              children: [
                                //Tank 1-2-3
                                Expanded(
                                  child: Row(
                                    children: [
                                      Spacer(),
                                      //Tank 1 Sanal Sensör Aktif
                                      Expanded(
                                        flex: 2,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Spacer(),
                                            Expanded(
                                              flex: 2,
                                              child: SizedBox(
                                                child: Container(
                                                  alignment:
                                                      Alignment.bottomCenter,
                                                  child: AutoSizeText(
                                                    "Tank 1",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      fontFamily: 'Kelly Slab',
                                                      color: Colors.black,
                                                      fontSize: 60,
                                                      //fontWeight: FontWeight.bold
                                                    ),
                                                    maxLines: 1,
                                                    minFontSize: 8,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 3,
                                              child: Container(
                                                alignment: Alignment.topCenter,
                                                child: RawMaterialButton(
                                                  onPressed: () {
                                                    _index = 1;
                                                    if (t1SanalSensorAktiflik) {
                                                      t1SanalSensorAktiflik =
                                                          false;
                                                    } else {
                                                      t1SanalSensorAktiflik =
                                                          true;
                                                    }
                                                    String veri =
                                                        t1SanalSensorAktiflik ==
                                                                true
                                                            ? '1'
                                                            : '0';

                                                    yazmaSonrasiGecikmeSayaci =
                                                        0;
                                                    String komut = "2*1*$veri";
                                                    veriGonder(komut, 3000)
                                                        .then((value) {
                                                      if (value.split("*")[0] ==
                                                          "error") {
                                                        Toast.show(
                                                            "Yazdırma hatası! Yazdırma portu kapalı.Ağ hatası yoksa Server PC\'yi yeniden başlatınız.",
                                                            context,
                                                            duration: 3);
                                                      } else {
                                                        Toast.show(
                                                            "Başarılı", context,
                                                            duration: 3);

                                                        baglanti = false;
                                                      }
                                                    });

                                                    setState(() {});
                                                  },
                                                  child: Icon(
                                                    t1SanalSensorAktiflik ==
                                                            true
                                                        ? Icons.check_box
                                                        : Icons
                                                            .check_box_outline_blank,
                                                    color:
                                                        t1SanalSensorAktiflik ==
                                                                true
                                                            ? Colors.green[600]
                                                            : Colors.black,
                                                    size: 20 * oran,
                                                  ),
                                                  padding: EdgeInsets.all(0),
                                                  materialTapTargetSize:
                                                      MaterialTapTargetSize
                                                          .shrinkWrap,
                                                  constraints: BoxConstraints(),
                                                ),
                                              ),
                                            ),
                                            //Spacer(flex: 1,)
                                          ],
                                        ),
                                      ),
                                      Spacer(),
                                      //Tank 2 Sanal Sensör Aktif
                                      Expanded(
                                        flex: 2,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Spacer(),
                                            Expanded(
                                              flex: 2,
                                              child: SizedBox(
                                                child: Container(
                                                  alignment:
                                                      Alignment.bottomCenter,
                                                  child: AutoSizeText(
                                                    "Tank 2",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      fontFamily: 'Kelly Slab',
                                                      color: Colors.black,
                                                      fontSize: 60,
                                                      //fontWeight: FontWeight.bold
                                                    ),
                                                    maxLines: 1,
                                                    minFontSize: 8,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 3,
                                              child: Container(
                                                alignment: Alignment.topCenter,
                                                child: RawMaterialButton(
                                                  onPressed: () {
                                                    _index = 2;
                                                    if (t2SanalSensorAktiflik) {
                                                      t2SanalSensorAktiflik =
                                                          false;
                                                    } else {
                                                      t2SanalSensorAktiflik =
                                                          true;
                                                    }
                                                    String veri =
                                                        t2SanalSensorAktiflik ==
                                                                true
                                                            ? '1'
                                                            : '0';

                                                    yazmaSonrasiGecikmeSayaci =
                                                        0;
                                                    String komut = "2*2*$veri";
                                                    veriGonder(komut, 3000)
                                                        .then((value) {
                                                      if (value.split("*")[0] ==
                                                          "error") {
                                                        Toast.show(
                                                            "Yazdırma hatası! Yazdırma portu kapalı.Ağ hatası yoksa Server PC\'yi yeniden başlatınız.",
                                                            context,
                                                            duration: 3);
                                                      } else {
                                                        Toast.show(
                                                            "Başarılı", context,
                                                            duration: 3);

                                                        baglanti = false;
                                                      }
                                                    });

                                                    setState(() {});
                                                  },
                                                  child: Icon(
                                                    t2SanalSensorAktiflik ==
                                                            true
                                                        ? Icons.check_box
                                                        : Icons
                                                            .check_box_outline_blank,
                                                    color:
                                                        t2SanalSensorAktiflik ==
                                                                true
                                                            ? Colors.green[600]
                                                            : Colors.black,
                                                    size: 20 * oran,
                                                  ),
                                                  padding: EdgeInsets.all(0),
                                                  materialTapTargetSize:
                                                      MaterialTapTargetSize
                                                          .shrinkWrap,
                                                  constraints: BoxConstraints(),
                                                ),
                                              ),
                                            ),
                                            //Spacer(flex: 1,)
                                          ],
                                        ),
                                      ),
                                      Spacer(),
                                      //Tank 3 Sanal Sensör Aktif
                                      Expanded(
                                        flex: 2,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Spacer(),
                                            Expanded(
                                              flex: 2,
                                              child: SizedBox(
                                                child: Container(
                                                  alignment:
                                                      Alignment.bottomCenter,
                                                  child: AutoSizeText(
                                                    "Tank 3",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      fontFamily: 'Kelly Slab',
                                                      color: Colors.black,
                                                      fontSize: 60,
                                                      //fontWeight: FontWeight.bold
                                                    ),
                                                    maxLines: 1,
                                                    minFontSize: 8,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 3,
                                              child: Container(
                                                alignment: Alignment.topCenter,
                                                child: RawMaterialButton(
                                                  onPressed: () {
                                                    _index = 3;
                                                    if (t3SanalSensorAktiflik) {
                                                      t3SanalSensorAktiflik =
                                                          false;
                                                    } else {
                                                      t3SanalSensorAktiflik =
                                                          true;
                                                    }
                                                    String veri =
                                                        t3SanalSensorAktiflik ==
                                                                true
                                                            ? '1'
                                                            : '0';

                                                    yazmaSonrasiGecikmeSayaci =
                                                        0;
                                                    String komut = "2*3*$veri";
                                                    veriGonder(komut, 3000)
                                                        .then((value) {
                                                      if (value.split("*")[0] ==
                                                          "error") {
                                                        Toast.show(
                                                            "Yazdırma hatası! Yazdırma portu kapalı.Ağ hatası yoksa Server PC\'yi yeniden başlatınız.",
                                                            context,
                                                            duration: 3);
                                                      } else {
                                                        Toast.show(
                                                            "Başarılı", context,
                                                            duration: 3);

                                                        baglanti = false;
                                                      }
                                                    });

                                                    setState(() {});
                                                  },
                                                  child: Icon(
                                                    t3SanalSensorAktiflik ==
                                                            true
                                                        ? Icons.check_box
                                                        : Icons
                                                            .check_box_outline_blank,
                                                    color:
                                                        t3SanalSensorAktiflik ==
                                                                true
                                                            ? Colors.green[600]
                                                            : Colors.black,
                                                    size: 20 * oran,
                                                  ),
                                                  padding: EdgeInsets.all(0),
                                                  materialTapTargetSize:
                                                      MaterialTapTargetSize
                                                          .shrinkWrap,
                                                  constraints: BoxConstraints(),
                                                ),
                                              ),
                                            ),
                                            //Spacer(flex: 1,)
                                          ],
                                        ),
                                      ),
                                      Spacer()
                                    ],
                                  ),
                                ),
                                //Tank 4-5
                                Expanded(
                                  child: Row(
                                    children: [
                                      Spacer(),
                                      //Tank 4 Sanal Sensör Aktif
                                      Expanded(
                                        flex: 2,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Spacer(),
                                            Expanded(
                                              flex: 2,
                                              child: SizedBox(
                                                child: Container(
                                                  alignment:
                                                      Alignment.bottomCenter,
                                                  child: AutoSizeText(
                                                    "Tank 4",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      fontFamily: 'Kelly Slab',
                                                      color: Colors.black,
                                                      fontSize: 60,
                                                      //fontWeight: FontWeight.bold
                                                    ),
                                                    maxLines: 1,
                                                    minFontSize: 8,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 3,
                                              child: Container(
                                                alignment: Alignment.topCenter,
                                                child: RawMaterialButton(
                                                  onPressed: () {
                                                    _index = 4;
                                                    if (t4SanalSensorAktiflik) {
                                                      t4SanalSensorAktiflik =
                                                          false;
                                                    } else {
                                                      t4SanalSensorAktiflik =
                                                          true;
                                                    }
                                                    String veri =
                                                        t4SanalSensorAktiflik ==
                                                                true
                                                            ? '1'
                                                            : '0';

                                                    yazmaSonrasiGecikmeSayaci =
                                                        0;
                                                    String komut = "2*4*$veri";
                                                    veriGonder(komut, 3000)
                                                        .then((value) {
                                                      if (value.split("*")[0] ==
                                                          "error") {
                                                        Toast.show(
                                                            "Yazdırma hatası! Yazdırma portu kapalı.Ağ hatası yoksa Server PC\'yi yeniden başlatınız.",
                                                            context,
                                                            duration: 3);
                                                      } else {
                                                        Toast.show(
                                                            "Başarılı", context,
                                                            duration: 3);

                                                        baglanti = false;
                                                      }
                                                    });

                                                    setState(() {});
                                                  },
                                                  child: Icon(
                                                    t4SanalSensorAktiflik ==
                                                            true
                                                        ? Icons.check_box
                                                        : Icons
                                                            .check_box_outline_blank,
                                                    color:
                                                        t4SanalSensorAktiflik ==
                                                                true
                                                            ? Colors.green[600]
                                                            : Colors.black,
                                                    size: 20 * oran,
                                                  ),
                                                  padding: EdgeInsets.all(0),
                                                  materialTapTargetSize:
                                                      MaterialTapTargetSize
                                                          .shrinkWrap,
                                                  constraints: BoxConstraints(),
                                                ),
                                              ),
                                            ),
                                            //Spacer(flex: 1,)
                                          ],
                                        ),
                                      ),
                                      Spacer(),
                                      //Tank 5 Sanal Sensör Aktif
                                      Expanded(
                                        flex: 2,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Spacer(),
                                            Expanded(
                                              flex: 2,
                                              child: SizedBox(
                                                child: Container(
                                                  alignment:
                                                      Alignment.bottomCenter,
                                                  child: AutoSizeText(
                                                    "Tank 5",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      fontFamily: 'Kelly Slab',
                                                      color: Colors.black,
                                                      fontSize: 60,
                                                      //fontWeight: FontWeight.bold
                                                    ),
                                                    maxLines: 1,
                                                    minFontSize: 8,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 3,
                                              child: Container(
                                                alignment: Alignment.topCenter,
                                                child: RawMaterialButton(
                                                  onPressed: () {
                                                    _index = 5;
                                                    if (t5SanalSensorAktiflik) {
                                                      t5SanalSensorAktiflik =
                                                          false;
                                                    } else {
                                                      t5SanalSensorAktiflik =
                                                          true;
                                                    }
                                                    String veri =
                                                        t5SanalSensorAktiflik ==
                                                                true
                                                            ? '1'
                                                            : '0';

                                                    yazmaSonrasiGecikmeSayaci =
                                                        0;
                                                    String komut = "2*5*$veri";
                                                    veriGonder(komut, 3000)
                                                        .then((value) {
                                                      if (value.split("*")[0] ==
                                                          "error") {
                                                        Toast.show(
                                                            "Yazdırma hatası! Yazdırma portu kapalı.Ağ hatası yoksa Server PC\'yi yeniden başlatınız.",
                                                            context,
                                                            duration: 3);
                                                      } else {
                                                        Toast.show(
                                                            "Başarılı", context,
                                                            duration: 3);

                                                        baglanti = false;
                                                      }
                                                    });

                                                    setState(() {});
                                                  },
                                                  child: Icon(
                                                    t5SanalSensorAktiflik ==
                                                            true
                                                        ? Icons.check_box
                                                        : Icons
                                                            .check_box_outline_blank,
                                                    color:
                                                        t5SanalSensorAktiflik ==
                                                                true
                                                            ? Colors.green[600]
                                                            : Colors.black,
                                                    size: 20 * oran,
                                                  ),
                                                  padding: EdgeInsets.all(0),
                                                  materialTapTargetSize:
                                                      MaterialTapTargetSize
                                                          .shrinkWrap,
                                                  constraints: BoxConstraints(),
                                                ),
                                              ),
                                            ),
                                            //Spacer(flex: 1,)
                                          ],
                                        ),
                                      ),
                                      Spacer(
                                        flex: 4,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Spacer(
                            flex: 1,
                          ),
                          //Pamuk-Soya seçimi
                          Expanded(
                              flex: 3,
                              child: Row(
                                children: [
                                  Spacer(
                                    flex: 1,
                                  ),
                                  //PAMUK seçim butonu
                                  Expanded(
                                    flex: 6,
                                    child: Column(
                                      children: [
                                        Spacer(),
                                        Expanded(flex: 4,
                                          child: RawMaterialButton(
                                            constraints: BoxConstraints(
                                                minWidth: double.infinity),
                                            onPressed: () {
                                              if (urunTipi == "2") {
                                                urunTipi = "1";
                                              }

                                              yazmaSonrasiGecikmeSayaci = 0;
                                              String komut = "1*$urunTipi";
                                              veriGonder(komut, 3000).then((value) {
                                                if (value.split("*")[0] == "error") {
                                                  Toast.show(
                                                      "Yazdırma hatası! Yazdırma portu kapalı.Ağ hatası yoksa Server PC\'yi yeniden başlatınız.",
                                                      context,
                                                      duration: 3);
                                                } else {
                                                  Toast.show("Başarılı", context,
                                                      duration: 3);

                                                  baglanti = false;
                                                }
                                              });

                                              setState(() {});
                                            },
                                            fillColor: urunTipi == "1"
                                                ? Colors.green
                                                : Colors.grey,
                                            child: SizedBox(
                                              child: Container(
                                                child: AutoSizeText(
                                                  "PAMUK",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 30,
                                                      fontWeight: FontWeight.bold),
                                                  maxLines: 1,
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Spacer(),
                                      ],
                                    ),
                                  ),
                                  Spacer(
                                    flex: 1,
                                  ),
                                  //SOYA seçim butonu
                                  Expanded(
                                    flex: 6,
                                    child: Column(
                                      children: [
                                        Spacer(),
                                        Expanded(flex: 4,
                                          child: RawMaterialButton(
                                            constraints: BoxConstraints(
                                                minWidth: double.infinity),
                                            onPressed: () {
                                              if (urunTipi == "1") {
                                                urunTipi = "2";
                                              }

                                              yazmaSonrasiGecikmeSayaci = 0;
                                              String komut = "1*$urunTipi";
                                              veriGonder(komut, 3000).then((value) {
                                                if (value.split("*")[0] == "error") {
                                                  Toast.show(
                                                      "Yazdırma hatası! Yazdırma portu kapalı.Ağ hatası yoksa Server PC\'yi yeniden başlatınız.",
                                                      context,
                                                      duration: 3);
                                                } else {
                                                  Toast.show("Başarılı", context,
                                                      duration: 3);

                                                  baglanti = false;
                                                }
                                              });

                                              setState(() {});
                                            },
                                            fillColor: urunTipi == "2"
                                                ? Colors.green
                                                : Colors.grey,
                                            child: SizedBox(
                                              child: Container(
                                                child: AutoSizeText(
                                                  "SOYA",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 30,
                                                      fontWeight: FontWeight.bold),
                                                  maxLines: 1,
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Spacer()
                                      ],
                                    ),
                                  ),
                                  Spacer(
                                    flex: 1,
                                  ),
                                ],
                              )),
                          Spacer(),
                          //Bağlantı durumu
                          Expanded(
                            flex: 3,
                            child: Container(
                                alignment: Alignment.bottomCenter,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white),
                                child: RawMaterialButton(
                                  onPressed: () {
                                    String mesaj = baglantiDurum == ""
                                        ? "Bağlantı Sorunu Yok"
                                        : baglantiDurum;
                                    Toast.show(mesaj, context, duration: 5);
                                  },
                                  child: LayoutBuilder(
                                    builder: (context, constraints) {
                                      return Icon(
                                        Icons.router,
                                        size: constraints.biggest.height,
                                        color: baglantiDurum == ""
                                            ? Colors.green
                                            : Colors.deepOrange[700],
                                      );
                                    },
                                  ),
                                )),
                          ),
                        ],
                      ),
                    ),
                    //Log verileri
                    Expanded(
                      flex: 3,
                      child: Container(
                        padding: EdgeInsets.all(3*oran),
                        margin: EdgeInsets.all(3*oran),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15*oran),
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                                                      BorderRadius.circular(5*oran),
                                                  color: Colors.blue),
                                              margin: EdgeInsets.only(
                                                  left: 2*oran, right: 2*oran),
                                              child: RawMaterialButton(
                                                constraints: BoxConstraints(
                                                    minWidth: double.infinity),
                                                padding: EdgeInsets.all(0),
                                                child: SizedBox(
                                                  child: Container(
                                                    alignment: Alignment.center,
                                                    child: AutoSizeText(
                                                      kayitTuru(kayitTuruIndex),
                                                      style: TextStyle(
                                                        //fontFamily: 'Kelly Slab',
                                                        color: Colors.yellow,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 25,
                                                      ),
                                                      maxLines: 1,
                                                    ),
                                                  ),
                                                ),
                                                onPressed: () {
                                                  showModalBottomSheet<void>(
                                                      context: context,
                                                      builder: (BuildContext
                                                          context) {
                                                        return StatefulBuilder(
                                                          builder:
                                                              (context, state) {
                                                            return Container(
                                                              color:
                                                                  Colors.orange,
                                                              height: double
                                                                  .infinity,
                                                              child: Column(
                                                                children: <
                                                                    Widget>[
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
                                                                            fontSize:
                                                                                30,
                                                                            fontWeight:
                                                                                FontWeight.bold),
                                                                    ),
                                                                        )),
                                                                  ),
                                                                  //Kayıt türü seçim bölümü
                                                                  Expanded(
                                                                    flex: 10,
                                                                    child:
                                                                        Container(
                                                                      color: Colors
                                                                          .white,
                                                                      child:
                                                                          Column(
                                                                        children: <
                                                                            Widget>[
                                                                          Spacer(
                                                                            flex:
                                                                                1,
                                                                          ),
                                                                          //TANK 1 - TANK2
                                                                          Expanded(
                                                                            flex:
                                                                                3,
                                                                            child:
                                                                                Row(
                                                                              children: <Widget>[
                                                                                Spacer(),
                                                                                //TANK 1
                                                                                Expanded(
                                                                                    flex: 4,
                                                                                    child: Container(
                                                                                      alignment: Alignment.center,
                                                                                      margin: EdgeInsets.all(3),
                                                                                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.blue),
                                                                                      child: Column(
                                                                                        children: <Widget>[
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
                                                                                                gelenDoluluk = [];
                                                                                                gelenMiktar = [];
                                                                                                gelensens1 = [];
                                                                                                gelensens2 = [];
                                                                                                gelensens3 = [];
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
                                                                                    child: Container(
                                                                                      alignment: Alignment.center,
                                                                                      margin: EdgeInsets.all(3),
                                                                                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.blue),
                                                                                      child: Column(
                                                                                        children: <Widget>[
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
                                                                                                gelenDoluluk = [];
                                                                                                gelenMiktar = [];
                                                                                                gelensens1 = [];
                                                                                                gelensens2 = [];
                                                                                                gelensens3 = [];
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
                                                                            flex:
                                                                                3,
                                                                            child:
                                                                                Row(
                                                                              children: <Widget>[
                                                                                Spacer(),
                                                                                //TANK 3
                                                                                Expanded(
                                                                                    flex: 4,
                                                                                    child: Container(
                                                                                      alignment: Alignment.center,
                                                                                      margin: EdgeInsets.all(3),
                                                                                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.blue),
                                                                                      child: Column(
                                                                                        children: <Widget>[
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
                                                                                                gelenDoluluk = [];
                                                                                                gelenMiktar = [];
                                                                                                gelensens1 = [];
                                                                                                gelensens2 = [];
                                                                                                gelensens3 = [];
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
                                                                                    child: Container(
                                                                                      alignment: Alignment.center,
                                                                                      margin: EdgeInsets.all(3),
                                                                                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.blue),
                                                                                      child: Column(
                                                                                        children: <Widget>[
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
                                                                                                gelenDoluluk = [];
                                                                                                gelenMiktar = [];
                                                                                                gelensens1 = [];
                                                                                                gelensens2 = [];
                                                                                                gelensens3 = [];
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
                                                                            flex:
                                                                                3,
                                                                            child:
                                                                                Row(
                                                                              children: <Widget>[
                                                                                Spacer(),
                                                                                //TANK 5
                                                                                Expanded(
                                                                                    flex: 4,
                                                                                    child: Container(
                                                                                      alignment: Alignment.center,
                                                                                      margin: EdgeInsets.all(3),
                                                                                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.blue),
                                                                                      child: Column(
                                                                                        children: <Widget>[
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
                                                                                                gelenDoluluk = [];
                                                                                                gelenMiktar = [];
                                                                                                gelensens1 = [];
                                                                                                gelensens2 = [];
                                                                                                gelensens3 = [];
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
                                                                            flex:
                                                                                1,
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Expanded(
                                          flex: 2,
                                          child: SizedBox(
                                            child: Container(
                                              alignment: Alignment.center,
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
                                            alignment: Alignment.center,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(5*oran),
                                                  color: Colors.blue),
                                              margin: EdgeInsets.only(
                                                  left: 2*oran, right: 2*oran),
                                              child: RawMaterialButton(
                                                constraints: BoxConstraints(
                                                    minWidth: double.infinity),
                                                padding: EdgeInsets.all(0),
                                                child: SizedBox(
                                                  child: Container(
                                                    child: AutoSizeText(
                                                      logDonguSuresi + " dk",
                                                      style: TextStyle(
                                                        fontFamily:
                                                            'Kelly Slab',
                                                        fontWeight:
                                                            FontWeight.bold,
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
                                                      builder: (BuildContext
                                                          context) {
                                                        return StatefulBuilder(
                                                          builder:
                                                              (context, state) {
                                                            return Container(
                                                              color:
                                                                  Colors.orange,
                                                              height: double
                                                                  .infinity,
                                                              child: Column(
                                                                children: <
                                                                    Widget>[
                                                                  //Başlık bölümü
                                                                  Expanded(
                                                                    flex: 1,
                                                                    child: SizedBox(
                                                                        child: Container(
                                                                      child:
                                                                          AutoSizeText(
                                                                        "Log Periyot",
                                                                        maxLines:
                                                                            1,
                                                                        style: TextStyle(
                                                                            fontFamily:
                                                                                'Kelly Slab',
                                                                            fontSize:
                                                                                30,
                                                                            fontWeight:
                                                                                FontWeight.bold),
                                                                      ),
                                                                    )),
                                                                  ),
                                                                  //Log periyot
                                                                  Expanded(
                                                                    flex: 10,
                                                                    child:
                                                                        Container(
                                                                      color: Colors
                                                                          .white,
                                                                      child:
                                                                          Column(
                                                                        children: <
                                                                            Widget>[
                                                                          Spacer(
                                                                            flex:
                                                                                3,
                                                                          ),
                                                                          Expanded(
                                                                            flex:
                                                                                2,
                                                                            child:
                                                                                Row(
                                                                              children: <Widget>[
                                                                                //5 dk
                                                                                Expanded(
                                                                                    child: Container(
                                                                                  alignment: Alignment.center,
                                                                                  margin: EdgeInsets.all(5 * oran),
                                                                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10 * oran), color: Colors.blue),
                                                                                  child: Column(
                                                                                    children: <Widget>[
                                                                                      Spacer(),
                                                                                      Expanded(
                                                                                        flex: 6,
                                                                                        child: RawMaterialButton(
                                                                                          constraints: BoxConstraints(minWidth: double.infinity),
                                                                                          padding: EdgeInsets.all(0),
                                                                                          onPressed: () {
                                                                                            logDonguSuresi = "5";
                                                                                            setState(() {
                                                                                              Navigator.pop(context);
                                                                                            });
                                                                                          },
                                                                                          child: SizedBox(
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
                                                                                    child: Container(
                                                                                  alignment: Alignment.center,
                                                                                  margin: EdgeInsets.all(5 * oran),
                                                                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10 * oran), color: Colors.blue),
                                                                                  child: Column(
                                                                                    children: <Widget>[
                                                                                      Spacer(),
                                                                                      Expanded(
                                                                                        flex: 6,
                                                                                        child: RawMaterialButton(
                                                                                          constraints: BoxConstraints(minWidth: double.infinity),
                                                                                          padding: EdgeInsets.all(0),
                                                                                          onPressed: () {
                                                                                            logDonguSuresi = "10";
                                                                                            setState(() {
                                                                                              Navigator.pop(context);
                                                                                            });
                                                                                          },
                                                                                          child: SizedBox(
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
                                                                                    child: Container(
                                                                                  alignment: Alignment.center,
                                                                                  margin: EdgeInsets.all(5 * oran),
                                                                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10 * oran), color: Colors.blue),
                                                                                  child: Column(
                                                                                    children: <Widget>[
                                                                                      Spacer(),
                                                                                      Expanded(
                                                                                        flex: 6,
                                                                                        child: RawMaterialButton(
                                                                                          constraints: BoxConstraints(minWidth: double.infinity),
                                                                                          padding: EdgeInsets.all(0),
                                                                                          onPressed: () {
                                                                                            logDonguSuresi = "15";
                                                                                            setState(() {
                                                                                              Navigator.pop(context);
                                                                                            });
                                                                                          },
                                                                                          child: SizedBox(
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
                                                                                    child: Container(
                                                                                  alignment: Alignment.center,
                                                                                  margin: EdgeInsets.all(5 * oran),
                                                                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10 * oran), color: Colors.blue),
                                                                                  child: Column(
                                                                                    children: <Widget>[
                                                                                      Spacer(),
                                                                                      Expanded(
                                                                                        flex: 6,
                                                                                        child: RawMaterialButton(
                                                                                          constraints: BoxConstraints(minWidth: double.infinity),
                                                                                          padding: EdgeInsets.all(0),
                                                                                          onPressed: () {
                                                                                            logDonguSuresi = "30";
                                                                                            setState(() {
                                                                                              Navigator.pop(context);
                                                                                            });
                                                                                          },
                                                                                          child: SizedBox(
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
                                                                                    child: Container(
                                                                                  alignment: Alignment.center,
                                                                                  margin: EdgeInsets.all(5 * oran),
                                                                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10 * oran), color: Colors.blue),
                                                                                  child: Column(
                                                                                    children: <Widget>[
                                                                                      Spacer(),
                                                                                      Expanded(
                                                                                        flex: 6,
                                                                                        child: RawMaterialButton(
                                                                                          constraints: BoxConstraints(minWidth: double.infinity),
                                                                                          padding: EdgeInsets.all(0),
                                                                                          onPressed: () {
                                                                                            logDonguSuresi = "60";
                                                                                            setState(() {
                                                                                              Navigator.pop(context);
                                                                                            });
                                                                                          },
                                                                                          child: SizedBox(
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
                                                                            flex:
                                                                                5,
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                                            alignment: Alignment.center,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(5*oran),
                                                  color: Colors.blue),
                                              margin: EdgeInsets.only(
                                                  left: 2*oran, right: 2*oran),
                                              child: RawMaterialButton(
                                                constraints: BoxConstraints(
                                                    minWidth: double.infinity),
                                                padding: EdgeInsets.all(0),
                                                child: SizedBox(
                                                  child: Container(
                                                    child: AutoSizeText(
                                                      DateFormat('dd-MM-yyyy')
                                                          .format(tarihIlk),
                                                      style: TextStyle(
                                                        fontFamily:
                                                            'Kelly Slab',
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white,
                                                        fontSize: 25,
                                                      ),
                                                      maxLines: 1,
                                                    ),
                                                  ),
                                                ),
                                                onPressed: () {
                                                  _selectDate(
                                                      context, 1, tarihIlk);
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                                            alignment: Alignment.center,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(5*oran),
                                                  color: Colors.blue),
                                              margin: EdgeInsets.only(
                                                  left: 2*oran, right: 2*oran),
                                              child: RawMaterialButton(
                                                constraints: BoxConstraints(
                                                    minWidth: double.infinity),
                                                padding: EdgeInsets.all(0),
                                                child: SizedBox(
                                                  child: Container(
                                                    child: AutoSizeText(
                                                      DateFormat('dd-MM-yyyy')
                                                          .format(tarihSon),
                                                      style: TextStyle(
                                                        fontFamily:
                                                            'Kelly Slab',
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white,
                                                        fontSize: 25,
                                                      ),
                                                      maxLines: 1,
                                                    ),
                                                  ),
                                                ),
                                                onPressed: () {
                                                  _selectDate(
                                                      context, 2, tarihSon);
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                                                      BorderRadius.circular(5*oran),
                                                  color: Colors.green[700]),
                                              margin: EdgeInsets.only(
                                                  left: 2*oran, right: 2*oran),
                                              child: RawMaterialButton(
                                                constraints: BoxConstraints(
                                                    minWidth: double.infinity),
                                                padding: EdgeInsets.all(0),
                                                child: SizedBox(
                                                  child: Container(
                                                    child: AutoSizeText(
                                                      "GETİR",
                                                      style: TextStyle(
                                                          fontFamily:
                                                              'Kelly Slab',
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 25,
                                                          color: Colors.white),
                                                      maxLines: 1,
                                                    ),
                                                  ),
                                                ),
                                                onLongPress: () {
                                                  kayitAdet = 0;
                                                  gelenZaman = [];

                                                  gelenDoluluk = [];
                                                  gelenMiktar = [];
                                                  gelensens1 = [];
                                                  gelensens2 = [];
                                                  gelensens3 = [];
                                                  Toast.show(
                                                      "Log tablosu sıfırlandı",
                                                      context,
                                                      duration: 2);
                                                  setState(() {});
                                                },
                                                onPressed: () {
                                                  if (tarihIlk.month !=
                                                          tarihSon.month ||
                                                      tarihIlk.year !=
                                                          tarihSon.year) {
                                                    Toast.show(
                                                        "Tarih İlk ve Tarih Son parametrelerine aynı ay ve yıl girilmelidir!",
                                                        context,
                                                        duration: 3);
                                                  } else if(tarihSon.day-tarihIlk.day>2 && logDonguSuresi=="5"){
                                                    Toast.show(
                                                        "5 dk\'lık periyot için bir defada en fazla 3 günlük veri çekebilirsiniz.",
                                                        context,
                                                        duration: 3);
                                                  } else if(tarihSon.day-tarihIlk.day>5 && logDonguSuresi=="10"){
                                                    Toast.show(
                                                        "10 dk\'lık periyot için bir defada en fazla 6 günlük veri çekebilirsiniz.",
                                                        context,
                                                        duration: 3);
                                                  } else if(tarihSon.day-tarihIlk.day>8 && logDonguSuresi=="15"){
                                                    Toast.show(
                                                        "15 dk\'lık periyot için bir defada en fazla 9 günlük veri çekebilirsiniz.",
                                                        context,
                                                        duration: 3);
                                                  } else if(tarihSon.day-tarihIlk.day>11 && logDonguSuresi=="20"){
                                                    Toast.show(
                                                        "20 dk\'lık periyot için bir defada en fazla 12 günlük veri çekebilirsiniz.",
                                                        context,
                                                        duration: 3);
                                                  } else if(tarihSon.day-tarihIlk.day>17 && logDonguSuresi=="30"){
                                                    Toast.show(
                                                        "30 dk\'lık periyot için bir defada en fazla 18 günlük veri çekebilirsiniz.",
                                                        context,
                                                        duration: 3);
                                                  } else {
                                                    String gunIlk =
                                                        tarihIlk.day.toString();
                                                    String gunSon =
                                                        tarihSon.day.toString();
                                                    String ayy = tarihIlk.month
                                                        .toString();
                                                    String yil = tarihIlk.year
                                                        .toString();
                                                    String tabloAdi =
                                                        "dlog$kayitTuruIndex" +
                                                            (ayy.length == 1
                                                                ? ("0" + ayy)
                                                                : ayy) +
                                                            yil;
                                                    print(tabloAdi);

                                                    yazmaSonrasiGecikmeSayaci =
                                                        0;
                                                    String komut =
                                                        '1*$tabloAdi*$logDonguSuresi*$gunIlk*$gunSon';
                                                    veriGonder(komut, 3002)
                                                        .then((value) {
                                                      if (value.split("*")[0] ==
                                                          "error") {
                                                        Toast.show(
                                                            "Yazdırma hatası! Yazdırma portu kapalı.Ağ hatası yoksa Server PC\'yi yeniden başlatınız.",
                                                            context,
                                                            duration: 3);
                                                      } else {
                                                        Toast.show(
                                                            "Başarılı", context,
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
                                                  child: SizedBox(
                                                    child: Container(
                                                      child: AutoSizeText(
                                                        "KAYIT NO",
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                          fontSize: 20,
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          decoration:
                                                              TextDecoration
                                                                  .underline,
                                                        ),
                                                        maxLines: 1,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                //ZAMAN
                                                Expanded(
                                                  flex: 2,
                                                  child: SizedBox(
                                                    child: Container(
                                                      child: AutoSizeText(
                                                        "ZAMAN",
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                          fontSize: 20,
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          decoration:
                                                              TextDecoration
                                                                  .underline,
                                                        ),
                                                        maxLines: 1,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                //Doluluk
                                                Expanded(
                                                  flex: 1,
                                                  child: SizedBox(
                                                    child: Container(
                                                      child: AutoSizeText(
                                                        "DOLULUK",
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                          fontSize: 20,
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          decoration:
                                                              TextDecoration
                                                                  .underline,
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
                                                    child: Container(
                                                      child: AutoSizeText(
                                                        "MİKTAR",
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                          fontSize: 20,
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          decoration:
                                                              TextDecoration
                                                                  .underline,
                                                        ),
                                                        maxLines: 1,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                //Sensör 1
                                                Expanded(
                                                  flex: 1,
                                                  child: SizedBox(
                                                    child: Container(
                                                      child: AutoSizeText(
                                                        "SENS 1",
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                          fontSize: 20,
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          decoration:
                                                              TextDecoration
                                                                  .underline,
                                                        ),
                                                        maxLines: 1,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                //Sensör 2
                                                Expanded(
                                                  flex: 1,
                                                  child: SizedBox(
                                                    child: Container(
                                                      child: AutoSizeText(
                                                        "SENS 2",
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                          fontSize: 20,
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          decoration:
                                                              TextDecoration
                                                                  .underline,
                                                        ),
                                                        maxLines: 1,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                //Sensör 3
                                                Expanded(
                                                  flex: 1,
                                                  child: SizedBox(
                                                    child: Container(
                                                      child: AutoSizeText(
                                                        "SENS 3",
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                          fontSize: 20,
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          decoration:
                                                              TextDecoration
                                                                  .underline,
                                                        ),
                                                        maxLines: 1,
                                                      ),
                                                    ),
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
                                                itemBuilder: (BuildContext ctxt,
                                                    int index) {
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
                                                              child:
                                                                  AutoSizeText(
                                                                (index + 1)
                                                                    .toString(),
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 40,
                                                                  color: Colors
                                                                      .black,
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
                                                              child:
                                                                  AutoSizeText(
                                                                gelenZaman[
                                                                    index],
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 40,
                                                                  color: Colors
                                                                      .black,
                                                                ),
                                                                maxLines: 1,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        //Doluluk
                                                        Expanded(
                                                          flex: 1,
                                                          child: SizedBox(
                                                            height: 10 * oran,
                                                            child: Container(
                                                              child:
                                                                  AutoSizeText(
                                                                "% " +
                                                                    gelenDoluluk[
                                                                        index],
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style:
                                                                    TextStyle(
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
                                                              child:
                                                                  AutoSizeText(
                                                                gelenMiktar[
                                                                        index] +
                                                                    " Lt",
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style:
                                                                    TextStyle(
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
                                                              child:
                                                                  AutoSizeText(
                                                                gelensens1[
                                                                        index] +
                                                                    " °C",
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style:
                                                                    TextStyle(
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
                                                              child:
                                                                  AutoSizeText(
                                                                gelensens2[
                                                                        index] +
                                                                    " °C",
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style:
                                                                    TextStyle(
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
                                                              child:
                                                                  AutoSizeText(
                                                                gelensens3[
                                                                        index] +
                                                                    " °C",
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style:
                                                                    TextStyle(
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
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _landscapeModeOnly() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  veriIslemeGenel(String gelenMesaj) {
    var degerler = gelenMesaj.split('*');
    print(degerler);
    print(yazmaSonrasiGecikmeSayaci);

    dolulukT1 = double.parse(degerler[0]);
    dolulukT2 = double.parse(degerler[1]);
    dolulukT3 = double.parse(degerler[2]);
    dolulukT4 = double.parse(degerler[3]);
    dolulukT5 = double.parse(degerler[4]);

    litreT1 = degerler[5];
    litreT2 = degerler[6];
    litreT3 = degerler[7];
    litreT4 = degerler[8];
    litreT5 = degerler[9];

    t1SanalSensorAktiflik = degerler[10] == "1" ? true : false;
    t2SanalSensorAktiflik = degerler[11] == "1" ? true : false;
    t3SanalSensorAktiflik = degerler[12] == "1" ? true : false;
    t4SanalSensorAktiflik = degerler[13] == "1" ? true : false;
    t5SanalSensorAktiflik = degerler[14] == "1" ? true : false;

    t1sens1 = degerler[15];
    t1sens2 = degerler[16];
    t1sens3 = degerler[17];

    t2sens1 = degerler[18];
    t2sens2 = degerler[19];
    t2sens3 = degerler[20];

    t3sens1 = degerler[21];
    t3sens2 = degerler[22];
    t3sens3 = degerler[23];

    t4sens1 = degerler[24];
    t4sens2 = degerler[25];
    t4sens3 = degerler[26];

    t5sens1 = degerler[27];
    t5sens2 = degerler[28];
    t5sens3 = degerler[29];

    ortalamaT1 = degerler[30];
    ortalamaT2 = degerler[31];
    ortalamaT3 = degerler[32];
    ortalamaT4 = degerler[33];
    ortalamaT5 = degerler[34];

    urunTipi = degerler[35];

    t1SanSens = degerler[36];
    t2SanSens = degerler[37];
    t3SanSens = degerler[38];
    t4SanSens = degerler[39];
    t5SanSens = degerler[40];

    sensSev1 = degerler[41];
    sensSev2 = degerler[42];
    sensSev3 = degerler[43];

    t1ortalamadakiSensor[1] = true;
    t2ortalamadakiSensor[1] = true;
    t3ortalamadakiSensor[1] = true;
    t4ortalamadakiSensor[1] = true;
    t5ortalamadakiSensor[1] = true;

    if (dolulukT1 >= double.parse(sensSev2)) {
      t1ortalamadakiSensor[2] = true;
    } else {
      t1ortalamadakiSensor[2] = false;
    }

    if (dolulukT1 >= double.parse(sensSev3)) {
      t1ortalamadakiSensor[3] = true;
    } else {
      t1ortalamadakiSensor[3] = false;
    }

    if (dolulukT2 >= double.parse(sensSev2)) {
      t2ortalamadakiSensor[2] = true;
    } else {
      t2ortalamadakiSensor[2] = false;
    }

    if (dolulukT2 >= double.parse(sensSev3)) {
      t2ortalamadakiSensor[3] = true;
    } else {
      t2ortalamadakiSensor[3] = false;
    }

    if (dolulukT3 >= double.parse(sensSev2)) {
      t3ortalamadakiSensor[2] = true;
    } else {
      t3ortalamadakiSensor[2] = false;
    }

    if (dolulukT3 >= double.parse(sensSev3)) {
      t3ortalamadakiSensor[3] = true;
    } else {
      t3ortalamadakiSensor[3] = false;
    }

    if (dolulukT4 >= double.parse(sensSev2)) {
      t4ortalamadakiSensor[2] = true;
    } else {
      t4ortalamadakiSensor[2] = false;
    }

    if (dolulukT4 >= double.parse(sensSev3)) {
      t4ortalamadakiSensor[3] = true;
    } else {
      t4ortalamadakiSensor[3] = false;
    }

    if (dolulukT5 >= double.parse(sensSev2)) {
      t5ortalamadakiSensor[2] = true;
    } else {
      t5ortalamadakiSensor[2] = false;
    }

    if (dolulukT5 >= double.parse(sensSev3)) {
      t5ortalamadakiSensor[3] = true;
    } else {
      t5ortalamadakiSensor[3] = false;
    }

    print(t1ortalamadakiSensor);

    baglanti = false;
    if (!timerCancel) {
      setState(() {});
    }
  }

  veriIslemeLog(String gelenMesaj) {
    print(gelenMesaj);
    var degerler = gelenMesaj.split('#');
    kayitAdet = degerler.length - 1;
    gelenZaman = [];
    gelenDoluluk = [];
    gelenMiktar = [];
    gelensens1 = [];
    gelensens2 = [];
    gelensens3 = [];
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

        gelenDoluluk.add(degerler[i].split("*")[3]);
        gelenMiktar.add(degerler[i].split("*")[4]);
        gelensens1.add(degerler[i].split("*")[5]);
        gelensens2.add(degerler[i].split("*")[6]);
        gelensens3.add(degerler[i].split("*")[7]);
      }
    }

    baglanti = false;
    if (!timerCancel) {
      setState(() {});
    }
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

  Future<String> takipEt(String komut, int portNo) async {
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
      // GET FROM SERVER *********************
      _donusDegeri = new String.fromCharCodes(data).trim();
      _socket.close();
    }).catchError((error) {
      _donusDegeri = "error*" + error.toString().trim();
    });
    // ==============================================================

    return _donusDegeri;
  }

  Future _degergiris2X1(
      int onlar, birler, ondalik, index, baslik, onBaslik) async {
    // flutter defined function

    await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog

        return DegerGiris2X1.Deger(
            onlar, birler, ondalik, index, baslik, onBaslik);
      },
    ).then((val) {
      bool veriGonderilsinMi = false;
      if (_onlar != val[0] ||
          _birler != val[1] ||
          _ondalik != val[2] ||
          _index != val[3]) {
        veriGonderilsinMi = true;
      }
      _onlar = val[0];
      _birler = val[1];
      _ondalik = val[2];
      _index = val[3];

      String veri = "";

      if (index == 1) {
        //gun1Max = double.parse((_onlar == 0 ? "" : _onlar.toString()) + _birler.toString() + "." + _ondalik.toString());
        //veri = gun1Max.toString();

      }

      if (veriGonderilsinMi) {
        yazmaSonrasiGecikmeSayaci = 0;
        String komut = "31*$_index*$veri";
        veriGonder(komut, 2235).then((value) {
          if (value.split("*")[0] == "error") {
            Toast.show(
                "Yazdırma hatası! Yazdırma portu kapalı.Ağ hatası yoksa Server PC\'yi yeniden başlatınız.",
                context,
                duration: 3);
          } else {
            Toast.show("Başarılı", context, duration: 3);

            baglanti = false;
            takipEt('31*', 2236).then((veri) {
              if (veri.split("*")[0] == "error") {
                baglanti = false;
                baglantiDurum = veri.split("*")[1];
                setState(() {});
              } else {
                //takipEtVeriIsleme(veri);
                baglantiDurum = "";
              }
            });
          }
        });
      }

      setState(() {});
    });
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
}
