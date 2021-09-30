import 'package:get_it/get_it.dart';
import 'package:midowe_app/providers/user_provider.dart';
import 'package:midowe_app/services/user_service.dart';

void setupLocator() {
  GetIt.I.registerFactory(() => UserProvider());
  GetIt.I.registerFactory(() => UserService());
}
