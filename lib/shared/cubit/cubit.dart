import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/modules/health/health_screen.dart';
import 'package:news_app/modules/sports/sports_screen.dart';
import 'package:news_app/modules/technology/technology_screen.dart';
import 'package:news_app/shared/network/local/cache_helper.dart';
import 'package:news_app/shared/network/remote/dio_helper.dart';

import 'states.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  int index = 0;

  List<BottomNavigationBarItem> botNavBarItems = [
    BottomNavigationBarItem(
      icon: Icon(
        Icons.laptop,
      ),
      label: 'Technology',
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.sports,
      ),
      label: 'Sports',
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.healing,
      ),
      label: 'Health',
    ),
  ];

  List<Widget> screens = [
    TechnologyScreen(),
    SportsScreen(),
    ScienceScreen(),
  ];

  void changeBottomNav(int index) {
    this.index = index;
    if (index == 0) getTechnology();
    if (index == 1) getSports();
    if (index == 2) getHealth();
    emit(AppChangeBotNavState());
  }

  bool isDark = false;
  void changeMode({bool? fromCache}) {
    if (fromCache != null) {
      isDark = fromCache;
      emit(AppChangeModeState());
    } else {
      isDark = !isDark;
      CacheHelper.setBoolean(
        key: 'isDark',
        value: isDark,
      ).then((value) {
        emit(AppChangeModeState());
      });
    }
  }

  List<dynamic> technology = [];

  void getTechnology() {
    emit(AppGetTechnologyLoadingState());

    DioHelper.getData(
      path: 'v2/top-headlines',
      query: {
        'country': 'us',
        'category': 'technology',
        'apiKey': '65f7f556ec76449fa7dc7c0069f040ca'
      },
    ).then((value) {
      technology = value.data['articles'];

      emit(AppGetTechnologySuccessState());
    }).catchError((error) {
      emit(AppGetTechnologyErrorState(
        error.toString(),
      ));
    });
  }

  List<dynamic> sports = [];

  void getSports() {
    emit(AppGetSportsLoadingState());

    DioHelper.getData(
      path: 'v2/top-headlines',
      query: {
        'country': 'us',
        'category': 'sports',
        'apiKey': '65f7f556ec76449fa7dc7c0069f040ca'
      },
    ).then((value) {
      technology = value.data['articles'];

      emit(AppGetSportsSuccessState());
    }).catchError((error) {
      emit(AppGetSportsErrorState(
        error.toString(),
      ));
    });
  }

  List<dynamic> health = [];

  void getHealth() {
    emit(AppGetHealthLoadingState());

    DioHelper.getData(
      path: 'v2/top-headlines',
      query: {
        'country': 'us',
        'category': 'health',
        'apiKey': '65f7f556ec76449fa7dc7c0069f040ca'
      },
    ).then((value) {
      technology = value.data['articles'];

      emit(AppGetHealthSuccessState());
    }).catchError((error) {
      emit(AppGetHealthErrorState(
        error.toString(),
      ));
    });
  }

  List<dynamic> search = [];

  void getSearch(String value) {
    emit(AppGetSearchLoadingState());

    DioHelper.getData(
      path: 'v2/everything',
      query: {
        'q': '$value',
        'apiKey': '65f7f556ec76449fa7dc7c0069f040ca',
      },
    ).then((value) {
      //print(value.data['articles'][0]['title']);
      search = value.data['articles'];

      emit(AppGetSearchSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(AppGetSearchErrorState(error.toString()));
    });
  }
}
