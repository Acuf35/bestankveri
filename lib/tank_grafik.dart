import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:bestank/tank_grafik_veriler.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:toast/toast.dart';

import 'deger_giris_3x1.dart';
import 'deger_giris_3x0.dart';

class TankGrafik extends StatefulWidget {
  final List<TankGrafikVeriler> data;
  String tankBaslik;
  String tankMiktar;
  String tankSen1;
  String tankSen2;
  String tankSen3;
  String tankSanSen;
  bool tankSanSenVisibility = false;
  bool tankManSevVisibility = false;
  bool tankYagVarmi = false;
  int tankIndex;
  String tankOrtalama;
  double tankSensSev1 = 0.0;
  double tankSensSev2 = 0.0;
  double tankSensSev3 = 0.0;
  bool tankSens1OrtDurum = false;
  bool tankSens2OrtDurum = false;
  bool tankSens3OrtDurum = false;
  double oran;
  String tankManSeviye = "0";
  TankGrafik(
      String baslik,
      String miktar,
      String sen1,
      String sen2,
      String sen3,
      String sanSen,
      bool sanSenVisibility,
      bool manSevVisibility,
      bool yagVarmi,
      int index,
      String ortalama,
      double sensSev1,
      double sensSev2,
      double sensSev3,
      bool sens1OrtDurum,
      bool sens2OrtDurum,
      bool sens3OrtDurum,
      double xOran,
      String manSeviye,
      {this.data}) {
    tankBaslik = baslik;
    tankMiktar = miktar;
    tankSen1 = sen1;
    tankSen2 = sen2;
    tankSen3 = sen3;
    tankSanSen = sanSen;
    tankSanSenVisibility = sanSenVisibility;
    tankManSevVisibility = manSevVisibility;
    tankYagVarmi = yagVarmi;
    tankIndex = index;
    tankOrtalama = ortalama;
    tankSensSev1 = sensSev1;
    tankSensSev2 = sensSev2;
    tankSensSev3 = sensSev3;
    tankSens1OrtDurum = sens1OrtDurum;
    tankSens2OrtDurum = sens2OrtDurum;
    tankSens3OrtDurum = sens3OrtDurum;
    oran = xOran;
    tankManSeviye = manSeviye;
  }

  @override
  _TankGrafikState createState() => _TankGrafikState();
}

class _TankGrafikState extends State<TankGrafik> {
  double oran = 0.0;

  int _yuzler = 0;

  int _onlar = 0;

  int _birler = 0;

  int _ondalik = 0;

  bool timerCancel = false;

  int timerSayac = 0;

  bool baglanti = false;

  int yazmaSonrasiGecikmeSayaci = 4;

