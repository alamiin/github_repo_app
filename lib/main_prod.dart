import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/flavors/build_config.dart';
import '/flavors/env_config.dart';
import '/flavors/environment.dart';
import 'package:github_repo_app/app/di_container.dart' as di;

import 'app/config/theme/light_theme.dart';
import 'app/my_app.dart';
import 'app/provider/repo_provider.dart';

Future<void> main() async {

  EnvConfig devConfig = EnvConfig(
    appName: "Github Repo App",
    baseUrl: "https://api.github.com",
    theme: lightTheme,
    shouldCollectCrashLog: true,
  );

  BuildConfig.instantiate(
    envType: Environment.PRODUCTION,
    envConfig: devConfig,
  );

  runMyApp();

}
