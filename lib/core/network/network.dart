import 'package:connectivity_plus/connectivity_plus.dart';

abstract interface class NetworkInfo {
  Future<bool> get isConnected;
}

final class NetworkInfoImpl implements NetworkInfo {
  final Connectivity _connectivity;

  NetworkInfoImpl(this._connectivity);

  @override
  Future<bool> get isConnected async =>
      (await _connectivity.checkConnectivity()).isNotEmpty;
}
