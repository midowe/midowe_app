import 'package:get_it/get_it.dart';
import 'package:midowe_app/providers/campaign_provider.dart';
import 'package:midowe_app/providers/category_provider.dart';
import 'package:midowe_app/providers/user_provider.dart';

void setupLocator() {
  GetIt.I.registerFactory(() => UserProvider());
  GetIt.I.registerFactory(() => CategoryProvider());
  GetIt.I.registerFactory(() => CampaignProvider());
}
