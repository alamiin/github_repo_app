import 'package:flutter/material.dart';
import 'package:github_repo_app/app/features/search_repo/data/model/repo.dart';
import 'package:github_repo_app/app/features/search_repo/presentation/widget/text_style.dart';
import 'package:github_repo_app/app/core/constants/app_text_data.dart';
import 'package:github_repo_app/app/features/search_repo/presentation/widget/circular_image.dart';
import 'package:github_repo_app/app/features/search_repo/presentation/widget/custom_widget.dart';


class DetailsRepoScreen extends StatelessWidget {
  final RepoModel repoModel;
  const DetailsRepoScreen({Key? key, required this.repoModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double imageSize = width * 0.5;
    double topSpace = imageSize * 0.25;
    double bottomSpace = topSpace * 0.5;
    return Scaffold(
      appBar: customAppBar(
          context: context,
          title: repoModel.repoName ?? AppTextData.details,
          isHome: false
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [

                SizedBox(height: topSpace,),

                CircularImage(
                  imageUrl: repoModel.avatarUrl ?? "",
                  size: imageSize,
                  borderColor: Colors.blue,
                ),

                SizedBox(height: bottomSpace,),

                Text(repoModel.name ?? "", style: largeBold(),),
                const SizedBox(height: 10,),
                Container(
                  width: width,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                    border: Border.all(color: Colors.grey, width: 2)
                  ),
                  child: Text(repoModel.description ?? "", style: description()),
                ),
                const SizedBox(height: 10,),
                Container(
                  width: width,
                  alignment: Alignment.centerLeft,
                  child: Text("${AppTextData.lastUpdate} ${repoModel.updatedAt}",
                      style: description()),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
