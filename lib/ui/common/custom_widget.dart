
import 'package:flutter/material.dart';
import 'package:github_repo_app/helper/app_text_data.dart';
import 'package:github_repo_app/provider/repo_provider.dart';
import 'package:provider/provider.dart';

customAppBar({required BuildContext context, required String title, required bool isHome}){
  return AppBar(
    leading: !isHome ? IconButton(
      icon: const Icon(Icons.arrow_back, color: Colors.white),
      onPressed: (){
        Navigator.of(context).pop();
      },
    ): null ,
    title: Text(title, style: const TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.w700),),
    backgroundColor: Colors.blue,
    actions: isHome ? [
      PopupMenuButton<int>(
          onSelected: (items){
            switch(items){
              case 0:
                Provider.of<RepoProvider>(context, listen: false).sortByDate();
                break;
              case 1:
                Provider.of<RepoProvider>(context, listen: false).sortByStar();
                break;
            }
          },
          itemBuilder: (context) => [
            const PopupMenuItem<int>(
                value: 0,
                child: Text(AppTextData.sortByUpdate)
            ),
            const PopupMenuItem<int>(
                value: 1,
                child: Text(AppTextData.sortByStar)
            )
          ]
      )
    ]: null,
  );
}

