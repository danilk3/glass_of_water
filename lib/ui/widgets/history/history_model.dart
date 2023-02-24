import 'package:flutter/material.dart';

import '../../../data_providers/user_data_provider.dart';
import '../../../domain/api_client.dart';

class HistoryModel extends ChangeNotifier {
  final _apiClient = ApiClient();

  List? _trips;

  List? get trips => _trips;

  Future<void> getTrips() async {
    // TODO: добавить обработку ошибок.
    var id = await UserDataProvider().getUserId();
    _trips = await _apiClient.getAllTrips(int.parse(id!));
  }
}
