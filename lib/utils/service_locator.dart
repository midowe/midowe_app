import 'package:get_it/get_it.dart';
import 'package:midowe_app/providers/accounting_provider.dart';
import 'package:midowe_app/providers/campaign_provider.dart';
import 'package:midowe_app/providers/category_provider.dart';
import 'package:midowe_app/providers/fundraiser_provider.dart';

void setupLocator() {
  GetIt.I.registerFactory(() => FundraiserProvider());
  GetIt.I.registerFactory(() => CategoryProvider());
  GetIt.I.registerFactory(() => CampaignProvider());
  GetIt.I.registerFactory(() => AccountingProvider());
}
