import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:islamic_app/app/utils/di.dart';
import 'package:islamic_app/presentation/home/view/home_view.dart';
import 'package:islamic_app/presentation/home/view/test.dart';
import 'package:islamic_app/presentation/resources/strings_manager.dart';
import 'package:islamic_app/presentation/surah_builder/view/surah_builder_view.dart';
import 'package:islamic_app/presentation/zekr_builder/view/zekr_builder_view.dart';



class Routes {
  static const String homeRoute = "/";
  static const String testRoute = "/test";
  static const String quranRoute = "/quran";
  static const String hadithRoute = "/hadith";
  static const String azkarRoute = "/azkar";
  // static const String testRoute = "/test";
  // static const String settingsRoute = "/settings";
// static const String splashRoute = "/";
// static const String splashRoute = "/";
}

class RoutesGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.homeRoute:
        initQuranModule();
        initHadithModule();
        initAzkarModule();
        return MaterialPageRoute(builder: (_) =>  HomeView());
      case Routes.testRoute:
        return MaterialPageRoute(builder: (_) =>  const TestScreen());
      case Routes.quranRoute:
        return MaterialPageRoute(builder: (_) =>  const SurahBuilderView());
      // case Routes.hadithRoute:
      //   return MaterialPageRoute(builder: (_) =>  const HadithBuilderView(hadithModel: hadithModel));
      case Routes.azkarRoute:
        return MaterialPageRoute(builder: (_) =>  const ZekrBuilderView());
      // case Routes.settingsRoute:
      //   return MaterialPageRoute(builder: (_) => const SettingsView());
      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(
          title:  Text(
            AppStrings.noRouteFound.tr(),
          ),
        ),
        body:  Center(
          child: Text(
            AppStrings.noRouteFound.tr(),
          ),
        ),
      ),
    );
  }
}
