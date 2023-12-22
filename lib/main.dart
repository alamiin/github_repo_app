import 'package:flutter/material.dart';
import 'package:github_repo_app/provider/repo_provider.dart';
import 'package:github_repo_app/ui/all_repo/all_repo_screen.dart';
import 'package:provider/provider.dart';
import 'config/route/app_route.dart';
import 'config/theme/light_theme.dart';
import 'package:github_repo_app/di_container.dart' as di;

import 'helper/app_text_data.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => di.sl<RepoProvider>()),
    ],
    child: const MyApp(),
  )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: AppTextData.appName,
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        onGenerateRoute: AppRoute.onGenerateRoutes,
        home: const AllRepoScreen()
    );
  }
}


