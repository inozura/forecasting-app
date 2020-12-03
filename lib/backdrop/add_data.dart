import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ra_forecasting/models/data_forecasting.dart';
import 'package:ra_forecasting/services/forecasting_service.dart';

class AddData extends StatefulWidget {
  AddData({Key key}) : super(key: key);

  @override
  _AddDataState createState() => _AddDataState();
}

class _AddDataState extends State<AddData> {
  // FORM CONTROLLER
  var _dateController = TextEditingController();
  var _sumController = TextEditingController();

  // initial model
  var _dataForcesting = DataForecasting();
  // initial service
  var _forecastingService = ForecastingService();

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
                "Add Data",
                style: GoogleFonts.lato(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
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
                "Add",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () async {
                _dataForcesting.date = _dateController.text;
                _dataForcesting.selling = int.parse(_sumController.text);

                var result =
                    await _forecastingService.saveData(_dataForcesting);
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
