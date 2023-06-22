import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc_observer.dart';
import 'controller/news_cubit/news_cubit.dart';
import 'data/dio_helper.dart';
import 'data/shared_preferences_helper.dart';
import 'view/screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CashHelper.init();

  bool? isDark = CashHelper.getBoolean(key: 'isDark');
  runApp(MyApp(isDark));
}

class MyApp extends StatelessWidget {
  const MyApp(
    this.isDark, {
    super.key,
  });

  final bool? isDark;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NewsCubit()..getBusiness()..changeMode(fromShared: isDark),
      child: BlocConsumer<NewsCubit,NewsState>(
        listener: (context, state) {
        },
        builder:(context, state) =>  MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.deepOrange,
            appBarTheme: const AppBarTheme(
                titleSpacing: 20,
                systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarColor: Colors.white,
                    statusBarIconBrightness: Brightness.dark),
                backgroundColor: Colors.white,
                elevation: 0,
                titleTextStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                iconTheme: IconThemeData(color: Colors.black)),
            scaffoldBackgroundColor: Colors.white,
            bottomNavigationBarTheme: const BottomNavigationBarThemeData(
              type: BottomNavigationBarType.fixed,
              selectedItemColor: Colors.deepOrange,
              unselectedItemColor: Colors.grey,
              elevation: 20,
              backgroundColor: Colors.white,
            ),
            floatingActionButtonTheme: const FloatingActionButtonThemeData(
              backgroundColor: Colors.deepOrange,
            ),
            textTheme: const TextTheme(
              bodyLarge: TextStyle(
                  fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black),
            ),
          ),
          darkTheme: ThemeData(
            primarySwatch: Colors.deepOrange,
            appBarTheme: const AppBarTheme(
              titleSpacing: 20,
              systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: Color(0xff333739),
                statusBarIconBrightness: Brightness.light,
              ),
              backgroundColor: Color(0xff333739),
              elevation: 0,
              titleTextStyle: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              iconTheme: IconThemeData(
                color: Colors.white,
              ),
            ),
            scaffoldBackgroundColor: const Color(0xff333739),
            bottomNavigationBarTheme: const BottomNavigationBarThemeData(
              type: BottomNavigationBarType.fixed,
              selectedItemColor: Colors.deepOrange,
              unselectedItemColor: Colors.grey,
              elevation: 20,
              backgroundColor: Color(0xff333739),
            ),
            floatingActionButtonTheme: const FloatingActionButtonThemeData(
              backgroundColor: Colors.deepOrange,
            ),
            textTheme: const TextTheme(
              bodyLarge: TextStyle(
                  fontSize: 18, fontWeight: FontWeight.w600, color: Colors.white),
            ),
          ),
          themeMode:
              NewsCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
          home: const NewsLayout(),
        ),
      ),
    );
  }
}
