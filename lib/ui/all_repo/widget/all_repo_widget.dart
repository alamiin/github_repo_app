import 'package:flutter/material.dart';
import 'package:github_repo_app/config/route/app_route.dart';
import 'package:github_repo_app/data/models/repo.dart';
import 'package:github_repo_app/helper/app_text_data.dart';
import 'package:github_repo_app/helper/extension_function.dart';
import 'package:github_repo_app/provider/repo_provider.dart';
import 'package:github_repo_app/ui/common/text_style.dart';
import 'package:provider/provider.dart';

class AllRepoWidget extends StatefulWidget {
  final List<RepoModel> repoList;
  const AllRepoWidget({Key? key, required this.repoList}) : super(key: key);

  @override
  State<AllRepoWidget> createState() => _AllRepoWidgetState();
}

class _AllRepoWidgetState extends State<AllRepoWidget> {

  final controller = ScrollController();
  @override
  void initState() {
    controller.addListener(scrollListener);
    super.initState();
  }

  void scrollListener(){
    if(controller.position.pixels == controller.position.maxScrollExtent){
      Provider.of<RepoProvider>(context, listen: false).fetchScrollRepo();
    }
  }

  void _onArticlePressed(BuildContext context, RepoModel repoModel) {
    Navigator.pushNamed(context, AppRoute.detailsRepoRoute, arguments: repoModel);
  }

  Future<void> onRefresh()async{
    Provider.of<RepoProvider>(context, listen: false).fetchRepo();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        onRefresh: onRefresh,
      child: ListView.builder(
        controller: controller,
        itemCount: widget.repoList.length,
        itemBuilder: (context,  index) {
          return InkWell(
            onTap: (){
              _onArticlePressed(context, widget.repoList[index]);
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                  color: Colors.blue[100],
                  borderRadius: const BorderRadius.all(Radius.circular(8))
              ),
              child: Row(

                children: [
                  Container(
                    height: 50,
                    width: 50,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      border: Border.all(width: 2, color: Colors.blue),
                      shape: BoxShape.circle,
                    ),
                    child: Text("${index+1}"),
                  ),
                  const SizedBox(width: 10,),
                  Flexible(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("${widget.repoList[index].name}/${widget.repoList[index].repoName}",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: descriptionBold(),
                        ),

                        const SizedBox(height: 3,),
                        Text(widget.repoList[index].description ?? "",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: description(),
                        ),

                        const SizedBox(height: 3,),
                        Text("${AppTextData.updatedOn} ${widget.repoList[index].updatedAt!}",
                          style: descriptionDate(),
                        ),

                        const SizedBox(height: 3,),
                        Text( "${AppTextData.stars} ${widget.repoList[index].stars}" ?? "",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: description(),
                        ),

                      ],
                    ),
                  )

                ],
              ),
            ),
          );
        },

      ),
    );
  }
}
