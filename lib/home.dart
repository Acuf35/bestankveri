import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:bestank/datalog.dart';
import 'package:bestank/tank_grafik_veriler.dart';
import 'package:bestank/tank_grafik.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/services.dart';
import 'package:toast/toast.dart';

import 'deger_giris_3x0.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String baglantiDurum = "";

  String ipNo = "192.168.1.120";

  int _yuzler = 0;
  int _onlar = 0;
  int _birler = 0;
  int _ondalik = 0;
  int _index = 0;

  bool timerCancel = false;
  int timerSayac = 0;
  bool baglanti = false;

  int yazmaSonrasiGecikmeSayaci = 4;

  String birim = "";
  bool t1SanalSensorAktiflik = false;
  bool t2SanalSensorAktiflik = false;
  bool t3SanalSensorAktiflik = false;
  bool t4SanalSensorAktiflik = false;
  bool t5SanalSensorAktiflik = false;

  bool t1SifirinAltindaYagVarMi = false;
  bool t2SifirinAltindaYagVarMi = false;
  bool t3SifirinAltindaYagVarMi = false;
  bool t4SifirinAltindaYagVarMi = false;
  bool t5SifirinAltindaYagVarMi = false;

  String manSeviyeT1 = "0";
  String manSeviyeT2 = "0";
  String manSeviyeT3 = "0";
  String manSeviyeT4 = "0";
  String manSeviyeT5 = "0";

  double seviyeT1 = 0.0;
  double seviyeT2 = 0.0;
  double seviyeT3 = 0.0;
  double seviyeT4 = 0.0;
  double seviyeT5 = 0.0;

  String agirlikT1 = "0.0";
  String agirlikT2 = "0.0";
  String agirlikT3 = "0.0";
  String agirlikT4 = "0.0";
  String agirlikT5 = "0.0";

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

  String t1UrunTipi = "1";
  String t2UrunTipi = "1";
  String t3UrunTipi = "1";
  String t4UrunTipi = "1";
  String t5UrunTipi = "1";

  String t1OlcumAktif = "1";
  String t2OlcumAktif = "1";
  String t3OlcumAktif = "1";
  String t4OlcumAktif = "1";
  String t5OlcumAktif = "1";

  String sensSev1 = "0.0";
  String sensSev2 = "0.0";
  String sensSev3 = "0.0";

  int sayac = 0;

  List<bool> t1ortalamadakiSensor = new List.filled(4, false);
  List<bool> t2ortalamadakiSensor = new List.filled(4, false);
  List<bool> t3ortalamadakiSensor = new List.filled(4, false);
  List<bool> t4ortalamadakiSensor = new List.filled(4, false);
  List<bool> t5ortalamadakiSensor = new List.filled(4, false);

  bool grafikVisibility = true;

  String tolerans = "0";

  List data;

  @override
  Widget build(BuildContext context) {
    //++++++++++++++++++++++++++STATUS BAR SAKLAMA ve EKRANI YATAYA SABİTLEME+++++++++++++++++++++++++++++++
    SystemChrome.setEnabledSystemUIOverlays([]);
    _landscapeModeOnly();
//--------------------------STATUS BAR SAKLAMA ve EKRANI YATAYA SABİTLEME--------------------------------

    var oran = MediaQuery.of(context).size.width / 731.4;
    if (oran == 0.0) {
      oran = 1265.6 / 731.4;
      grafikVisibility = false;
    } else {
      grafikVisibility = true;
    }
    var widthA = MediaQuery.of(context).size.width;
    var heightB = MediaQuery.of(context).size.height;
    print("$widthA    |    $heightB");

    List<TankGrafikVeriler> tank1 = [
      TankGrafikVeriler(
          seviyeMetin: "$seviyeT1" + " m",
          seviye: seviyeT1,
          barColor: charts.ColorUtil.fromDartColor(Colors.blue)),
    ];

    List<TankGrafikVeriler> tank2 = [
      TankGrafikVeriler(
          seviyeMetin: "$seviyeT2" + " m",
          seviye: seviyeT2,
          barColor: charts.ColorUtil.fromDartColor(Colors.blue)),
    ];

    List<TankGrafikVeriler> tank3 = [
      TankGrafikVeriler(
          seviyeMetin: "$seviyeT3" + " m",
          seviye: seviyeT3,
          barColor: charts.ColorUtil.fromDartColor(Colors.blue)),
    ];

    List<TankGrafikVeriler> tank4 = [
      TankGrafikVeriler(
          seviyeMetin: "$seviyeT4" + " m",
          seviye: seviyeT4,
          barColor: charts.ColorUtil.fromDartColor(Colors.blue)),
    ];

    List<TankGrafikVeriler> tank5 = [
      TankGrafikVeriler(
          seviyeMetin: "$seviyeT5" + " m",
          seviye: seviyeT5,
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
              flex: 5,
              child: Container(
                color: Colors.yellow[200],
                child: Column(
                  children: [
                    Expanded(
                      flex: 5,
                      child: Row(
                        children: [
                          Expanded(
                              child: Visibility(
                            visible: grafikVisibility,
                            child: TankGrafik(
                              "TANK 1",
                              "$agirlikT1 Kg",
                              t1sens1,
                              t1sens2,
                              t1sens3,
                              t1SanSens,
                              t1SanalSensorAktiflik,
                              t1OlcumAktif == "0" ? true : false,
                              t1SifirinAltindaYagVarMi,
                              1,
                              ortalamaT1,
                              double.parse(sensSev1),
                              double.parse(sensSev2),
                              double.parse(sensSev3),
                              t1ortalamadakiSensor[1],
                              t1ortalamadakiSensor[2],
                              t1ortalamadakiSensor[3],
                              oran,
                              manSeviyeT1,
                              data: tank1,
                            ),
                          )),
                          Expanded(
                              child: Visibility(
                            visible: grafikVisibility,
                            child: TankGrafik(
                              "TANK 2",
                              "$agirlikT2 Kg",
                              t2sens1,
                              t2sens2,
                              t2sens3,
                              t2SanSens,
                              t2SanalSensorAktiflik,
                              t2OlcumAktif == "0" ? true : false,
                              t2SifirinAltindaYagVarMi,
                              2,
                              ortalamaT2,
                              double.parse(sensSev1),
                              double.parse(sensSev2),
                              double.parse(sensSev3),
                              t2ortalamadakiSensor[1],
                              t2ortalamadakiSensor[2],
                              t2ortalamadakiSensor[3],
                              oran,
                              manSeviyeT2,
                              data: tank2,
                            ),
                          )),
                          Expanded(
                              child: Visibility(
                            visible: grafikVisibility,
                            child: TankGrafik(
                              "TANK 3",
                              "$agirlikT3 Kg",
                              t3sens1,
                              t3sens2,
                              t3sens3,
                              t3SanSens,
                              t3SanalSensorAktiflik,
                              t3OlcumAktif == "0" ? true : false,
                              t3SifirinAltindaYagVarMi,
                              3,
                              ortalamaT3,
                              double.parse(sensSev1),
                              double.parse(sensSev2),
                              double.parse(sensSev3),
                              t3ortalamadakiSensor[1],
                              t3ortalamadakiSensor[2],
                              t3ortalamadakiSensor[3],
                              oran,
                              manSeviyeT3,
                              data: tank3,
                            ),
                          )),
                          Expanded(
                              child: Visibility(
                            visible: grafikVisibility,
                            child: TankGrafik(
                              "TANK 4",
                              "$agirlikT4 Kg",
                              t4sens1,
                              t4sens2,
                              t4sens3,
                              t4SanSens,
                              t4SanalSensorAktiflik,
                              t4OlcumAktif == "0" ? true : false,
                              t4SifirinAltindaYagVarMi,
                              4,
                              ortalamaT4,
                              double.parse(sensSev1),
                              double.parse(sensSev2),
                              double.parse(sensSev3),
                              t4ortalamadakiSensor[1],
                              t4ortalamadakiSensor[2],
                              t4ortalamadakiSensor[3],
                              oran,
                              manSeviyeT4,
                              data: tank4,
                            ),
                          )),
                          Expanded(
                              child: Visibility(
                            visible: grafikVisibility,
                            child: TankGrafik(
                              "TANK 5",
                              "$agirlikT5 Kg",
                              t5sens1,
                              t5sens2,
                              t5sens3,
                              t5SanSens,
                              t5SanalSensorAktiflik,
                              t5OlcumAktif == "0" ? true : false,
                              t5SifirinAltindaYagVarMi,
                              5,
                              ortalamaT5,
                              double.parse(sensSev1),
                              double.parse(sensSev2),
                              double.parse(sensSev3),
                              t5ortalamadakiSensor[1],
                              t5ortalamadakiSensor[2],
                              t5ortalamadakiSensor[3],
                              oran,
                              manSeviyeT5,
                              data: tank5,
                            ),
                          )),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        color: Colors.yellow[200],
                        child: Row(
                          children: [
                            //Tank 1 Yağ seçimi
                            Expanded(
                                child: Column(
                              children: [
                                Expanded(
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
                                            Expanded(
                                              flex: 4,
                                              child: RawMaterialButton(
                                                elevation: 10,
                                                constraints: BoxConstraints(
                                                    minWidth: double.infinity),
                                                onPressed: () {
                                                  t1UrunTipi = "1";

                                                  yazmaSonrasiGecikmeSayaci = 0;
                                                  String komut =
                                                      "1*1*$t1UrunTipi";
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
                                                fillColor: t1UrunTipi == "1"
                                                    ? Colors.green
                                                    : Colors.grey[800],
                                                child: SizedBox(
                                                  child: Container(
                                                    child: AutoSizeText(
                                                      "PAMUK",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 30,
                                                          fontFamily:
                                                              'Kelly Slab',
                                                          fontWeight:
                                                              FontWeight.bold),
                                                      maxLines: 1,
                                                      textAlign:
                                                          TextAlign.center,
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
                                            Expanded(
                                              flex: 4,
                                              child: RawMaterialButton(
                                                elevation: 10,
                                                constraints: BoxConstraints(
                                                    minWidth: double.infinity),
                                                onPressed: () {
                                                  t1UrunTipi = "2";

                                                  yazmaSonrasiGecikmeSayaci = 0;
                                                  String komut =
                                                      "1*1*$t1UrunTipi";
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
                                                fillColor: t1UrunTipi == "2"
                                                    ? Colors.green
                                                    : Colors.grey[800],
                                                child: SizedBox(
                                                  child: Container(
                                                    child: AutoSizeText(
                                                      "SOYA",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 30,
                                                          fontFamily:
                                                              'Kelly Slab',
                                                          fontWeight:
                                                              FontWeight.bold),
                                                      maxLines: 1,
                                                      textAlign:
                                                          TextAlign.center,
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
                                  ),
                                ),
                                Expanded(
                                  child: Row(
                                    children: [
                                      Spacer(
                                        flex: 1,
                                      ),
                                      //AYÇİÇEĞİ seçim butonu
                                      Expanded(
                                        flex: 6,
                                        child: Column(
                                          children: [
                                            Spacer(),
                                            Expanded(
                                              flex: 4,
                                              child: RawMaterialButton(
                                                elevation: 10,
                                                constraints: BoxConstraints(
                                                    minWidth: double.infinity),
                                                onPressed: () {
                                                  t1UrunTipi = "3";

                                                  yazmaSonrasiGecikmeSayaci = 0;
                                                  String komut =
                                                      "1*1*$t1UrunTipi";
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
                                                fillColor: t1UrunTipi == "3"
                                                    ? Colors.green
                                                    : Colors.grey[800],
                                                child: SizedBox(
                                                  child: Container(
                                                    child: AutoSizeText(
                                                      "AYÇİÇEĞİ",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 30,
                                                          fontFamily:
                                                              'Kelly Slab',
                                                          fontWeight:
                                                              FontWeight.bold),
                                                      maxLines: 1,
                                                      textAlign:
                                                          TextAlign.center,
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
                                      //KANOLA seçim butonu
                                      Expanded(
                                        flex: 6,
                                        child: Column(
                                          children: [
                                            Spacer(),
                                            Expanded(
                                              flex: 4,
                                              child: RawMaterialButton(
                                                elevation: 10,
                                                constraints: BoxConstraints(
                                                    minWidth: double.infinity),
                                                onPressed: () {
                                                  t1UrunTipi = "4";

                                                  yazmaSonrasiGecikmeSayaci = 0;
                                                  String komut =
                                                      "1*1*$t1UrunTipi";
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
                                                fillColor: t1UrunTipi == "4"
                                                    ? Colors.green
                                                    : Colors.grey[800],
                                                child: SizedBox(
                                                  child: Container(
                                                    child: AutoSizeText(
                                                      "KANOLA",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 30,
                                                          fontFamily:
                                                              'Kelly Slab',
                                                          fontWeight:
                                                              FontWeight.bold),
                                                      maxLines: 1,
                                                      textAlign:
                                                          TextAlign.center,
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
                                  ),
                                )
                              ],
                            )),
                            //Tank 2 Yağ seçimi
                            Expanded(
                                child: Column(
                              children: [
                                Expanded(
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
                                            Expanded(
                                              flex: 4,
                                              child: RawMaterialButton(
                                                elevation: 10,
                                                constraints: BoxConstraints(
                                                    minWidth: double.infinity),
                                                onPressed: () {
                                                  t2UrunTipi = "1";

                                                  yazmaSonrasiGecikmeSayaci = 0;
                                                  String komut =
                                                      "1*2*$t2UrunTipi";
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
                                                fillColor: t2UrunTipi == "1"
                                                    ? Colors.green
                                                    : Colors.grey[800],
                                                child: SizedBox(
                                                  child: Container(
                                                    child: AutoSizeText(
                                                      "PAMUK",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 30,
                                                          fontFamily:
                                                              'Kelly Slab',
                                                          fontWeight:
                                                              FontWeight.bold),
                                                      maxLines: 1,
                                                      textAlign:
                                                          TextAlign.center,
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
                                            Expanded(
                                              flex: 4,
                                              child: RawMaterialButton(
                                                elevation: 10,
                                                constraints: BoxConstraints(
                                                    minWidth: double.infinity),
                                                onPressed: () {
                                                  t2UrunTipi = "2";

                                                  yazmaSonrasiGecikmeSayaci = 0;
                                                  String komut =
                                                      "1*2*$t2UrunTipi";
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
                                                fillColor: t2UrunTipi == "2"
                                                    ? Colors.green
                                                    : Colors.grey[800],
                                                child: SizedBox(
                                                  child: Container(
                                                    child: AutoSizeText(
                                                      "SOYA",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 30,
                                                          fontFamily:
                                                              'Kelly Slab',
                                                          fontWeight:
                                                              FontWeight.bold),
                                                      maxLines: 1,
                                                      textAlign:
                                                          TextAlign.center,
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
                                  ),
                                ),
                                Expanded(
                                  child: Row(
                                    children: [
                                      Spacer(
                                        flex: 1,
                                      ),
                                      //AYÇİÇEĞİ seçim butonu
                                      Expanded(
                                        flex: 6,
                                        child: Column(
                                          children: [
                                            Spacer(),
                                            Expanded(
                                              flex: 4,
                                              child: RawMaterialButton(
                                                elevation: 10,
                                                constraints: BoxConstraints(
                                                    minWidth: double.infinity),
                                                onPressed: () {
                                                  t2UrunTipi = "3";

                                                  yazmaSonrasiGecikmeSayaci = 0;
                                                  String komut =
                                                      "1*2*$t2UrunTipi";
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
                                                fillColor: t2UrunTipi == "3"
                                                    ? Colors.green
                                                    : Colors.grey[800],
                                                child: SizedBox(
                                                  child: Container(
                                                    child: AutoSizeText(
                                                      "AYÇİÇEĞİ",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 30,
                                                          fontFamily:
                                                              'Kelly Slab',
                                                          fontWeight:
                                                              FontWeight.bold),
                                                      maxLines: 1,
                                                      textAlign:
                                                          TextAlign.center,
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
                                      //KANOLA seçim butonu
                                      Expanded(
                                        flex: 6,
                                        child: Column(
                                          children: [
                                            Spacer(),
                                            Expanded(
                                              flex: 4,
                                              child: RawMaterialButton(
                                                elevation: 10,
                                                constraints: BoxConstraints(
                                                    minWidth: double.infinity),
                                                onPressed: () {
                                                  t2UrunTipi = "4";

                                                  yazmaSonrasiGecikmeSayaci = 0;
                                                  String komut =
                                                      "1*2*$t2UrunTipi";
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
                                                fillColor: t2UrunTipi == "4"
                                                    ? Colors.green
                                                    : Colors.grey[800],
                                                child: SizedBox(
                                                  child: Container(
                                                    child: AutoSizeText(
                                                      "KANOLA",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 30,
                                                          fontFamily:
                                                              'Kelly Slab',
                                                          fontWeight:
                                                              FontWeight.bold),
                                                      maxLines: 1,
                                                      textAlign:
                                                          TextAlign.center,
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
                                  ),
                                )
                              ],
                            )),
                            //Tank 3 Yağ seçimi
                            Expanded(
                                child: Column(
                              children: [
                                Expanded(
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
                                            Expanded(
                                              flex: 4,
                                              child: RawMaterialButton(
                                                elevation: 10,
                                                constraints: BoxConstraints(
                                                    minWidth: double.infinity),
                                                onPressed: () {
                                                  t3UrunTipi = "1";

                                                  yazmaSonrasiGecikmeSayaci = 0;
                                                  String komut =
                                                      "1*3*$t3UrunTipi";
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
                                                fillColor: t3UrunTipi == "1"
                                                    ? Colors.green
                                                    : Colors.grey[800],
                                                child: SizedBox(
                                                  child: Container(
                                                    child: AutoSizeText(
                                                      "PAMUK",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 30,
                                                          fontFamily:
                                                              'Kelly Slab',
                                                          fontWeight:
                                                              FontWeight.bold),
                                                      maxLines: 1,
                                                      textAlign:
                                                          TextAlign.center,
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
                                            Expanded(
                                              flex: 4,
                                              child: RawMaterialButton(
                                                elevation: 10,
                                                constraints: BoxConstraints(
                                                    minWidth: double.infinity),
                                                onPressed: () {
                                                  t3UrunTipi = "2";

                                                  yazmaSonrasiGecikmeSayaci = 0;
                                                  String komut =
                                                      "1*3*$t3UrunTipi";
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
                                                fillColor: t3UrunTipi == "2"
                                                    ? Colors.green
                                                    : Colors.grey[800],
                                                child: SizedBox(
                                                  child: Container(
                                                    child: AutoSizeText(
                                                      "SOYA",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 30,
                                                          fontFamily:
                                                              'Kelly Slab',
                                                          fontWeight:
                                                              FontWeight.bold),
                                                      maxLines: 1,
                                                      textAlign:
                                                          TextAlign.center,
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
                                  ),
                                ),
                                Expanded(
                                  child: Row(
                                    children: [
                                      Spacer(
                                        flex: 1,
                                      ),
                                      //AYÇİÇEĞİ seçim butonu
                                      Expanded(
                                        flex: 6,
                                        child: Column(
                                          children: [
                                            Spacer(),
                                            Expanded(
                                              flex: 4,
                                              child: RawMaterialButton(
                                                elevation: 10,
                                                constraints: BoxConstraints(
                                                    minWidth: double.infinity),
                                                onPressed: () {
                                                  t3UrunTipi = "3";

                                                  yazmaSonrasiGecikmeSayaci = 0;
                                                  String komut =
                                                      "1*3*$t3UrunTipi";
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
                                                fillColor: t3UrunTipi == "3"
                                                    ? Colors.green
                                                    : Colors.grey[800],
                                                child: SizedBox(
                                                  child: Container(
                                                    child: AutoSizeText(
                                                      "AYÇİÇEĞİ",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 30,
                                                          fontFamily:
                                                              'Kelly Slab',
                                                          fontWeight:
                                                              FontWeight.bold),
                                                      maxLines: 1,
                                                      textAlign:
                                                          TextAlign.center,
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
                                      //KANOLA seçim butonu
                                      Expanded(
                                        flex: 6,
                                        child: Column(
                                          children: [
                                            Spacer(),
                                            Expanded(
                                              flex: 4,
                                              child: RawMaterialButton(
                                                elevation: 10,
                                                constraints: BoxConstraints(
                                                    minWidth: double.infinity),
                                                onPressed: () {
                                                  t3UrunTipi = "4";

                                                  yazmaSonrasiGecikmeSayaci = 0;
                                                  String komut =
                                                      "1*3*$t3UrunTipi";
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
                                                fillColor: t3UrunTipi == "4"
                                                    ? Colors.green
                                                    : Colors.grey[800],
                                                child: SizedBox(
                                                  child: Container(
                                                    child: AutoSizeText(
                                                      "KANOLA",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 30,
                                                          fontFamily:
                                                              'Kelly Slab',
                                                          fontWeight:
                                                              FontWeight.bold),
                                                      maxLines: 1,
                                                      textAlign:
                                                          TextAlign.center,
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
                                  ),
                                )
                              ],
                            )),
                            //Tank 4 Yağ seçimi
                            Expanded(
                                child: Column(
                              children: [
                                Expanded(
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
                                            Expanded(
                                              flex: 4,
                                              child: RawMaterialButton(
                                                elevation: 10,
                                                constraints: BoxConstraints(
                                                    minWidth: double.infinity),
                                                onPressed: () {
                                                  t4UrunTipi = "1";

                                                  yazmaSonrasiGecikmeSayaci = 0;
                                                  String komut =
                                                      "1*4*$t4UrunTipi";
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
                                                fillColor: t4UrunTipi == "1"
                                                    ? Colors.green
                                                    : Colors.grey[800],
                                                child: SizedBox(
                                                  child: Container(
                                                    child: AutoSizeText(
                                                      "PAMUK",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 30,
                                                          fontFamily:
                                                              'Kelly Slab',
                                                          fontWeight:
                                                              FontWeight.bold),
                                                      maxLines: 1,
                                                      textAlign:
                                                          TextAlign.center,
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
                                            Expanded(
                                              flex: 4,
                                              child: RawMaterialButton(
                                                elevation: 10,
                                                constraints: BoxConstraints(
                                                    minWidth: double.infinity),
                                                onPressed: () {
                                                  t4UrunTipi = "2";

                                                  yazmaSonrasiGecikmeSayaci = 0;
                                                  String komut =
                                                      "1*4*$t4UrunTipi";
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
                                                fillColor: t4UrunTipi == "2"
                                                    ? Colors.green
                                                    : Colors.grey[800],
                                                child: SizedBox(
                                                  child: Container(
                                                    child: AutoSizeText(
                                                      "SOYA",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 30,
                                                          fontFamily:
                                                              'Kelly Slab',
                                                          fontWeight:
                                                              FontWeight.bold),
                                                      maxLines: 1,
                                                      textAlign:
                                                          TextAlign.center,
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
                                  ),
                                ),
                                Expanded(
                                  child: Row(
                                    children: [
                                      Spacer(
                                        flex: 1,
                                      ),
                                      //AYÇİÇEĞİ seçim butonu
                                      Expanded(
                                        flex: 6,
                                        child: Column(
                                          children: [
                                            Spacer(),
                                            Expanded(
                                              flex: 4,
                                              child: RawMaterialButton(
                                                elevation: 10,
                                                constraints: BoxConstraints(
                                                    minWidth: double.infinity),
                                                onPressed: () {
                                                  t4UrunTipi = "3";

                                                  yazmaSonrasiGecikmeSayaci = 0;
                                                  String komut =
                                                      "1*4*$t4UrunTipi";
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
                                                fillColor: t4UrunTipi == "3"
                                                    ? Colors.green
                                                    : Colors.grey[800],
                                                child: SizedBox(
                                                  child: Container(
                                                    child: AutoSizeText(
                                                      "AYÇİÇEĞİ",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 30,
                                                          fontFamily:
                                                              'Kelly Slab',
                                                          fontWeight:
                                                              FontWeight.bold),
                                                      maxLines: 1,
                                                      textAlign:
                                                          TextAlign.center,
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
                                      //KANOLA seçim butonu
                                      Expanded(
                                        flex: 6,
                                        child: Column(
                                          children: [
                                            Spacer(),
                                            Expanded(
                                              flex: 4,
                                              child: RawMaterialButton(
                                                elevation: 10,
                                                constraints: BoxConstraints(
                                                    minWidth: double.infinity),
                                                onPressed: () {
                                                  t4UrunTipi = "4";

                                                  yazmaSonrasiGecikmeSayaci = 0;
                                                  String komut =
                                                      "1*4*$t4UrunTipi";
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
                                                fillColor: t4UrunTipi == "4"
                                                    ? Colors.green
                                                    : Colors.grey[800],
                                                child: SizedBox(
                                                  child: Container(
                                                    child: AutoSizeText(
                                                      "KANOLA",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 30,
                                                          fontFamily:
                                                              'Kelly Slab',
                                                          fontWeight:
                                                              FontWeight.bold),
                                                      maxLines: 1,
                                                      textAlign:
                                                          TextAlign.center,
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
                                  ),
                                )
                              ],
                            )),
                            //Tank 5 Yağ seçimi
                            Expanded(
                                child: Column(
                              children: [
                                Expanded(
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
                                            Expanded(
                                              flex: 4,
                                              child: RawMaterialButton(
                                                elevation: 10,
                                                constraints: BoxConstraints(
                                                    minWidth: double.infinity),
                                                onPressed: () {
                                                  t5UrunTipi = "1";

                                                  yazmaSonrasiGecikmeSayaci = 0;
                                                  String komut =
                                                      "1*5*$t5UrunTipi";
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
                                                fillColor: t5UrunTipi == "1"
                                                    ? Colors.green
                                                    : Colors.grey[800],
                                                child: SizedBox(
                                                  child: Container(
                                                    child: AutoSizeText(
                                                      "PAMUK",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 30,
                                                          fontFamily:
                                                              'Kelly Slab',
                                                          fontWeight:
                                                              FontWeight.bold),
                                                      maxLines: 1,
                                                      textAlign:
                                                          TextAlign.center,
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
                                            Expanded(
                                              flex: 4,
                                              child: RawMaterialButton(
                                                elevation: 10,
                                                constraints: BoxConstraints(
                                                    minWidth: double.infinity),
                                                onPressed: () {
                                                  t5UrunTipi = "2";

                                                  yazmaSonrasiGecikmeSayaci = 0;
                                                  String komut =
                                                      "1*5*$t5UrunTipi";
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
                                                fillColor: t5UrunTipi == "2"
                                                    ? Colors.green
                                                    : Colors.grey[800],
                                                child: SizedBox(
                                                  child: Container(
                                                    child: AutoSizeText(
                                                      "SOYA",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 30,
                                                          fontFamily:
                                                              'Kelly Slab',
                                                          fontWeight:
                                                              FontWeight.bold),
                                                      maxLines: 1,
                                                      textAlign:
                                                          TextAlign.center,
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
                                  ),
                                ),
                                Expanded(
                                  child: Row(
                                    children: [
                                      Spacer(
                                        flex: 1,
                                      ),
                                      //AYÇİÇEĞİ seçim butonu
                                      Expanded(
                                        flex: 6,
                                        child: Column(
                                          children: [
                                            Spacer(),
                                            Expanded(
                                              flex: 4,
                                              child: RawMaterialButton(
                                                elevation: 10,
                                                constraints: BoxConstraints(
                                                    minWidth: double.infinity),
                                                onPressed: () {
                                                  t5UrunTipi = "3";

                                                  yazmaSonrasiGecikmeSayaci = 0;
                                                  String komut =
                                                      "1*5*$t5UrunTipi";
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
                                                fillColor: t5UrunTipi == "3"
                                                    ? Colors.green
                                                    : Colors.grey[800],
                                                child: SizedBox(
                                                  child: Container(
                                                    child: AutoSizeText(
                                                      "AYÇİÇEĞİ",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 30,
                                                          fontFamily:
                                                              'Kelly Slab',
                                                          fontWeight:
                                                              FontWeight.bold),
                                                      maxLines: 1,
                                                      textAlign:
                                                          TextAlign.center,
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
                                      //KANOLA seçim butonu
                                      Expanded(
                                        flex: 6,
                                        child: Column(
                                          children: [
                                            Spacer(),
                                            Expanded(
                                              flex: 4,
                                              child: RawMaterialButton(
                                                elevation: 10,
                                                constraints: BoxConstraints(
                                                    minWidth: double.infinity),
                                                onPressed: () {
                                                  t5UrunTipi = "4";

                                                  yazmaSonrasiGecikmeSayaci = 0;
                                                  String komut =
                                                      "1*5*$t5UrunTipi";
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
                                                fillColor: t5UrunTipi == "4"
                                                    ? Colors.green
                                                    : Colors.grey[800],
                                                child: SizedBox(
                                                  child: Container(
                                                    child: AutoSizeText(
                                                      "KANOLA",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 30,
                                                          fontFamily:
                                                              'Kelly Slab',
                                                          fontWeight:
                                                              FontWeight.bold),
                                                      maxLines: 1,
                                                      textAlign:
                                                          TextAlign.center,
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
                                  ),
                                )
                              ],
                            )),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Row(
                children: [
                  Spacer(),
                  //SANAL SENSÖR AKTİFLİK
                  Expanded(
                    flex: 8,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        //Başlık
                        Expanded(
                          flex: 2,
                          child: SizedBox(
                            child: Container(
                              alignment: Alignment.bottomCenter,
                              child: AutoSizeText(
                                "Sanal Sensör Aktiflik",
                                style: TextStyle(fontSize: 15 * oran),
                                maxLines: 1,
                              ),
                            ),
                          ),
                        ),
                        //Sanal Sensör 1-2-3-4-5
                        Expanded(
                          flex: 6,
                          child: Column(
                            children: [
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
                                                  if (t1OlcumAktif == "0") {
                                                    Toast.show(
                                                        "Yağ seviyesi sıfır seviyesinin altındayken sanal sensör pasif edilemez!",
                                                        context,
                                                        duration: 3);
                                                  } else {
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
                                                  }
                                                },
                                                child: Icon(
                                                  t1SanalSensorAktiflik == true
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
                                          Spacer(
                                            flex: 1,
                                          )
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
                                                  if (t2OlcumAktif == "0") {
                                                    Toast.show(
                                                        "Yağ seviyesi sıfır seviyesinin altındayken sanal sensör pasif edilemez!",
                                                        context,
                                                        duration: 3);
                                                  } else {
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
                                                  }
                                                },
                                                child: Icon(
                                                  t2SanalSensorAktiflik == true
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
                                          Spacer(
                                            flex: 1,
                                          )
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
                                                  if (t3OlcumAktif == "0") {
                                                    Toast.show(
                                                        "Yağ seviyesi sıfır seviyesinin altındayken sanal sensör pasif edilemez!",
                                                        context,
                                                        duration: 3);
                                                  } else {
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
                                                  }
                                                },
                                                child: Icon(
                                                  t3SanalSensorAktiflik == true
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
                                          Spacer(
                                            flex: 1,
                                          )
                                        ],
                                      ),
                                    ),
                                    Spacer(),
                                    //Tank 4 Sanal Sensör Aktif
                                    Expanded(
                                      flex: 2,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
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
                                                  if (t4OlcumAktif == "0") {
                                                    Toast.show(
                                                        "Yağ seviyesi sıfır seviyesinin altındayken sanal sensör pasif edilemez!",
                                                        context,
                                                        duration: 3);
                                                  } else {
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
                                                  }
                                                },
                                                child: Icon(
                                                  t4SanalSensorAktiflik == true
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
                                          Spacer(
                                            flex: 1,
                                          )
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
                                                  if (t5OlcumAktif == "0") {
                                                    Toast.show(
                                                        "Yağ seviyesi sıfır seviyesinin altındayken sanal sensör pasif edilemez!",
                                                        context,
                                                        duration: 3);
                                                  } else {
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
                                                  }
                                                },
                                                child: Icon(
                                                  t5SanalSensorAktiflik == true
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
                                          Spacer(
                                            flex: 1,
                                          )
                                        ],
                                      ),
                                    ),
                                    Spacer(
                                      flex: 1,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  //SIFIR SEVİYESİNİN ALTINDA YAĞ VAR MI?
                  Expanded(
                    flex: 8,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        //Başlık
                        Expanded(
                          flex: 2,
                          child: SizedBox(
                            child: Container(
                              alignment: Alignment.bottomCenter,
                              child: AutoSizeText(
                                "Sıfır Seviyesinin Altında Yağ Var Mı?",
                                style: TextStyle(fontSize: 30 * oran),
                                maxLines: 1,
                                minFontSize: 2,
                              ),
                            ),
                          ),
                        ),
                        //Sanal Sensör 1-2-3-4-5
                        Expanded(
                          flex: 6,
                          child: Column(
                            children: [
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
                                                  if (t1OlcumAktif == "1") {
                                                    Toast.show(
                                                        "Yağ seviyesi sıfır seviyesinin üstünde ise bu parametre pasif edilemez!",
                                                        context,
                                                        duration: 3);
                                                  } else {
                                                    _index = 1;
                                                    if (t1SifirinAltindaYagVarMi) {
                                                      t1SifirinAltindaYagVarMi =
                                                          false;
                                                    } else {
                                                      t1SifirinAltindaYagVarMi =
                                                          true;
                                                    }
                                                    String veri =
                                                        t1SifirinAltindaYagVarMi ==
                                                                true
                                                            ? '1'
                                                            : '0';

                                                    yazmaSonrasiGecikmeSayaci =
                                                        0;
                                                    String komut = "5*1*$veri";
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
                                                  }
                                                },
                                                child: Icon(
                                                  t1SifirinAltindaYagVarMi ==
                                                          true
                                                      ? Icons.check_box
                                                      : Icons
                                                          .check_box_outline_blank,
                                                  color:
                                                      t1SifirinAltindaYagVarMi ==
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
                                          Spacer(
                                            flex: 1,
                                          )
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
                                                  if (t2OlcumAktif == "1") {
                                                    Toast.show(
                                                        "Yağ seviyesi sıfır seviyesinin üstünde ise bu parametre pasif edilemez!",
                                                        context,
                                                        duration: 3);
                                                  } else {
                                                    _index = 2;
                                                    if (t2SifirinAltindaYagVarMi) {
                                                      t2SifirinAltindaYagVarMi =
                                                          false;
                                                    } else {
                                                      t2SifirinAltindaYagVarMi =
                                                          true;
                                                    }
                                                    String veri =
                                                        t2SifirinAltindaYagVarMi ==
                                                                true
                                                            ? '1'
                                                            : '0';

                                                    yazmaSonrasiGecikmeSayaci =
                                                        0;
                                                    String komut = "5*2*$veri";
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
                                                  }
                                                },
                                                child: Icon(
                                                  t2SifirinAltindaYagVarMi ==
                                                          true
                                                      ? Icons.check_box
                                                      : Icons
                                                          .check_box_outline_blank,
                                                  color:
                                                      t2SifirinAltindaYagVarMi ==
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
                                          Spacer(
                                            flex: 1,
                                          )
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
                                                  if (t3OlcumAktif == "1") {
                                                    Toast.show(
                                                        "Yağ seviyesi sıfır seviyesinin üstünde ise bu parametre pasif edilemez!",
                                                        context,
                                                        duration: 3);
                                                  } else {
                                                    _index = 3;
                                                    if (t3SifirinAltindaYagVarMi) {
                                                      t3SifirinAltindaYagVarMi =
                                                          false;
                                                    } else {
                                                      t3SifirinAltindaYagVarMi =
                                                          true;
                                                    }
                                                    String veri =
                                                        t3SifirinAltindaYagVarMi ==
                                                                true
                                                            ? '1'
                                                            : '0';

                                                    yazmaSonrasiGecikmeSayaci =
                                                        0;
                                                    String komut = "5*3*$veri";
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
                                                  }
                                                },
                                                child: Icon(
                                                  t3SifirinAltindaYagVarMi ==
                                                          true
                                                      ? Icons.check_box
                                                      : Icons
                                                          .check_box_outline_blank,
                                                  color:
                                                      t3SifirinAltindaYagVarMi ==
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
                                          Spacer(
                                            flex: 1,
                                          )
                                        ],
                                      ),
                                    ),
                                    Spacer(),
                                    //Tank 4 Sanal Sensör Aktif
                                    Expanded(
                                      flex: 2,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
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
                                                  if (t4OlcumAktif == "1") {
                                                    Toast.show(
                                                        "Yağ seviyesi sıfır seviyesinin üstünde ise bu parametre pasif edilemez!",
                                                        context,
                                                        duration: 3);
                                                  } else {
                                                    _index = 4;
                                                    if (t4SifirinAltindaYagVarMi) {
                                                      t4SifirinAltindaYagVarMi =
                                                          false;
                                                    } else {
                                                      t4SifirinAltindaYagVarMi =
                                                          true;
                                                    }
                                                    String veri =
                                                        t4SifirinAltindaYagVarMi ==
                                                                true
                                                            ? '1'
                                                            : '0';

                                                    yazmaSonrasiGecikmeSayaci =
                                                        0;
                                                    String komut = "5*4*$veri";
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
                                                  }
                                                },
                                                child: Icon(
                                                  t4SifirinAltindaYagVarMi ==
                                                          true
                                                      ? Icons.check_box
                                                      : Icons
                                                          .check_box_outline_blank,
                                                  color:
                                                      t4SifirinAltindaYagVarMi ==
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
                                          Spacer(
                                            flex: 1,
                                          )
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
                                                  if (t5OlcumAktif == "1") {
                                                    Toast.show(
                                                        "Yağ seviyesi sıfır seviyesinin üstünde ise bu parametre pasif edilemez!",
                                                        context,
                                                        duration: 3);
                                                  } else {
                                                    _index = 5;
                                                    if (t5SifirinAltindaYagVarMi) {
                                                      t5SifirinAltindaYagVarMi =
                                                          false;
                                                    } else {
                                                      t5SifirinAltindaYagVarMi =
                                                          true;
                                                    }
                                                    String veri =
                                                        t5SifirinAltindaYagVarMi ==
                                                                true
                                                            ? '1'
                                                            : '0';

                                                    yazmaSonrasiGecikmeSayaci =
                                                        0;
                                                    String komut = "5*5*$veri";
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
                                                  }
                                                },
                                                child: Icon(
                                                  t5SifirinAltindaYagVarMi ==
                                                          true
                                                      ? Icons.check_box
                                                      : Icons
                                                          .check_box_outline_blank,
                                                  color:
                                                      t5SifirinAltindaYagVarMi ==
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
                                          Spacer(
                                            flex: 1,
                                          )
                                        ],
                                      ),
                                    ),
                                    Spacer(
                                      flex: 1,
                                    ),
                                  ],
                                ),
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
                  //LOG VERİLERİ BUTON
                  Expanded(
                    flex: 3,
                    child: RawMaterialButton(
                      elevation: 16,
                      onPressed: () {
                        timerCancel = true;

                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => Datalog()),
                        );
                      },
                      fillColor: Colors.blue,
                      child: SizedBox(
                        child: Container(
                          child: AutoSizeText(
                            "LOG VERİLERİ",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 30,
                                fontWeight: FontWeight.bold),
                            maxLines: 2,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Spacer(
                    flex: 1,
                  ),
                  //Tolerans
                  Expanded(
                    flex: 3,
                    child: Column(
                      children: [
                        //Başlık
                        Expanded(
                          flex: 2,
                          child: SizedBox(
                            child: Container(
                              alignment: Alignment.bottomCenter,
                              child: AutoSizeText(
                                "Ölçüm Toleransı\n(mm)",
                                style: TextStyle(fontSize: 15 * oran),
                                maxLines: 2,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),

                        Expanded(
                          flex: 2,
                          child: Container(
                            alignment: Alignment.bottomCenter,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle, color: Colors.white),
                            child: RawMaterialButton(
                              elevation: 16,
                              onPressed: () {
                                int sayi = int.parse(tolerans);
                                _yuzler = sayi < 100 ? 0 : sayi ~/ 100;
                                _onlar = sayi < 10
                                    ? 0
                                    : (sayi > 99
                                        ? (sayi - 100 * _yuzler) ~/ 10
                                        : sayi ~/ 10);
                                _birler = sayi % 10;
                                _degergiris3X0(_yuzler, _onlar, _birler, 1,
                                        "Ölçüm Toleransı (mm)", "")
                                    .then((onValue) {});
                              },
                              child: SizedBox(
                                child: Container(
                                  child: AutoSizeText(
                                    tolerans,
                                    style: TextStyle(
                                        fontSize: 15 * oran,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                    maxLines: 1,
                                    minFontSize: 2,
                                  ),
                                ),
                              ),
                              fillColor: Colors.blue,
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

                  //Bağlantı durumu
                  Expanded(
                    flex: 3,
                    child: Column(
                      children: [
                        //Başlık
                        Expanded(
                          flex: 1,
                          child: SizedBox(
                            child: Container(
                              alignment: Alignment.bottomCenter,
                              child: AutoSizeText(
                                "Bağlantı Durumu",
                                style: TextStyle(fontSize: 15 * oran),
                                maxLines: 1,
                              ),
                            ),
                          ),
                        ),

                        Expanded(
                          flex: 2,
                          child: Container(
                              alignment: Alignment.bottomCenter,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle, color: Colors.white),
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

                        Expanded(
                          child: Container(
                            child: Center(
                              child: FutureBuilder(
                                  future: DefaultAssetBundle.of(context)
                                      .loadString("assets/data.json"),
                                  builder: (context, snapshot) {
                                    var mydata =
                                        jsonDecode(snapshot.data.toString());
                                    print(mydata["example_data"][0]["ip"]);
                                    ipNo = (mydata["example_data"][0]["ip"])
                                        .toString();
                                    return Text(ipNo);
                                  }),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Spacer(
                    flex: 1,
                  ),
                ],
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

    seviyeT1 = double.parse(degerler[0]);
    seviyeT2 = double.parse(degerler[1]);
    seviyeT3 = double.parse(degerler[2]);
    seviyeT4 = double.parse(degerler[3]);
    seviyeT5 = double.parse(degerler[4]);

    agirlikT1 = degerler[5];
    agirlikT2 = degerler[6];
    agirlikT3 = degerler[7];
    agirlikT4 = degerler[8];
    agirlikT5 = degerler[9];

    t1SanalSensorAktiflik = degerler[10] == "1" ? true : false;
    t2SanalSensorAktiflik = degerler[11] == "1" ? true : false;
    t3SanalSensorAktiflik = degerler[12] == "1" ? true : false;
    t4SanalSensorAktiflik = degerler[13] == "1" ? true : false;
    t5SanalSensorAktiflik = degerler[14] == "1" ? true : false;

    t1SifirinAltindaYagVarMi = degerler[15] == "1" ? true : false;
    t2SifirinAltindaYagVarMi = degerler[16] == "1" ? true : false;
    t3SifirinAltindaYagVarMi = degerler[17] == "1" ? true : false;
    t4SifirinAltindaYagVarMi = degerler[18] == "1" ? true : false;
    t5SifirinAltindaYagVarMi = degerler[19] == "1" ? true : false;

    manSeviyeT1 = degerler[20];
    manSeviyeT2 = degerler[21];
    manSeviyeT3 = degerler[22];
    manSeviyeT4 = degerler[23];
    manSeviyeT5 = degerler[24];

    t1sens1 = degerler[25];
    t1sens2 = degerler[26];
    t1sens3 = degerler[27];

    t2sens1 = degerler[28];
    t2sens2 = degerler[29];
    t2sens3 = degerler[30];

    t3sens1 = degerler[31];
    t3sens2 = degerler[32];
    t3sens3 = degerler[33];

    t4sens1 = degerler[34];
    t4sens2 = degerler[35];
    t4sens3 = degerler[36];

    t5sens1 = degerler[37];
    t5sens2 = degerler[38];
    t5sens3 = degerler[39];

    ortalamaT1 = degerler[40];
    ortalamaT2 = degerler[41];
    ortalamaT3 = degerler[42];
    ortalamaT4 = degerler[43];
    ortalamaT5 = degerler[44];

    t1UrunTipi = degerler[45];
    t2UrunTipi = degerler[46];
    t3UrunTipi = degerler[47];
    t4UrunTipi = degerler[48];
    t5UrunTipi = degerler[49];

    t1SanSens = degerler[50];
    t2SanSens = degerler[51];
    t3SanSens = degerler[52];
    t4SanSens = degerler[53];
    t5SanSens = degerler[54];

    sensSev1 = degerler[55];
    sensSev2 = degerler[56];
    sensSev3 = degerler[57];

    t1OlcumAktif = degerler[58];
    t2OlcumAktif = degerler[59];
    t3OlcumAktif = degerler[60];
    t4OlcumAktif = degerler[61];
    t5OlcumAktif = degerler[62];

    tolerans = degerler[63];

    if (t1OlcumAktif == "1") {
      t1ortalamadakiSensor[1] = true;
    } else {
      t1ortalamadakiSensor[1] = false;
    }

    if (seviyeT1 >= double.parse(sensSev2)) {
      t1ortalamadakiSensor[2] = true;
    } else {
      t1ortalamadakiSensor[2] = false;
    }

    if (seviyeT1 >= double.parse(sensSev3)) {
      t1ortalamadakiSensor[3] = true;
    } else {
      t1ortalamadakiSensor[3] = false;
    }

    if (t2OlcumAktif == "1") {
      t2ortalamadakiSensor[1] = true;
    } else {
      t2ortalamadakiSensor[1] = false;
    }

    if (seviyeT2 >= double.parse(sensSev2)) {
      t2ortalamadakiSensor[2] = true;
    } else {
      t2ortalamadakiSensor[2] = false;
    }

    if (seviyeT2 >= double.parse(sensSev3)) {
      t2ortalamadakiSensor[3] = true;
    } else {
      t2ortalamadakiSensor[3] = false;
    }

    if (t3OlcumAktif == "1") {
      t3ortalamadakiSensor[1] = true;
    } else {
      t3ortalamadakiSensor[1] = false;
    }

    if (seviyeT3 >= double.parse(sensSev2)) {
      t3ortalamadakiSensor[2] = true;
    } else {
      t3ortalamadakiSensor[2] = false;
    }

    if (seviyeT3 >= double.parse(sensSev3)) {
      t3ortalamadakiSensor[3] = true;
    } else {
      t3ortalamadakiSensor[3] = false;
    }

    if (t4OlcumAktif == "1") {
      t4ortalamadakiSensor[1] = true;
    } else {
      t4ortalamadakiSensor[1] = false;
    }

    if (seviyeT4 >= double.parse(sensSev2)) {
      t4ortalamadakiSensor[2] = true;
    } else {
      t4ortalamadakiSensor[2] = false;
    }

    if (seviyeT4 >= double.parse(sensSev3)) {
      t4ortalamadakiSensor[3] = true;
    } else {
      t4ortalamadakiSensor[3] = false;
    }

    if (t5OlcumAktif == "1") {
      t5ortalamadakiSensor[1] = true;
    } else {
      t5ortalamadakiSensor[1] = false;
    }

    if (seviyeT5 >= double.parse(sensSev2)) {
      t5ortalamadakiSensor[2] = true;
    } else {
      t5ortalamadakiSensor[2] = false;
    }

    if (seviyeT5 >= double.parse(sensSev3)) {
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

  Future _degergiris3X0(
      int yuzler, onlar, birler, index, baslik, onBaslik) async {
    // flutter defined function

    await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog

        return DegerGiris3X0.Deger(
            yuzler, onlar, birler, index, baslik, onBaslik);
      },
    ).then((val) {
      bool veriGonderilsinMi = false;
      if (_yuzler != val[0] ||
          _onlar != val[1] ||
          _birler != val[2] ||
          index != val[3]) {
        veriGonderilsinMi = true;
      }
      _yuzler = val[0];
      _onlar = val[1];
      _birler = val[2];
      index = val[3];

      tolerans = (_yuzler * 100 + _onlar * 10 + _birler).toString();

      if (veriGonderilsinMi) {
        yazmaSonrasiGecikmeSayaci = 0;
        String komut = "6*$tolerans";
        veriGonder(komut, 3000).then((value) {
          if (value.split("*")[0] == "error") {
            Toast.show(
                "Yazdırma hatası! Yazdırma portu kapalı.Ağ hatası yoksa Server PC\'yi yeniden başlatınız.",
                context,
                duration: 3);
          } else {
            Toast.show("Başarılı", context, duration: 3);

            baglanti = false;
          }
        });
      }

      setState(() {});
    });
  }

  Future<String> veriGonder(String komut, int portNo) async {
    String _donusDegeri;

    print("Request has data");

    // =============================================================
    Socket _socket;
    await Socket.connect(ipNo, portNo, timeout: Duration(seconds: 5))
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
    await Socket.connect(ipNo, portNo, timeout: Duration(seconds: 5))
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
}
