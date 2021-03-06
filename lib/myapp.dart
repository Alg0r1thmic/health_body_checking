import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:health_body_checking/src/constants/app_colors.dart';
import 'package:splashscreen/splashscreen.dart';
import 'src/constants/app_font_family.dart';
import 'src/models/user_model.dart';
import 'src/models/user_model.dart';
import 'src/models/user_model.dart';
import 'src/services/user_service.dart';
import 'src/ui/home/home.dart';
import 'src/ui/home/home.dart';
import 'src/ui/questions/questions_screen.dart';
import 'package:provider/provider.dart';

import 'app_localizations.dart';
import 'auth_widget_builder.dart';
import 'src/core/routes/routes.dart';
import 'src/models/user_model.dart';
import 'src/providers/auth_provider.dart';
import 'src/providers/languaje_provider.dart';
import 'src/providers/theme_provider.dart';
import 'src/ui/auth/login_screen.dart';
import 'src/ui/questions/questions_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (_, themeProviderRef, __) {
        //{context, data, child}
        return Consumer<LanguageProvider>(
          builder: (_, languageProviderRef, __) {
            return AuthWidgetBuilder(
              //databaseBuilder: databaseBuilder,
              builder: (BuildContext context, AsyncSnapshot<UserModel> userSnapshot) {
                return MaterialApp(
                  debugShowCheckedModeBanner: false,
                  locale: languageProviderRef.appLocale,
                  //List of all supported locales
                  supportedLocales: [Locale('en', 'US')],
                  //These delegates make sure that the localization data for the proper language is loaded
                  localizationsDelegates: [
                    //A class which loads the translations from JSON files
                    AppLocalizations.delegate,
                    //Built-in localization of basic text for Material widgets (means those default Material widget such as alert dialog icon text)
                    GlobalMaterialLocalizations.delegate,
                    //Built-in localization for text direction LTR/RTL
                    GlobalWidgetsLocalizations.delegate,
                  ],
                  //return a locale which will be used by the app
                  localeResolutionCallback: (locale, supportedLocales) {
                    //check if the current device locale is supported or not
                    for (var supportedLocale in supportedLocales) {
                      if (supportedLocale.languageCode == locale?.languageCode || supportedLocale.countryCode == locale?.countryCode) {
                        return supportedLocale;
                      }
                    }
                    //if the locale from the mobile device is not supported yet,
                    //user the first one from the list (in our case, that will be English)
                    return supportedLocales.first;
                  },
                  title: 'Health-Body-Checker',
                  routes: Routes.routes,
                  theme: ThemeData(
                    visualDensity: VisualDensity.adaptivePlatformDensity,
                    //primarySwatch: Colors.grey,
                    //primaryColor:  Colors.white,
                    scaffoldBackgroundColor: Colors.white,
                    brightness: Brightness.light ,
                    backgroundColor: Color(0xFF028F96) ,
                    fontFamily: AppFontFamily.POPPINS_MEDIUM,
                  ),
                  //darkTheme: AppThemes.darkTheme,
                  // themeMode: themeProviderRef.isDarkModeOn
                  //     ? ThemeMode.dark
                  //     : ThemeMode.light,
                  home: Consumer<AuthProvider>(
                    builder: (_, authProviderRef, __) {
                      if (userSnapshot.connectionState == ConnectionState.active) {
                        if (userSnapshot.hasData) {
                          String firebaseToken=CurrentUserModel.instance.firebaseKey;
                          final UserModel user = userSnapshot.data;
                          CurrentUserModel(email: user.email, id: user.uid);
                          UserService _userService = UserService();
                          _userService.userStream(id: user.uid).listen((event) {
                          });
                          return MySplashScreen();
                        } else {
                          return LoginScreen();
                        }
                        //return userSnapshot.hasData ? QuestionsScreen() : LoginScreen();
                      }
                      return Material(
                        child: Container(
                          color: Colors.red,
                        ),
                      );
                    },
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
class MySplashScreen extends StatefulWidget {
  MySplashScreen({Key key}) : super(key: key);

  @override
  _MySplashScreenState createState() => _MySplashScreenState();
}

class _MySplashScreenState extends State<MySplashScreen> {
  @override
  void initState() { 
    super.initState();
    
  }
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 3,
      navigateAfterSeconds:PrevisScreen(),
      title: new Text(
        'Welcome to HealthBodyChecking',
        style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
      ),
      image: new Image.asset('assets/images/logoApp2.png',width:400.0,height: 400.0),
      backgroundColor: Colors.white,
      photoSize: 100.0,
      loaderColor: AppColors.PRIMARY_DARK,
    );
  }
}
class PrevisScreen extends StatefulWidget {
  PrevisScreen({Key key}) : super(key: key);

  @override
  _PrevisScreenState createState() => _PrevisScreenState();
}

class _PrevisScreenState extends State<PrevisScreen> {
  @override
  Widget build(BuildContext context) {
    return CurrentUserModel.instance.custionsCompleted??false?Home():QuestionsScreen();
  }
}