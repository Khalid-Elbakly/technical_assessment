import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:technical_assessment/functions/home_page/bloc/home_cubit.dart';

class NetworkService {

  InternetConnection internetConnection = InternetConnection();


  static void listenNetwork(HomeCubit homeCubit) {
    InternetConnection().onStatusChange.listen((InternetStatus status) async {
      switch (status) {
        case InternetStatus.connected:
          print("connected");
          homeCubit.onConnectListen();
          // The internet is now connected
          break;
        case InternetStatus.disconnected:
          print("disconnected");
          // The internet is now disconnected
          break;
      }
    });
  }

  static Future<bool> get isConnected async {
    try {
      return await InternetConnection().hasInternetAccess;
    } catch (e) {
      throw Future.error(e);
    }
  }
}
