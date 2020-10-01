import 'package:flutter/material.dart';

class DegerGiris3X1 extends StatefulWidget {
  int yuzlerX = 0;
  int onlarX = 0;
  int birlerX = 0;
  int ondalikX = 0;
  int index = 0;
  String baslik;
  String onBaslik;

  DegerGiris3X1.Deger(
    int gelenYuzlerX,
    int gelenOnlarX,
    int gelenBirlerX,
    int gelenOndalikX,
    int gelenIndex,
    String gelenBaslik,
    String gelenOnBaslik,
  ) {
    yuzlerX = gelenYuzlerX;
    onlarX = gelenOnlarX;
    birlerX = gelenBirlerX;
    ondalikX = gelenOndalikX;
    index = gelenIndex;
    baslik = gelenBaslik;
    onBaslik = gelenOnBaslik;
  }

  @override
  _DegerGiris3X1State createState() => new _DegerGiris3X1State.Deger(
      yuzlerX,onlarX, birlerX,ondalikX, index, baslik,onBaslik);
}

class _DegerGiris3X1State extends State<DegerGiris3X1> {
  int yuzlerX = 0;
  int yuzlerX1 = 0;
  int onlarX = 0;
  int onlarX1 = 0;
  int birlerX = 0;
  int birlerX1 = 0;
  int ondalikX = 0;
  int ondalikX1 = 0;
  int index = 0;
  String baslik;
  String onBaslik;

  _DegerGiris3X1State.Deger(int gelenYuzlerX,gelenOnlarX,gelenBirlerX,gelenOndalikX,gelenIndex,
     String gelenBaslik,String gelenOnBaslik) {
    yuzlerX = gelenYuzlerX;
    yuzlerX1 = gelenYuzlerX;
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
    var oran = MediaQuery.of(context).size.width / 731.4;
    return AlertDialog(
      titlePadding: EdgeInsets.only(top: 7*oran , bottom: 7*oran ),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25*oran ))),
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
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                    textScaleFactor: oran,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      //Yüzler
                      Padding(
                        padding:
                            EdgeInsets.only(right: 10*oran , top: 5*oran ),
                        child: Column(
                          children: <Widget>[
                            RawMaterialButton(
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                              constraints: BoxConstraints(),
                              padding: EdgeInsets.all(0),
                              child: RotatedBox(quarterTurns: 2,
                                child: Icon(
                                  Icons.arrow_drop_down_circle,
                                  size: 40*oran,
                                  color: Colors.white,
                                ),
                              ),
                              onPressed: () {
                                if (yuzlerX < 9)
                                  yuzlerX++;
                                else
                                  yuzlerX = 0;

                                setState(() {});
                              },
                            ),
                            Text(
                              yuzlerX.toString(),
                              style: TextStyle(
                                  fontSize: 50,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Kelly Slab'),
                              textScaleFactor: oran,
                            ),
                            RawMaterialButton(
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                              constraints: BoxConstraints(),
                              padding: EdgeInsets.all(0),
                              child: Icon(
                                Icons.arrow_drop_down_circle,
                                size: 40*oran,
                                  color: Colors.white,
                              ),
                              onPressed: () {
                                if (yuzlerX > 0)
                                  yuzlerX--;
                                else
                                  yuzlerX = 9;

                                setState(() {});
                              },
                            ),
                          ],
                        ),
                      ),
                      //Onlar
                      Padding(
                        padding:
                            EdgeInsets.only(right: 10*oran , top: 5*oran ),
                        child: Column(
                          children: <Widget>[
                            RawMaterialButton(
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                              constraints: BoxConstraints(),
                              padding: EdgeInsets.all(0),
                              child: RotatedBox(quarterTurns: 2,
                                child: Icon(
                                  Icons.arrow_drop_down_circle,
                                  size: 40*oran,
                                  color: Colors.white,
                                ),
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
                                  fontSize: 50,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Kelly Slab'),
                              textScaleFactor: oran,
                            ),
                            RawMaterialButton(
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                              constraints: BoxConstraints(),
                              padding: EdgeInsets.all(0),
                              child: Icon(
                                Icons.arrow_drop_down_circle,
                                size: 40*oran,
                                  color: Colors.white,
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
                      //Birler
                      Padding(
                        padding:
                            EdgeInsets.only(right: 10*oran , top: 5*oran ),
                        child: Column(
                          children: <Widget>[
                            RawMaterialButton(
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                              constraints: BoxConstraints(),
                              padding: EdgeInsets.all(0),
                              child: RotatedBox(quarterTurns: 2,
                                child: Icon(
                                  Icons.arrow_drop_down_circle,
                                  size: 40*oran,
                                    color: Colors.white,
                                ),
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
                                  fontSize: 50,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Kelly Slab'),
                              textScaleFactor: oran,
                            ),
                            RawMaterialButton(
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                              constraints: BoxConstraints(),
                              padding: EdgeInsets.all(0),
                              child: Icon(
                                Icons.arrow_drop_down_circle,
                                size: 40*oran,
                                  color: Colors.white,
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
                            EdgeInsets.only(right: 10*oran , top: 5*oran ),
                        child: Column(
                          children: <Widget>[
                            RawMaterialButton(
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                              constraints: BoxConstraints(),
                              padding: EdgeInsets.all(0),
                              child: RotatedBox(quarterTurns: 2,
                                                              child: Icon(
                                  Icons.arrow_drop_down_circle,
                                  size: 40*oran,
                                    color: Colors.white,
                                ),
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
                                  fontSize: 50,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Kelly Slab'),
                              textScaleFactor: oran,
                            ),
                            RawMaterialButton(
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                              constraints: BoxConstraints(),
                              padding: EdgeInsets.all(0),
                              child: Icon(
                                Icons.arrow_drop_down_circle,
                                size: 40*oran,
                                  color: Colors.white,
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
          padding: EdgeInsets.only(bottom: 10*oran ),
          alignment: Alignment.center,
          width: 400*oran ,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(right: 20*oran ),
                child: RaisedButton(
                  color: Colors.indigo,
                  onPressed: () {
                    var deger = [yuzlerX,onlarX, birlerX, ondalikX, index];
                    Navigator.of(context).pop(deger);
                  },
                  child: Text(
                    "ONAY",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 25*oran ,
                        fontFamily: 'Audio wide'),
                  ),
                ),
              ),
              Container(
                child: RaisedButton(
                  color: Colors.indigo,
                  onPressed: () {
                    var deger = [yuzlerX1,onlarX1, birlerX1,ondalikX1, index];
                    Navigator.of(context).pop(deger);
                  },
                  child: Text(
                    "ÇIKIŞ",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 25*oran ,
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
