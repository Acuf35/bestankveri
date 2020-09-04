import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:bestank/tank_grafik_veriler.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:toast/toast.dart';

import 'deger_giris_2x1.dart';

class TankGrafik extends StatefulWidget {
  final List<TankGrafikVeriler> data;
  String tankBaslik;
  String tankMiktar;
  String tankSen1;
  String tankSen2;
  String tankSen3;
  String tankSanSen;
  bool tankSanSenVisibility = false;
  int tankIndex;
  String tankOrtalama;
  double tankSensSev1 = 0.0;
  double tankSensSev2 = 0.0;
  double tankSensSev3 = 0.0;
  bool tankSens1OrtDurum = false;
  bool tankSens2OrtDurum = false;
  bool tankSens3OrtDurum = false;
  double oran;
  TankGrafik(
      String baslik,
      String miktar,
      String sen1,
      String sen2,
      String sen3,
      String sanSen,
      bool sanSenVisibility,
      int index,
      String ortalama,
      double sensSev1,
      double sensSev2,
      double sensSev3,
      bool sens1OrtDurum,
      bool sens2OrtDurum,
      bool sens3OrtDurum,
      double xOran,
      {this.data}) {
    tankBaslik = baslik;
    tankMiktar = miktar;
    tankSen1 = sen1;
    tankSen2 = sen2;
    tankSen3 = sen3;
    tankSanSen = sanSen;
    tankSanSenVisibility = sanSenVisibility;
    tankIndex = index;
    tankOrtalama = ortalama;
    tankSensSev1 = sensSev1;
    tankSensSev2 = sensSev2;
    tankSensSev3 = sensSev3;
    tankSens1OrtDurum = sens1OrtDurum;
    tankSens2OrtDurum = sens2OrtDurum;
    tankSens3OrtDurum = sens3OrtDurum;
    oran = xOran;
  }

  @override
  _TankGrafikState createState() => _TankGrafikState();
}

class _TankGrafikState extends State<TankGrafik> {
  double oran = 0.0;
  int _onlar = 0;

  int _birler = 0;

  int _ondalik = 0;

  bool timerCancel = false;

  int timerSayac = 0;

  bool baglanti = false;

  int yazmaSonrasiGecikmeSayaci = 4;

  @override
  Widget build(BuildContext context) {
    oran= widget.oran;
    String xx = widget.tankSanSen;
    var yy = xx.split(".");
    _onlar = int.parse(yy[0]) ~/ 10;
    _birler = int.parse(yy[0]) % 10;
    _ondalik = int.parse(yy[1]);

    List<charts.Series<TankGrafikVeriler, String>> series = [
      charts.Series(
          id: "Subscribers",
          data: widget.data,
          domainFn: (TankGrafikVeriler series, _) => series.dolulukYuzdeMetin,
          measureFn: (TankGrafikVeriler series, _) => series.dolulukYuzde,
          colorFn: (TankGrafikVeriler series, _) => series.barColor)
    ];

    return SizedBox(
      height: 300*oran,
      child: Container(
        padding: EdgeInsets.all(5*oran),
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
                          fontSize: 15*oran,
                          fontWeight: FontWeight.bold,
                          color: Colors.green[700]),
                      maxLines: 1,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 8,
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Column(
                        children: [
                          Expanded(
                              flex: 8,
                              child: charts.BarChart(
                                series,
                                animate: true,
                                domainAxis: new charts.OrdinalAxisSpec(
                                    renderSpec: new charts
                                            .SmallTickRendererSpec(

                                        // Tick and Label styling here.
                                        labelStyle: new charts.TextStyleSpec(
                                            fontSize: 11, // size in Pts.
                                            color:
                                                charts.MaterialPalette.black),

                                        // Change the line colors to match text color.
                                        lineStyle: new charts.LineStyleSpec(
                                            color:
                                                charts.MaterialPalette.black))),
                                primaryMeasureAxis: new charts.NumericAxisSpec(
                                  showAxisLine: true,
                                  tickProviderSpec:
                                      new charts.StaticNumericTickProviderSpec(
                                    <charts.TickSpec<num>>[
                                      charts.TickSpec<num>(0),
                                      charts.TickSpec<num>(widget.tankSensSev1),
                                      charts.TickSpec<num>(widget.tankSensSev2),
                                      charts.TickSpec<num>(widget.tankSensSev3),
                                      //charts.TickSpec<num>(75),
                                      charts.TickSpec<num>(100),
                                    ],
                                  ),
                                  renderSpec: new charts.GridlineRendererSpec(
                                    //labelRotation: 50,
                                    labelOffsetFromAxisPx: (1).round(),

                                    // Tick and Label styling here.
                                    labelStyle: new charts.TextStyleSpec(
                                        fontSize:
                                            (10).round(), // size in Pts.
                                        color: charts.MaterialPalette.black),

                                    // Change the line colors to match text color.
                                    lineStyle: new charts.LineStyleSpec(
                                        color: charts
                                            .MaterialPalette.gray.shade400),

                                    axisLineStyle: new charts.LineStyleSpec(
                                        color: charts.MaterialPalette.black),
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
                                      fontSize: 11*oran,
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
                                                    color:
                                                        widget.tankSens3OrtDurum
                                                            ? Colors.orange[700]
                                                            : Colors.black,
                                                    fontWeight:
                                                        widget.tankSens3OrtDurum
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
                                                    color:
                                                        widget.tankSens2OrtDurum
                                                            ? Colors.orange[700]
                                                            : Colors.black,
                                                    fontWeight:
                                                        widget.tankSens2OrtDurum
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
                                                    color:
                                                        widget.tankSens1OrtDurum
                                                            ? Colors.orange[700]
                                                            : Colors.black,
                                                    fontWeight:
                                                        widget.tankSens1OrtDurum
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
                                                    style:
                                                        TextStyle(fontSize: 30),
                                                    textAlign: TextAlign.center,
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
                                                    _degergiris2X1(
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
            ],
          ),
        ),
      ),
    );
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
          index != val[3]) {
        veriGonderilsinMi = true;
      }
      _onlar = val[0];
      _birler = val[1];
      _ondalik = val[2];
      index = val[3];

      String veri = "";

      double data = double.parse((_onlar == 0 ? "" : _onlar.toString()) +
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
}
