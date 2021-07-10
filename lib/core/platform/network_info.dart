import 'dart:io';

abstract class NetWorkInfo {
  Future<bool> get isConnected async {
    bool value = false;
    final result = await InternetAddress.lookup('google.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      value = true;
    } else {
      value = false;
    }

    return value;
  }
}
