import 'package:flutter/foundation.dart';
import 'package:github_repo_app/core/resources/data_state.dart';
import 'package:github_repo_app/data/models/base/repo.dart';
import 'package:github_repo_app/data/models/repo.dart';
import 'package:github_repo_app/data/usecase/get_local_repo.dart';
import 'package:github_repo_app/data/usecase/get_repo.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';


class RepoProvider with ChangeNotifier {
  final GetRepoUseCase getRepoUseCase;
  final GetSavedRepoUseCase getSavedRepoUseCase;
  RepoProvider( {required this.getRepoUseCase, required this.getSavedRepoUseCase});


  bool isLoading = false;
  bool isBottomLoading = false;
  List<RepoModel> repoList = [];
  String message = "";
  int pageCounter = 1;
  void fetchRepo() async {

    if(isBottomLoading){
      return;
    }

    updateLoader(true);

    bool hasInternet = await InternetConnectionChecker().hasConnection;
    if(hasInternet == false){
      final savedDataState = await getSavedRepoUseCase();
      if ( savedDataState.isNotEmpty) {
        repoList = savedDataState ;
      }
      updateLoader(false);
      return;
    }

    pageCounter = 1;
    final dataState = await getRepoUseCase(params: pageCounter);

    if (dataState is DataSuccess && dataState.data!.items!.isNotEmpty) {
      repoList = [];
      pageCounter++;
      repoList = dataState.data!.items!;
    }

    if (dataState is DataFailed) {
      message = dataState.error!.message;
    }

    updateLoader(false);
  }

  void updateLoader(bool state){
    isLoading = state;
    notifyListeners();
  }

  void fetchScrollRepo() async {

    if(isLoading){
      return;
    }

    if(isBottomLoading){
      return;
    }

    updateBottomLoader(true);

    final dataState = await getRepoUseCase(params: pageCounter);

    if (dataState is DataSuccess && dataState.data!.items!.isNotEmpty) {
      if(pageCounter == 1){
        repoList = [];
      }
      pageCounter++;
      repoList.addAll(dataState.data!.items!);
    }

    if (dataState is DataFailed) {
      message = dataState.error!.message;
    }

    updateBottomLoader(false);
  }

  void updateBottomLoader(bool state){
    isBottomLoading = state;
    notifyListeners();
  }

  void sortByDate(){
    repoList.sort((a,b) {
      return b.updatedAt!.compareTo(a.updatedAt!);
    });
    notifyListeners();
  }

  void sortByStar(){
    repoList.sort((a,b) {
      return b.stars!.compareTo(a.stars!);
    });
    notifyListeners();
  }


}