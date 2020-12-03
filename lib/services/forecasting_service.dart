import 'package:ra_forecasting/models/data_forecasting.dart';
import 'package:ra_forecasting/repositories/repository.dart';

class ForecastingService {
  Repository _repository;

  ForecastingService() {
    _repository = Repository();
  }

  saveData(DataForecasting dataForecasting) async {
    return await _repository.insertData(
        "data_forecasting", dataForecasting.dataMap());
  }

  readData() async {
    return await _repository.readData("data_forecasting");
  }

  readDataById(int id) async {
    return await _repository.readDataById('data_forecasting', id);
  }

  deleteDataById(int id) async {
    return await _repository.deleteData('data_forecasting', id);
  }

  updateData(DataForecasting dataForecasting) async {
    return await _repository.updateData(
        'data_forecasting', dataForecasting.dataMap());
  }
}
