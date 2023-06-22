import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/dio_helper.dart';
import '../../../data/shared_preferences_helper.dart';
import '../../view/screens/business_screen.dart';
import '../../view/screens/science_screen.dart';
import '../../view/screens/sports_screen.dart';

part 'news_state.dart';

class NewsCubit extends Cubit<NewsState> {
  NewsCubit() : super(NewsInitial());

  static NewsCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<BottomNavigationBarItem> bottomItems = [
    const BottomNavigationBarItem(
      icon: Icon(
        Icons.business,
      ),
      label: 'Business',
    ),
    const BottomNavigationBarItem(
      icon: Icon(
        Icons.sports,
      ),
      label: 'Sports',
    ),
    const BottomNavigationBarItem(
      icon: Icon(
        Icons.science,
      ),
      label: 'Science',
    ),
  ];

  List<StatelessWidget> screens = [
    const BusinessScreen(),
    const SportsScreen(),
    const ScienceScreen(),
  ];

  void changeBottomNav(int value) {
    currentIndex = value;

    if (value == 1) {
      getSports();
    }
    if (value == 2) {
      getScience();
    }
    emit(NewsBottomNavState());
  }

  List<dynamic> business = [];
  List<dynamic> sports = [];
  List<dynamic> science = [];
  List<dynamic> search = [];

  void getBusiness() {
    emit(NewsGetBusinessLoadingState());
    DioHelper.getData(
      url: 'v2/top-headlines',
      query: {
        //'country': 'eg',
        'language': 'ar',
        'category': 'business',
        'apiKey': '7963b3318b6f4b82a4569760983b2d15',
      },
    ).then((value) {
      //print(value?.data['articles'][0]['title'].toString());
      business = value?.data['articles'];
      emit(NewsGetBusinessSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(NewsGetBusinessErrorState(error.toString()));
    });
  }

  void getSports() {
    emit(NewsGetSportsLoadingState());
    if (sports.isEmpty) {
      DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          //'country': 'eg',
          'language': 'ar',
          'category': 'sports',
          'apiKey': '7963b3318b6f4b82a4569760983b2d15',
        },
      ).then((value) {
        //print(value?.data['articles'][0]['title'].toString());
        sports = value?.data['articles'];
        //print(sports[0]['title']);
        emit(NewsGetSportsSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(NewsGetSportsErrorState(error.toString()));
      });
    } else {
      emit(NewsGetSportsSuccessState());
    }
  }

  void getScience() {
    emit(NewsGetScienceLoadingState());
    if (science.isEmpty) {
      DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          //'country': 'eg',
          'language': 'ar',
          'category': 'science',
          'apiKey': '7963b3318b6f4b82a4569760983b2d15',
        },
      ).then((value) {
        //print(value?.data['articles'][0]['title'].toString());
        science = value?.data['articles'];
        //print(science[0]['title']);
        emit(NewsGetScienceSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(NewsGetScienceErrorState(error.toString()));
      });
    } else {
      emit(NewsGetScienceSuccessState());
    }
  }

  void getSearch(String value) {
    emit(NewsGetSearchLoadingState());
    search = [];
    DioHelper.getData(
      url: 'v2/everything',
      query: {
        'q': value,
        'apiKey': '7963b3318b6f4b82a4569760983b2d15',
      },
    ).then((value) {
      //print(value?.data['articles'][0]['title'].toString());
      search = value?.data['articles'];
      //print(science[0]['title']);
      emit(NewsGetSearchSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(NewsGetSearchErrorState(error.toString()));
    });
  }

  bool isDark = false;

  void changeMode({bool? fromShared}) {
    if (fromShared != null) {
      isDark = fromShared;
      emit(AppChangeModeState());
      print('from shared');
    } else {
      isDark = !isDark;
      CashHelper.putBoolean(key: 'isDark', value: isDark).then((value) {
        emit(AppChangeModeState());
      });
      print('not from shared');
    }
  }
}
