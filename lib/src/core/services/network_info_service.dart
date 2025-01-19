import 'package:internet_connection_checker/internet_connection_checker.dart';

final class NetworkInfoService {
  final InternetConnectionChecker _connectionChecker;

  NetworkInfoService(this._connectionChecker);

  Future<bool> get isConnected => _connectionChecker.hasConnection;
}