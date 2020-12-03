import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:giffy_dialog/giffy_dialog.dart';
import 'package:google_fonts/google_fonts.dart';

class CountData extends StatefulWidget {
  final double b1;
  final double b0;
  CountData(this.b1, this.b0, {Key key}) : super(key: key);

  @override
  _CountDataState createState() => _CountDataState();
}

class _CountDataState extends State<CountData> {
  var _predictWeek = TextEditingController();
  double y = 0;

  @override
  void initState() {
    super.initState();
    print(this.widget.b1);
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Container(
      height: height * 0.9,
      padding: EdgeInsets.all(18.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  child: Icon(
                    Icons.arrow_downward_rounded,
                    color: Color(0xFF425EEE),
                    size: 30,
                  ),
                ),
              ),
              Text(
                "Count",
                style: GoogleFonts.lato(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),

          // Field
          Container(
            padding: EdgeInsets.only(top: 18, bottom: 18, right: 15, left: 15),
            decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.black45.withOpacity(0.2),
                      spreadRadius: 0,
                      blurRadius: 3,
                      offset: Offset(1, 2))
                ],
                borderRadius: BorderRadius.circular(10)),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Prediction for",
                        style: GoogleFonts.lato(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: Colors.black.withAlpha(1100))),
                    Icon(
                      Icons.calendar_today,
                      color: Color(0xFF425EEE),
                    )
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                TextField(
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  controller: _predictWeek,
                  showCursor: false,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                      border: InputBorder.none, hintText: "Weeks"),
                  style: TextStyle(fontSize: 20.0),
                ),
              ],
            ),
          ),

          Container(
            padding: EdgeInsets.all(20),
            // borderRadius: BorderRadius.circular(1),
            child: RaisedButton(
                padding: EdgeInsets.only(
                    left: 150.0, right: 150.0, top: 15.0, bottom: 15.0),
                color: Color(0xFF425EEE),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                child: Text(
                  "Count",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  y = (this.widget.b0 +
                      this.widget.b1 * double.parse(_predictWeek.text));
                  setState(() {
                    showDialog(
                      context: context,
                      builder: (_) => FlareGiffyDialog(
                        flarePath: 'assets/flare/space_demo.flr',
                        flareAnimation: 'loading',
                        flareFit: BoxFit.contain,
                        title: Text(
                          "Prediction for next week is",
                          style: GoogleFonts.lato(
                              fontSize: 20, fontWeight: FontWeight.w600),
                        ),
                        description: Text(
                          y.toString(),
                          style: GoogleFonts.montserrat(
                              fontSize: 17,
                              fontWeight: FontWeight.w500,
                              color: Colors.black.withAlpha(500)),
                        ),
                        entryAnimation: EntryAnimation.DEFAULT,
                        buttonCancelText: Text(
                          "Close",
                          style: TextStyle(color: Colors.white),
                        ),
                        onlyCancelButton: true,
                        buttonCancelColor: Color(0xFF425EEE),
                      ),
                    );
                  });
                }),
          ),
        ],
      ),
    );
  }
}
