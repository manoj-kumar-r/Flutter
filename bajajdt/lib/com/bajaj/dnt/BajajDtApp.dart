import 'package:bajajdt/com/bajaj/dnt/activation/SplashPage.dart';
import 'package:bajajdt/com/bajaj/dnt/utils/CustomColors.dart';
import 'package:flutter/material.dart';

class BajajDtApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // localizationsDelegates: [
      //   GlobalMaterialLocalizations.delegate,
      //   GlobalWidgetsLocalizations.delegate,
      //   GlobalCupertinoLocalizations.delegate,
      // ],
      // supportedLocales: [
      //   const Locale('en', ''), // English, no country code
      // ],
      title: 'Bajaj D&T',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: CustomColors.colorPrimary,
        primaryColorDark: CustomColors.colorPrimaryDark,
        accentColor: CustomColors.colorAccent,
      ),
      home: SplashPage(),
    );
  }
}
