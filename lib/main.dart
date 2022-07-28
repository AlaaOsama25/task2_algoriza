import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/util/cubit/bloc_obserever.dart';
import 'core/util/cubit/cubit.dart';
import 'features/board_screen/presentation/pages/board_screen.dart';

void main() {
  BlocOverrides.runZoned(
        () =>   runApp(const MyApp()),
    blocObserver: AppBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context) => AppCubit()..CreateDataBase(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          timePickerTheme: TimePickerThemeData(

          ),
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.white,
              systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: Colors.transparent,
                statusBarIconBrightness: Brightness.dark
              ),
              elevation: 0.0,
            toolbarHeight: 80,
            titleTextStyle: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black
            ),
            actionsIconTheme: IconThemeData(
              color: Colors.black

            )
          ),
          textTheme: TextTheme(
            titleMedium: TextStyle(
              color: Colors.black
            )
          ),

          primarySwatch: Colors.green,
        ),
        home: const BoardScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
