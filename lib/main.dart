import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'core/config/application_theme_manager.dart';
import 'core/services/loading_service.dart';
import 'feature/edit/pages/edit_view.dart';
import 'feature/layout_view.dart';
import 'feature/login/page/login_view.dart';
import 'feature/register/page/register_view.dart';
import 'feature/settings_provider.dart';
import 'feature/splash/page/splash_view.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'models/task_model.dart';

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
void main()async {
  // to ensure ay haga await gowa main at3mlha initialize abl run
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    ChangeNotifierProvider(
      create: (context) => SettingsProvider(),
      child: const MyApp(),
    ),
  );
  configLoading();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var vm = Provider.of<SettingsProvider>(context);
    final TaskModel taskModel;
    return MaterialApp(
      title: 'TODO App',
      debugShowCheckedModeBanner: false,
      theme: ApplicationThemeManager.lightThemeData,
      darkTheme: ApplicationThemeManager.darkThemeData,
      themeMode: vm.currentThemeMode,
      locale: Locale(vm.currentlanguage),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      initialRoute: SplashView.routeName,
      navigatorKey: navigatorKey,
      routes: {
        SplashView.routeName: (context) => const SplashView(),
        LoginView.routeName: (context) =>  LoginView(),
        RegisterView.routeName: (context) =>  RegisterView(),
        LayoutView.routeName: (context) =>  const LayoutView(),
        EditView.routeName: (context) =>   EditView(taskModel: taskModel,),

      },
      navigatorObservers: [BotToastNavigatorObserver()],
      builder: EasyLoading.init(builder: BotToastInit()),
    );
  }
}

