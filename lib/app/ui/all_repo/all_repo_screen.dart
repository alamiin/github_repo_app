import 'package:flutter/material.dart';
import 'package:github_repo_app/app/helper/app_text_data.dart';
import 'package:github_repo_app/app/provider/repo_provider.dart';
import 'package:github_repo_app/app/ui/all_repo/widget/all_repo_widget.dart';
import 'package:github_repo_app/app/ui/common/custom_widget.dart';
import 'package:github_repo_app/app/ui/common/loader.dart';
import 'package:github_repo_app/app/ui/common/text_style.dart';
import 'package:github_repo_app/flavors/build_config.dart';
import 'package:provider/provider.dart';

class AllRepoScreen extends StatefulWidget {
  const AllRepoScreen({Key? key}) : super(key: key);

  @override
  State<AllRepoScreen> createState() => _AllRepoScreenState();
}

class _AllRepoScreenState extends State<AllRepoScreen> {

  static final String appName = BuildConfig.instance.config.appName;


  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<RepoProvider>(context, listen: false).fetchRepo();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
          context: context, title: appName, isHome: true),
      body: SafeArea(child: Consumer<RepoProvider>(
        builder: (context, provider, child) {
          return Column(
            children: [
              Expanded(
                  child: provider.isLoading
                      ? const Center(
                          child: Loader(),
                        )
                      : provider.repoList.isNotEmpty
                          ? AllRepoWidget(repoList: provider.repoList)
                          : Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    AppTextData.noInternetConnection,
                                    style: descriptionBold(),
                                    textAlign: TextAlign.center,
                                  ),
                                  ElevatedButton(
                                      onPressed: () {
                                        Provider.of<RepoProvider>(context,
                                                listen: false)
                                            .fetchRepo();
                                      },
                                      child: Text(
                                        AppTextData.reload,
                                        style: descriptionWhite(),
                                      ))
                                ],
                              ),
                            )),
              provider.isBottomLoading
                  ? Container(
                      height: 50,
                      width: double.infinity,
                      alignment: Alignment.center,
                      child: const Loader(),
                    )
                  : const SizedBox()
            ],
          );
        },
      )),
    );
  }
}
