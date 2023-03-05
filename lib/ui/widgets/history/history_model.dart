import 'package:flutter/material.dart';

import '../../../domain/api_client.dart';

class HistoryModel extends ChangeNotifier {
  final _apiClient = ApiClient();

  List? _trips;

  List? get trips => _trips;

  Future<void> getTrips() async {
    _trips = await _apiClient.getAllTrips();
  }
}
