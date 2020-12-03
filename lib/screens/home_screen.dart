import 'package:backdrop_modal_route/backdrop_modal_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:giffy_dialog/giffy_dialog.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ra_forecasting/backdrop/add_data.dart';
import 'package:ra_forecasting/backdrop/count_data.dart';
import 'package:ra_forecasting/backdrop/edit_delete_data.dart';
import 'package:ra_forecasting/models/data_forecasting.dart';
import 'package:ra_forecasting/services/forecasting_service.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // init service
  ForecastingService _forecastingService;
  List<DataForecasting> _dataList = List<DataForecasting>();

  @override
  void initState() {
    super.initState();
    getAllData();
  }

  int xX = 0;
  int xY = 0;
  int totalX = 0;
  int totalY = 0;
  int totalXY = 0;
  int totalXX = 0;
  double b1 = 0;
  double b0 = 0;

  getAllData() async {
    _forecastingService = ForecastingService();
    _dataList = List<DataForecasting>();

    var result = await _forecastingService.readData();
    for (var x = 0; x < result.length; x++) {
      var res = result[x];
      setState(() {
        var model = DataForecasting();
        model.id = res['id'];
        model.date = res['date'];
        model.selling = res['selling'];
        xX = x * x;
        xY = x * model.selling;
        totalX = totalX + x;
        totalY = totalY + model.selling;
        totalXX = totalXX + xX;
        totalXY = totalXY + xY;

        _dataList.add(model);
      });
    }
    setState(() {
      b1 = ((totalXY - ((totalX * totalY) / result.length)) /
          (totalXX - ((totalX * totalX) / result.length)));
      b0 = (totalY / result.length) - b1 * (totalX / result.length);
    });
    print(b0);
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
        body: Stack(
          children: [
            // Background clipper
            ClipPath(
              clipper: OvalBottomBorderClipper(),
              child: Container(
                height: height * 0.4,
                color: Color(0xFF425EEE),
              ),
            ),

            // CONTENT
            SafeArea(
              child: Padding(
                padding: EdgeInsets.only(top: 16.0),
                child: Container(
                  child: ListView(
                    scrollDirection: Axis.vertical,
                    physics: BouncingScrollPhysics(),
                    children: [
                      // NAVIGATOR HEADER
                      Padding(
                        padding: EdgeInsets.only(right: 25.0, left: 25.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Rafor",
                              style: GoogleFonts.parisienne(
                                  fontSize: 30,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white),
                            ),
                            Container(
                              child: GestureDetector(
                                child: SvgPicture.asset(
                                    'assets/svg/entypo_info-with-circle.svg'),
                                onTap: () => showDialog(
                                  context: context,
                                  builder: (_) => FlareGiffyDialog(
                                    flareAnimation: 'intro',
                                    flarePath: 'assets/flare/intro.flr',
                                    flareFit: BoxFit.contain,
                                    title: Text(
                                      "Rama Forecasting",
                                      style: GoogleFonts.lato(
                                          fontSize: 30,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    description: Text(
                                      "Design and code by Novandra Zulfi Ramadhan",
                                      style: GoogleFonts.montserrat(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black.withAlpha(300)),
                                    ),
                                    entryAnimation: EntryAnimation.BOTTOM,
                                    buttonCancelText: Text(
                                      "Close",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    onlyCancelButton: true,
                                    buttonCancelColor: Color(0xFF425EEE),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),

                      // TEXT WIDGET FOR SUMMARY
                      Container(
                        padding: EdgeInsets.only(right: 25.0, left: 25.0),
                        margin: EdgeInsets.only(top: 28.8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text("Summary",
                                style: GoogleFonts.lato(
                                  fontSize: 40,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                )),
                          ],
                        ),
                      ),

                      // LIST VIEW FOR SUMMARY CARD
                      Container(
                        margin: EdgeInsets.only(top: 24),
                        height: 100,
                        child: ListView(
                          padding: EdgeInsets.only(left: 25.0),

                          // itemCount: 4,
                          scrollDirection: Axis.horizontal,
                          physics: BouncingScrollPhysics(),
                          children: [
                            // X CARD SUMMARY
                            Container(
                              margin: EdgeInsets.only(right: 19.2, bottom: 10),
                              padding: EdgeInsets.all(10),
                              height: 90,
                              width: 148,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black45.withOpacity(0.2),
                                        spreadRadius: 0,
                                        blurRadius: 3,
                                        offset: Offset(1, 2))
                                  ]),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        "SUM",
                                        style: GoogleFonts.lato(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 20,
                                            color: Colors.black.withAlpha(100)),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "X",
                                        style: GoogleFonts.lato(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 37,
                                            color: Color(0xFF425EEE)),
                                      ),
                                      Text(
                                        totalX.toString(),
                                        style: GoogleFonts.lato(
                                            fontWeight: FontWeight.w800,
                                            fontSize: 37,
                                            color: Colors.black.withAlpha(200)),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(right: 19.2, bottom: 10),
                              padding: EdgeInsets.all(10),
                              height: 90,
                              width: 148,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black45.withOpacity(0.2),
                                        spreadRadius: 0,
                                        blurRadius: 3,
                                        offset: Offset(1, 2))
                                  ]),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        "SUM",
                                        style: GoogleFonts.lato(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 20,
                                            color: Colors.black.withAlpha(100)),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Y",
                                        style: GoogleFonts.lato(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 37,
                                            color: Color(0xFF425EEE)),
                                      ),
                                      Text(
                                        totalY.toString(),
                                        style: GoogleFonts.lato(
                                            fontWeight: FontWeight.w800,
                                            fontSize: 37,
                                            color: Colors.black.withAlpha(200)),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(right: 19.2, bottom: 10),
                              padding: EdgeInsets.all(10),
                              height: 90,
                              width: 148,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black45.withOpacity(0.2),
                                        spreadRadius: 0,
                                        blurRadius: 3,
                                        offset: Offset(1, 2))
                                  ]),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        "SUM",
                                        style: GoogleFonts.lato(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 20,
                                            color: Colors.black.withAlpha(100)),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "XY",
                                        style: GoogleFonts.lato(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 37,
                                            color: Color(0xFF425EEE)),
                                      ),
                                      Text(
                                        totalXY.toString(),
                                        style: GoogleFonts.lato(
                                            fontWeight: FontWeight.w800,
                                            fontSize: 37,
                                            color: Colors.black.withAlpha(200)),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(right: 19.2, bottom: 10),
                              padding: EdgeInsets.all(10),
                              height: 90,
                              width: 148,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black45.withOpacity(0.2),
                                        spreadRadius: 0,
                                        blurRadius: 3,
                                        offset: Offset(1, 2))
                                  ]),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        "SUM",
                                        style: GoogleFonts.lato(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 20,
                                            color: Colors.black.withAlpha(100)),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "XX",
                                        style: GoogleFonts.lato(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 37,
                                            color: Color(0xFF425EEE)),
                                      ),
                                      Text(
                                        totalXX.toString(),
                                        style: GoogleFonts.lato(
                                            fontWeight: FontWeight.w800,
                                            fontSize: 37,
                                            color: Colors.black.withAlpha(200)),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),

                      // TEXT WIDGET FOR DATA LIST VIEW
                      Container(
                        padding: EdgeInsets.only(right: 25.0, left: 25.0),
                        margin: EdgeInsets.only(top: 28.8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text("Data",
                                style: GoogleFonts.lato(
                                  fontSize: 30,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black.withAlpha(200),
                                )),
                          ],
                        ),
                      ),

                      // LIST DATA
                      Container(
                        margin: EdgeInsets.only(top: 11),
                        padding: EdgeInsets.only(left: 25.0, right: 25.0),
                        child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: _dataList.length,
                            itemBuilder: (contex, index) {
                              return GestureDetector(
                                onTap: () => handleTapDataBackdrop(
                                    context, _dataList[index].id),
                                child: Container(
                                  margin: EdgeInsets.only(
                                      right: 19.2, bottom: 10, left: 10),
                                  padding: EdgeInsets.only(
                                      top: 10, bottom: 10, left: 15, right: 15),
                                  width: width,
                                  height: 72,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: [
                                        BoxShadow(
                                            color:
                                                Colors.black45.withOpacity(0.2),
                                            spreadRadius: 0,
                                            blurRadius: 3,
                                            offset: Offset(1, 2))
                                      ]),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.calendar_today,
                                            color: Color(0xFF425EEE),
                                          ),
                                          SizedBox(width: 20),
                                          Text(
                                            _dataList[index].date,
                                            style: GoogleFonts.lato(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        _dataList[index].selling.toString(),
                                        style: GoogleFonts.lato(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            }),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
        floatingActionButton: Padding(
          padding: EdgeInsets.only(right: 25.0, left: 25.0),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Container(
              padding: EdgeInsets.only(left: 25.0),
              width: 310,
              height: 55,
              child: FloatingActionButton.extended(
                backgroundColor: Color(0xFF425EEE),
                label: Text(
                  "Count",
                  style: GoogleFonts.lato(
                      fontSize: 21,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                ),
                onPressed: () {
                  handleCountDataBackdrop(context);
                },
              ),
            ),
            Container(
              child: FloatingActionButton(
                backgroundColor: Color(0xFF425EEE),
                child: Icon(Icons.add),
                onPressed: () {
                  handleAddDataBackdrop(context);
                },
              ),
            )
          ]),
        ));
  }

  void handleAddDataBackdrop(BuildContext context) async {
    var result = await Navigator.push(
      context,
      BackdropModalRoute<int>(
          overlayContentBuilder: (context) => AddData(), topPadding: 77.0),
    );

    if (result == 1) {
      xX = 0;
      xY = 0;
      totalX = 0;
      totalY = 0;
      totalXY = 0;
      totalXX = 0;
      setState(() {
        getAllData();
      });
    }
  }

  void handleCountDataBackdrop(BuildContext context) async {
    Navigator.push(
      context,
      BackdropModalRoute<String>(
          overlayContentBuilder: (context) => CountData(b1, b0),
          topPadding: 77.0),
    );
  }

  void handleTapDataBackdrop(BuildContext context, int id) async {
    var result = await Navigator.push(
      context,
      BackdropModalRoute<int>(
          overlayContentBuilder: (context) => EditDeleteData(id),
          topPadding: 77.0),
    );

    if (result == 1) {
      setState(() {
        xX = 0;
        xY = 0;
        totalX = 0;
        totalY = 0;
        totalXY = 0;
        totalXX = 0;
        setState(() {
          getAllData();
        });
      });
    }
  }
}
