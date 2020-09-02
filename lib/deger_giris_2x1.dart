import 'package:flutter/material.dart';

class DegerGiris2X1 extends StatefulWidget {
  int onlarX = 0;
  int birlerX = 0;
  int ondalikX = 0;
  int index = 0;
  String baslik;
  String onBaslik;

  DegerGiris2X1.Deger(
    int gelenOnlarX,
    int gelenBirlerX,
    int gelenOndalikX,
    int gelenIndex,
    String gelenBaslik,
    String gelenOnBaslik,
  ) {
    onlarX = gelenOnlarX;
    birlerX = gelenBirlerX;
    ondalikX = gelenOndalikX;
    index = gelenIndex;
    baslik = gelenBaslik;
    onBaslik = gelenOnBaslik;
  }

  @override
  _DegerGiris2X1State createState() => new _DegerGiris2X1State.Deger(
      onlarX, birlerX,ondalikX, index, baslik,onBaslik);
}

class _DegerGiris2X1State extends State<DegerGiris2X1> {
  int onlarX = 0;
  int onlarX1 = 0;
  int birlerX = 0;
  int birlerX1 = 0;
  int ondalikX = 0;
  int ondalikX1 = 0;
  int index = 0;
  String baslik;
  String onBaslik;

  _DegerGiris2X1State.Deger(int gelenOnlarX,gelenBirlerX,gelenOndalikX,gelenIndex,
     String gelenBaslik,String gelenOnBaslik) {
    onlarX = gelenOnlarX;
    onlarX1 = gelenOnlarX;
    birlerX = gelenBirlerX;
    birlerX1 = gelenBirlerX;
    ondalikX =  gelenOndalikX;
    ondalikX1 = gelenOndalikX;
    index = gelenIndex;
    baslik = gelenBaslik;
    onBaslik = gelenOnBaslik;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      titlePadding: EdgeInsets.only(top: 10 , bottom: 10 ),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(32.0 ))),
      backgroundColor: Colors.deepOrange.shade800,
      title: Container(
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Column(
                children: <Widget>[
                  Text(
                    onBaslik+ baslik,
                    style: TextStyle(
                        fontFamily: 'Kelly Slab',
                        color: Colors.white,
                        fontSize: 50,
                        fontWeight: FontWeight.bold),
                    textScaleFactor: 1,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding:
                            EdgeInsets.only(right: 10 , top: 5 ),
                        child: Column(
                          children: <Widget>[
                            RawMaterialButton(
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                              constraints: BoxConstraints(),
                              padding: EdgeInsets.all(0),
                              child: Image.asset(
                                'assets/images/deger_artir_icon.png',
                                scale: 3 / 1,
                              ),
                              onPressed: () {
                                if (onlarX < 9)
                                  onlarX++;
                                else
                                  onlarX = 0;

                                setState(() {});
                              },
                            ),
                            Text(
                              onlarX.toString(),
                              style: TextStyle(
                                  fontSize: 80,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Kelly Slab'),
                              textScaleFactor: 1,
                            ),
                            RawMaterialButton(
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                              constraints: BoxConstraints(),
                              padding: EdgeInsets.all(0),
                              child: Image.asset(
                                'assets/images/deger_dusur_icon.png',
                                scale: 3 / 1,
                              ),
                              onPressed: () {
                                if (onlarX > 0)
                                  onlarX--;
                                else
                                  onlarX = 9;

                                setState(() {});
                              },
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.only(right: 10 , top: 5 ),
                        child: Column(
                          children: <Widget>[
                            RawMaterialButton(
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                              constraints: BoxConstraints(),
                              padding: EdgeInsets.all(0),
                              child: Image.asset(
                                'assets/images/deger_artir_icon.png',
                                scale: 3 / 1,
                              ),
                              onPressed: () {
                                if (birlerX < 9)
                                  birlerX++;
                                else
                                  birlerX = 0;

                                setState(() {});
                              },
                            ),
                            Text(
                              birlerX.toString(),
                              style: TextStyle(
                                  fontSize: 80,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Kelly Slab'),
                              textScaleFactor: 1,
                            ),
                            RawMaterialButton(
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                              constraints: BoxConstraints(),
                              padding: EdgeInsets.all(0),
                              child: Image.asset(
                                'assets/images/deger_dusur_icon.png',
                                scale: 3 / 1,
                              ),
                              onPressed: () {
                                if (birlerX > 0)
                                  birlerX--;
                                else
                                  birlerX = 9;

                                setState(() {});
                              },
                            ),
                          ],
                        ),
                      ),
                      Text(".",style: TextStyle(fontSize: 80,fontWeight: FontWeight.bold),),
                      Padding(
                        padding:
                            EdgeInsets.only(right: 10 , top: 5 ),
                        child: Column(
                          children: <Widget>[
                            RawMaterialButton(
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                              constraints: BoxConstraints(),
                              padding: EdgeInsets.all(0),
                              child: Image.asset(
                                'assets/images/deger_artir_icon.png',
                                scale: 3 / 1,
                              ),
                              onPressed: () {
                                if (ondalikX < 9)
                                  ondalikX++;
                                else
                                  ondalikX = 0;

                                setState(() {});
                              },
                            ),
                            Text(
                              ondalikX.toString(),
                              style: TextStyle(
                                  fontSize: 80,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Kelly Slab'),
                              textScaleFactor: 1,
                            ),
                            RawMaterialButton(
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                              constraints: BoxConstraints(),
                              padding: EdgeInsets.all(0),
                              child: Image.asset(
                                'assets/images/deger_dusur_icon.png',
                                scale: 3 / 1,
                              ),
                              onPressed: () {
                                if (ondalikX > 0)
                                  ondalikX--;
                                else
                                  ondalikX = 9;

                                setState(() {});
                              },
                            ),
                          ],
                        ),
                      ),
                      
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        Container(
          padding: EdgeInsets.only(bottom: 10 ),
          alignment: Alignment.center,
          width: 600 ,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(right: 20 ),
                child: RaisedButton(
                  color: Colors.indigo,
                  onPressed: () {
                    var deger = [onlarX, birlerX, ondalikX, index];
                    Navigator.of(context).pop(deger);
                  },
                  child: Text(
                    "ONAY",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 40 ,
                        fontFamily: 'Audio wide'),
                  ),
                ),
              ),
              Container(
                child: RaisedButton(
                  color: Colors.indigo,
                  onPressed: () {
                    var deger = [onlarX1, birlerX1,ondalikX1, index];
                    Navigator.of(context).pop(deger);
                  },
                  child: Text(
                    "ÇIKIŞ",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 40 ,
                        fontFamily: 'Audio wide'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
