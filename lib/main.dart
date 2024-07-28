import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news/services/api_services.dart';
import 'package:news/viewmodels/home_provider.dart';
import 'package:news/viewmodels/login_provider.dart';
import 'package:news/viewmodels/signup_provider.dart';
import 'package:news/views/login_screen.dart';
import 'package:provider/provider.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final remoteConfig = await setupRemoteConfig();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SignupProvider()),
        ChangeNotifierProvider(create: (_) => LoginProvider()),
        Provider<ApiService>(
          create: (_) => ApiService(remoteConfig),
        ),
        ChangeNotifierProvider<NewsProvider>(
          create: (context) => NewsProvider(context.read<ApiService>()),
        ),

      ],

      child: MyApp(remoteConfig: remoteConfig),
    ),
  );
}

Future<RemoteConfig> setupRemoteConfig() async {
  final RemoteConfig remoteConfig = RemoteConfig.instance;
  await remoteConfig.setConfigSettings(RemoteConfigSettings(
    fetchTimeout: const Duration(seconds: 10),
    minimumFetchInterval: const Duration(hours: 1),
  ));
  await remoteConfig.setDefaults(<String, dynamic>{
    'country_code': 'IN',
  });
  await remoteConfig.fetchAndActivate();
  return remoteConfig;
}


class MyApp extends StatelessWidget {
  final RemoteConfig remoteConfig;
  const MyApp({Key? key,required this.remoteConfig}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Set the fit size (Find your UI design, look at the dimensions of the device screen and fill it in,unit in dp)
    return ScreenUtilInit(
      designSize: const Size(320, 800),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context , child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          // You can use the library anywhere in the app even in theme
          theme: ThemeData(
            primarySwatch: Colors.blue,
            textTheme: Typography.englishLike2018.apply(fontSizeFactor: 1.sp),
          ),
          home: child,
        );
      },
      child:LoginView(),
    );
  }
}