  @override
  Widget build(BuildContext context) {
    oran = widget.oran;

    List<charts.Series<TankGrafikVeriler, String>> series = [
      charts.Series(
          id: "Subscribers",
          data: widget.data,
          domainFn: (TankGrafikVeriler series, _) => series.seviyeMetin,
          measureFn: (TankGrafikVeriler series, _) => series.seviye,
          colorFn: (TankGrafikVeriler series, _) => series.barColor)
    ];

    return SizedBox(
      height: 300 * oran,
      child: Container(
        padding: EdgeInsets.all(5 * oran),
        child: Card(
          child: Column(
            children: [
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  child: SizedBox(
                    child: AutoSizeText(
                      widget.tankBaslik,
                      style: TextStyle(
                          fontSize: 15 * oran,
                          fontWeight: FontWeight.bold,
                          color: Colors.green[700]),
                      maxLines: 1,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 10,
                child: Padding(
                  padding: EdgeInsets.only(left: 4 * oran),
                  child: Row(
                    children: [
                      //Grafik Bölümü
                      Expanded(
                        flex: 2,
                        child: Column(
                          children: [
                            Expanded(
                                flex: 8,
                                child: Container(
                                  color: Colors.grey[100],
                                  padding: EdgeInsets.only(bottom: 5 * oran),
                                  child: charts.BarChart(
                                    series,
                                    animate: true,
                                    domainAxis: new charts.OrdinalAxisSpec(
                                        renderSpec: new charts
                                                .SmallTickRendererSpec(

                                            // Tick and Label styling here.
                                            labelStyle: new charts
                                                    .TextStyleSpec(
                                                fontSize: (12 * oran)
                                                    .toInt(), // size in Pts.
                                                color: charts
                                                    .MaterialPalette.black),

                                            // Change the line colors to match text color.
                                            lineStyle: new charts.LineStyleSpec(
                                                color: charts
                                                    .MaterialPalette.black))),
                                    primaryMeasureAxis:
                                        new charts.NumericAxisSpec(
                                      showAxisLine: true,
                                      tickProviderSpec: new charts
                                          .StaticNumericTickProviderSpec(
                                        <charts.TickSpec<num>>[
                                          //charts.TickSpec<num>(-0.26),
                                          charts.TickSpec<num>(
                                              widget.tankSensSev1),
                                          charts.TickSpec<num>(
                                              widget.tankSensSev2),
                                          charts.TickSpec<num>(
                                              widget.tankSensSev3),
                                          //charts.TickSpec<num>(75),
                                          charts.TickSpec<num>(
                                              widget.tankIndex == 5
                                                  ? 11.70
                                                  : 11.74),
                                        ],
                                      ),
                                      renderSpec:
                                          new charts.GridlineRendererSpec(
                                        //labelRotation: 50,
                                        labelOffsetFromAxisPx:
                                            (1 * oran).round(),

                                        // Tick and Label styling here.
                                        labelStyle: new charts.TextStyleSpec(
                                            fontSize: (9 * oran)
                                                .round(), // size in Pts.
                                            color:
                                                charts.MaterialPalette.black),

                                        // Change the line colors to match text color.
                                        lineStyle: new charts.LineStyleSpec(
                                            color: charts
                                                .MaterialPalette.gray.shade400),

                                        axisLineStyle: new charts.LineStyleSpec(
                                            color:
                                                charts.MaterialPalette.black),
                                      ),
                                    ),
                                  ),
                                )),
                            Expanded(
                              child: SizedBox(
                                child: Container(
                                  alignment: Alignment.center,
                                  child: AutoSizeText(
                                    widget.tankMiktar,
                                    style: TextStyle(
                                        fontSize: 11 * oran,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blue[800]),
                                    maxLines: 1,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      //Sensör Değerleri Bölümü
                      Expanded(
                        flex: 1,
                        child: Column(
                          children: [
                            Spacer(
                              flex: 1,
                            ),
                            Expanded(
                                flex: 27,
                                child: Container(
                                  //color: Colors.green,
                                  child: Column(
                                    children: [
                                      //PT100 sensör 3
                                      Expanded(
                                        child: Column(
                                          children: [
                                            Expanded(
                                              flex: 2,
                                              child: SizedBox(
                                                child: Container(
                                                  alignment:
                                                      Alignment.bottomCenter,
                                                  child: AutoSizeText(
                                                    "Sıc.Sens3",
                                                    style: TextStyle(
                                                      fontSize: 30,
                                                      color: widget
                                                              .tankSens3OrtDurum
                                                          ? Colors.orange[700]
                                                          : Colors.black,
                                                      fontWeight: widget
                                                              .tankSens3OrtDurum
                                                          ? FontWeight.bold
                                                          : FontWeight.normal,
                                                    ),
                                                    textAlign: TextAlign.center,
                                                    minFontSize: 2,
                                                    maxLines: 1,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 2,
                                              child: SizedBox(
                                                child: Container(
                                                  alignment:
                                                      Alignment.bottomCenter,
                                                  child: AutoSizeText(
                                                    "${widget.tankSen3} °C",
                                                    style: TextStyle(
                                                        fontSize: 30,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                    textAlign: TextAlign.center,
                                                    minFontSize: 2,
                                                    maxLines: 1,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Spacer()
                                          ],
                                        ),
                                      ),
                                      //PT100 sensör 2
                                      Expanded(
                                        child: Column(
                                          children: [
                                            Expanded(
                                              flex: 2,
                                              child: SizedBox(
                                                child: Container(
                                                  alignment:
                                                      Alignment.bottomCenter,
                                                  child: AutoSizeText(
                                                    "Sıc.Sens2",
                                                    style: TextStyle(
                                                      fontSize: 30,
                                                      color: widget
                                                              .tankSens2OrtDurum
                                                          ? Colors.orange[700]
                                                          : Colors.black,
                                                      fontWeight: widget
                                                              .tankSens2OrtDurum
                                                          ? FontWeight.bold
                                                          : FontWeight.normal,
                                                    ),
                                                    textAlign: TextAlign.center,
                                                    minFontSize: 2,
                                                    maxLines: 1,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 2,
                                              child: SizedBox(
                                                child: Container(
                                                  alignment:
                                                      Alignment.bottomCenter,
                                                  child: AutoSizeText(
                                                    "${widget.tankSen2} °C",
                                                    style: TextStyle(
                                                        fontSize: 30,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                    textAlign: TextAlign.center,
                                                    minFontSize: 2,
                                                    maxLines: 1,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Spacer()
                                          ],
                                        ),
                                      ),
                                      //PT100 sensör 1
                                      Expanded(
                                        child: Column(
                                          children: [
                                            Expanded(
                                              flex: 2,
                                              child: SizedBox(
                                                child: Container(
                                                  alignment:
                                                      Alignment.bottomCenter,
                                                  child: AutoSizeText(
                                                    "Sıc.Sens1",
                                                    style: TextStyle(
                                                      fontSize: 30,
                                                      color: widget
                                                              .tankSens1OrtDurum
                                                          ? Colors.orange[700]
                                                          : Colors.black,
                                                      fontWeight: widget
                                                              .tankSens1OrtDurum
                                                          ? FontWeight.bold
                                                          : FontWeight.normal,
                                                    ),
                                                    textAlign: TextAlign.center,
                                                    minFontSize: 2,
                                                    maxLines: 1,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 2,
                                              child: SizedBox(
                                                child: Container(
                                                  alignment:
                                                      Alignment.bottomCenter,
                                                  child: AutoSizeText(
                                                    "${widget.tankSen1} °C",
                                                    style: TextStyle(
                                                        fontSize: 30,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                    textAlign: TextAlign.center,
                                                    minFontSize: 2,
                                                    maxLines: 1,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Spacer()
                                          ],
                                        ),
                                      ),
                                      //Sanal PT100
                                      Expanded(
                                        child: Visibility(
                                          visible: widget.tankSanSenVisibility,
                                          child: Column(
                                            children: [
                                              Expanded(
                                                flex: 2,
                                                child: SizedBox(
                                                  child: Container(
                                                    alignment:
                                                        Alignment.bottomCenter,
                                                    child: AutoSizeText(
                                                      "San.Sens",
                                                      style: TextStyle(
                                                          fontSize: 30),
                                                      textAlign:
                                                          TextAlign.center,
                                                      maxLines: 1,
                                                      minFontSize: 2,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 2,
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 5, right: 5),
                                                  child: RawMaterialButton(
                                                    onPressed: () {
                                                      String xx =
                                                          widget.tankSanSen;
                                                      var yy = xx.split(".");
                                                      _yuzler =
                                                          int.parse(yy[0]) ~/
                                                              100;
                                                      _onlar =
                                                          (int.parse(yy[0]) -
                                                                  _yuzler *
                                                                      100) ~/
                                                              10;
                                                      _birler =
                                                          int.parse(yy[0]) % 10;
                                                      _ondalik =
                                                          int.parse(yy[1]);
                                                      _degergiris3X1(
                                                              _yuzler,
                                                              _onlar,
                                                              _birler,
                                                              _ondalik,
                                                              widget.tankIndex,
                                                              "Sanal Sensor",
                                                              "Tank ${widget.tankIndex} ")
                                                          .then((onValue) {});
                                                    },
                                                    fillColor: Colors.orange,
                                                    child: SizedBox(
                                                      child: Container(
                                                        child: AutoSizeText(
                                                          "${widget.tankSanSen} °C",
                                                          style: TextStyle(
                                                              fontSize: 30,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                          textAlign:
                                                              TextAlign.center,
                                                          maxLines: 1,
                                                          minFontSize: 2,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Spacer()
                                            ],
                                          ),
                                        ),
                                      ),
                                      //Man Mesafe
                                      Expanded(
                                        child: Visibility(
                                          visible: widget.tankManSevVisibility && widget.tankYagVarmi,
                                          child: Column(
                                            children: [
                                              Expanded(
                                                flex: 2,
                                                child: SizedBox(
                                                  child: Container(
                                                    alignment:
                                                        Alignment.bottomCenter,
                                                    child: AutoSizeText(
                                                      "M.Seviye ",
                                                      style: TextStyle(
                                                          fontSize: 30),
                                                      textAlign:
                                                          TextAlign.center,
                                                      maxLines: 1,
                                                      minFontSize: 2,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 2,
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 5, right: 5),
                                                  child: RawMaterialButton(
                                                    onPressed: () {
                                                      String xx =
                                                          widget.tankManSeviye;
                                                      int sayi = int.parse(xx);
                                                      _yuzler = sayi < 100
                                                          ? 0
                                                          : sayi ~/ 100;
                                                      _onlar = sayi < 10
                                                          ? 0
                                                          : (sayi > 99
                                                              ? (sayi -
                                                                      100 *
                                                                          _yuzler) ~/
                                                                  10
                                                              : sayi ~/ 10);
                                                      _birler = sayi % 10;
                                                      _degergiris3X0(
                                                              _yuzler,
                                                              _onlar,
                                                              _birler,
                                                              widget.tankIndex,
                                                              "Manuel Seviye",
                                                              "Tank ${widget.tankIndex} ")
                                                          .then((onValue) {});
                                                    },
                                                    fillColor: Colors.lime,
                                                    child: SizedBox(
                                                      child: Container(
                                                        child: AutoSizeText(
                                                          "${widget.tankManSeviye} mm",
                                                          style: TextStyle(
                                                              fontSize: 30,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                          textAlign:
                                                              TextAlign.center,
                                                          maxLines: 1,
                                                          minFontSize: 2,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Spacer()
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )),
                            //Geçerli Ortalama
                            Expanded(
                              flex: 6,
                              child: Column(
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: SizedBox(
                                      child: Container(
                                        alignment: Alignment.bottomCenter,
                                        child: AutoSizeText(
                                          "Ortalama",
                                          style: TextStyle(fontSize: 30),
                                          textAlign: TextAlign.center,
                                          maxLines: 1,
                                          minFontSize: 2,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: SizedBox(
                                      child: Container(
                                        alignment: Alignment.bottomCenter,
                                        child: AutoSizeText(
                                          "${widget.tankOrtalama} °C",
                                          style: TextStyle(
                                              fontSize: 30,
                                              fontWeight: FontWeight.bold),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Spacer(
                              flex: 1,
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future _degergiris3X1(
      int yuzler, onlar, birler, ondalik, index, baslik, onBaslik) async {
    // flutter defined function

    await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog

        return DegerGiris3X1.Deger(
            yuzler, onlar, birler, ondalik, index, baslik, onBaslik);
      },
    ).then((val) {
      bool veriGonderilsinMi = false;
      if (_yuzler != val[0] ||
          _onlar != val[1] ||
          _birler != val[2] ||
          _ondalik != val[3] ||
          index != val[4]) {
        veriGonderilsinMi = true;
      }
      _yuzler = val[0];
      _onlar = val[1];
      _birler = val[2];
      _ondalik = val[3];
      index = val[4];

      String veri = "";

      double data = double.parse((_yuzler == 0 ? "" : _yuzler.toString()) +
          (_onlar == 0 ? "" : _onlar.toString()) +
          _birler.toString() +
          "." +
          _ondalik.toString());
      veri = data.toString();

      if (veriGonderilsinMi) {
        yazmaSonrasiGecikmeSayaci = 0;
        String komut = "3*$index*$veri";
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

      String veri = "";

      veri = (_yuzler * 100 + _onlar * 10 + _birler).toString();

      if (veriGonderilsinMi) {
        yazmaSonrasiGecikmeSayaci = 0;
        String komut = "4*$index*$veri";
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
    await Socket.connect("192.168.1.120", portNo, timeout: Duration(seconds: 5))
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
}
