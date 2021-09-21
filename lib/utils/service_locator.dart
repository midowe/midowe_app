import 'package:get_it/get_it.dart';
import 'package:midowe_app/providers/user_provider.dart';

void setupLocator() {
  GetIt.I.registerFactory(() => UserProvider());
}
