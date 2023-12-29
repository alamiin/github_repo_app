import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../flavors/build_config.dart';
import '../flavors/env_config.dart';
import 'config/route/app_route.dart';
import 'provider/repo_provider.dart';
import 'ui/all_repo/all_repo_screen.dart';
import 'package:github_repo_app/app/di_container.dart' as di;


Future<void> runMyApp() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => di.sl<RepoProvider>()),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final EnvConfig _envConfig = BuildConfig.instance.config;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: _envConfig.appName,
        debugShowCheckedModeBanner: false,
        theme: _envConfig.theme,
        onGenerateRoute: AppRoute.onGenerateRoutes,
        home: const AllRepoScreen()
    );
  }
}