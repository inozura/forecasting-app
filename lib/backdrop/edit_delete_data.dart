import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:giffy_dialog/giffy_dialog.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ra_forecasting/models/data_forecasting.dart';
import 'package:ra_forecasting/services/forecasting_service.dart';

class EditDeleteData extends StatefulWidget {
  final int id;
  EditDeleteData(this.id, {Key key}) : super(key: key);

  @override
  _EditDeleteDataState createState() => _EditDeleteDataState();
}

class _EditDeleteDataState extends State<EditDeleteData> {
  // FORM CONTROLLER
  var _dateController = TextEditingController();
  var _sumController = TextEditingController();

  // initial model
  var _dataForcesting = DataForecasting();
  // initial service
  var _forecastingService = ForecastingService();

  // initial variabel data
  var data;

  @override
  void initState() {
    super.initState();
    getDataById();
  }

  getDataById() async {
    var data = await _forecastingService.readDataById(this.widget.id);
    setState(() {
      _dateController.text = data[0]['date'];
      _sumController.text = data[0]['selling'].toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Container(
      height: height * 0.9,
      padding: const EdgeInsets.all(18.0),
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
                "Edit or Delete",
                style: GoogleFonts.lato(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (_) => FlareGiffyDialog(
                      flarePath: 'assets/flare/Warning 1.flr',
                      flareFit: BoxFit.contain,
                      flareAnimation: 'loading',
                      title: Text(
                        "Delete data",
                        style: GoogleFonts.lato(
                            fontSize: 30, fontWeight: FontWeight.w700),
                      ),
                      description: Text(
                        "Are you sure to delete this data?",
                        style: GoogleFonts.montserrat(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: Colors.black.withAlpha(300)),
                      ),
                      entryAnimation: EntryAnimation.DEFAULT,
                      buttonCancelText: Text(
                        "Close",
                        style: TextStyle(color: Colors.white),
                      ),
                      buttonOkColor: Colors.red,
                      buttonCancelColor: Color(0xFF425EEE),
                      onOkButtonPressed: () async {
                        var result = await _forecastingService
                            .deleteDataById(this.widget.id);
                        if (result > 0) {
                          Navigator.pop(context);
                          Navigator.pop(context, 1);
                        }
                      },
                    ),
                  );
                },
                child: Container(
                  child: Icon(
                    Icons.delete_outline,
                    color: Colors.red,
                    size: 30,
                  ),
                ),
              ),
            ],
          ),
          Container(
            child: Column(
              children: [
                // date textfield
                TextField(
                  controller: _dateController,
                  textAlign: TextAlign.right,
                  showCursor: false,
                  decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.calendar_today,
                        color: Color(0xFF425EEE),
                      ),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFF425EEE)))
                      // border: InputBorder.none,
                      ),
                  style: TextStyle(fontSize: 30.0),
                ),
                SizedBox(
                  height: 30,
                ),
                TextField(
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  controller: _sumController,
                  showCursor: false,
                  textAlign: TextAlign.right,
                  decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.bubble_chart_rounded,
                        color: Color(0xFF425EEE),
                      ),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFF425EEE)))
                      // border: InputBorder.none,
                      ),
                  style: TextStyle(fontSize: 30.0),
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
                "Update",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () async {
                _dataForcesting.id = this.widget.id;
                _dataForcesting.date = _dateController.text;
                _dataForcesting.selling = int.parse(_sumController.text);

                var result =
                    await _forecastingService.updateData(_dataForcesting);
                if (result > 0) {
                  Navigator.pop(context, 1);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
