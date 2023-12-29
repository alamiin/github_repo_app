import 'package:flutter/material.dart';
import 'package:github_repo_app/app/data/models/repo.dart';
import 'package:github_repo_app/app/ui/all_repo/all_repo_screen.dart';
import 'package:github_repo_app/app/ui/details_repo/details_repo_screen.dart';



class AppRoute{
  static const String defaultRoute = "/";
  static const String detailsRepoRoute = "/detailsRepo";

  static Route onGenerateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case defaultRoute:
        return _materialRoute(const AllRepoScreen());

      case detailsRepoRoute:
        return _materialRoute(DetailsRepoScreen(repoModel: settings.arguments as RepoModel));

      default:
        return _materialRoute(const AllRepoScreen());
    }
  }

  static Route<dynamic> _materialRoute(Widget view) {
    return MaterialPageRoute(builder: (_) => view);
  }

}