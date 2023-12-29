import 'package:flutter/foundation.dart';

import '../core/resources/data_state.dart';
import '../data/models/repo.dart';
import '../data/usecase/get_repo.dart';



class RepoProvider with ChangeNotifier {
  final GetRepoUseCase getRepoUseCase;
  RepoProvider( {required this.getRepoUseCase});


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

    pageCounter = 1;
    final dataState = await getRepoUseCase(params: pageCounter);

    if (dataState is DataSuccess && dataState.data!.items!.isNotEmpty) {
      repoList = [];
      pageCounter++;
      repoList = dataState.data!.items!;
    }

    if (dataState is DataFailed) {
      message = dataState.error!.message!;
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
      message = dataState.error!.message!;
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