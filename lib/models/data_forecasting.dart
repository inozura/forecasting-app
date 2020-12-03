class DataForecasting {
  int id;
  String date;
  int selling;

  dataMap() {
    var mapping = Map<String, dynamic>();
    mapping["id"] = id;
    mapping["date"] = date;
    mapping["selling"] = selling;

    return mapping;
  }
}
