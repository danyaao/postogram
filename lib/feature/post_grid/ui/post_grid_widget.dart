import 'package:flutter/material.dart';
import 'package:postogram/feature/post_grid/ui/post_grid_widget_model.dart';
import 'package:postogram/feature/post_grid/ui/widget/post_card.dart';
import 'package:postogram/uikit/widget/postogram_app_bar.dart';

class PostGridWidget extends StatefulWidget {
  const PostGridWidget({
    super.key,
    required this.wm,
  });

  final PostGridViewWidgetModel wm;

  @override
  State<PostGridWidget> createState() => _PostGridWidgetState();
}

class _PostGridWidgetState extends State<PostGridWidget> {
  @override
  void initState() {
    super.initState();

    widget.wm.init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PostogramAppBar(),
      body: _Body(wm: widget.wm),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({required this.wm});

  final IPostGridWidgetModel wm;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 16,
      ),
      child: Column(
        children: [
          Expanded(
            child: ValueListenableBuilder(
              valueListenable: wm.posts,
              builder: (_, posts, __) => posts.isEmpty
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                      ),
                      itemCount: posts.length,
                      itemBuilder: (_, index) => PostCard(
                        post: posts[index],
                        onPostOpen: () => wm.openDetails(posts[index]),
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
