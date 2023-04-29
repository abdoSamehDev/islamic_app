import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:elmuslim_app/app/utils/constants.dart';
import 'package:elmuslim_app/domain/models/quran/quran_model.dart';
import 'package:elmuslim_app/presentation/home/screens/quran/cubit/quran_cubit.dart';
import 'package:elmuslim_app/presentation/resources/routes_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:elmuslim_app/app/utils/di.dart';
import 'package:elmuslim_app/presentation/home/cubit/home_cubit.dart';
import 'package:elmuslim_app/presentation/home/viewmodel/home_viewmodel.dart';
import 'package:elmuslim_app/presentation/resources/assets_manager.dart';
import 'package:elmuslim_app/presentation/resources/color_manager.dart';
import 'package:elmuslim_app/presentation/resources/font_manager.dart';
import 'package:elmuslim_app/presentation/resources/strings_manager.dart';
import 'package:flutter_svg/svg.dart';
import 'package:elmuslim_app/presentation/resources/styles_manager.dart';
import 'package:elmuslim_app/presentation/resources/values.dart';

class HomeView extends StatelessWidget {
  final HomeViewModel _viewModel = instance<HomeViewModel>();

  HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
  create: (context) => instance<HomeCubit>()..isThereABookMarked(),
  child: BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        var quranCubit = QuranCubit.get(context);
        List<QuranModel> quranList = quranCubit.quranData;
        // cubit.isThereABookMarked();
        int currentIndex = cubit.currentIndex;
        return Scaffold(
          floatingActionButton: ConditionalBuilder(
            condition: isThereABookMarkedPage == true && currentIndex == 0,
            builder: (BuildContext context) {
              return FloatingActionButton(
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    Routes.testRoute,
                    arguments: {
                      'quranList': quranList,
                      'pageNo': cubit.getBookMarkPage(),
                    },
                  );
                },
                backgroundColor:
                // ColorManager.lightPrimary,
                ColorManager.darkSecondary,
                child: const Icon(
                  Icons.bookmark,
                  color: ColorManager.gold,
                ),
              );
            },
            fallback: (BuildContext context) {
              return Container();
            },
          ),
          appBar: AppBar(
            backgroundColor: Theme.of(context).primaryColor,
            title: Text(
              _viewModel.titles[currentIndex],
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(color: ColorManager.gold),
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
            selectedItemColor: ColorManager.gold,
            selectedIconTheme:
                IconThemeData(color: ColorManager.gold, size: AppSize.s20.r),
            selectedLabelStyle: getSemiBoldStyle(fontSize: FontSize.s14),
            unselectedLabelStyle: getRegularStyle(fontSize: FontSize.s12),
            unselectedItemColor: Theme.of(context).unselectedWidgetColor,
            unselectedIconTheme: IconThemeData(
                color: Theme.of(context).unselectedWidgetColor,
                size: AppSize.s20.r),
            // ColorManager.darkGrey,
            showSelectedLabels: true,
            showUnselectedLabels: true,
            enableFeedback: true,
            currentIndex: currentIndex,
            onTap: (int index) {
              cubit.changeBotNavIndex(index);
            },
            items: [
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  ImageAsset.quranIcon,
                  width: AppSize.s20.r,
                  height: AppSize.s20.r,
                  color: currentIndex == 0
                      ? ColorManager.gold
                      : Theme.of(context).unselectedWidgetColor,
                ),
                label: AppStrings.quran.tr(),
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  ImageAsset.hadithIcon,
                  width: AppSize.s20.r,
                  height: AppSize.s20.r,
                  color: currentIndex == 1
                      ? ColorManager.gold
                      : Theme.of(context).unselectedWidgetColor,
                ),
                label: AppStrings.hadith.tr(),
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  ImageAsset.azkarIcon,
                  width: AppSize.s20.r,
                  height: AppSize.s20.r,
                  color: currentIndex == 2
                      ? ColorManager.gold
                      : Theme.of(context).unselectedWidgetColor,
                ),
                label: AppStrings.azkar.tr(),
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.settings_outlined),
                label: AppStrings.settings.tr(),
              ),
            ],
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: AppPadding.p8.w),
            child: _viewModel.screens[currentIndex],
          ),
        );
      },
    ),
);
  }
}
