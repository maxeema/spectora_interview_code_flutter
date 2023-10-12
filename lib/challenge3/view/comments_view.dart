import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:spectora_interview_code_flutter/challenge3/providers/viewmodel_providers.dart';

class CommentsView extends HookConsumerWidget {
  // static const numberTextKey = Key('random-generated-number-text');

  const CommentsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(ViewModelProviders.commentsViewModel);
    // NOTE: This is just a hook so we can call the init method only once and not
    // every time the widget is rebuilt.
    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        viewModel.init();
      });
      return viewModel.dispose;
    }, [viewModel]);

    final scrollController = useScrollController();
    final isMounted = useIsMounted();

    final comments = ref.watch(viewModel.valueProvider);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          viewModel
              .loadRandom()
              // Scroll to the bottom of the ListView where was added new comment.
              // Do some delay before scrolling to ensure that the ListView
              // already has new comment and updated bounds.
              .then((comment) => Future.delayed(
                  const Duration(milliseconds: 100), () => comment))
              .then((comment) {
            if (isMounted()) {
              scrollController.animateTo(
                  scrollController.position.maxScrollExtent,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.bounceIn);
            }
          });
        },
        child: const Icon(Icons.add),
      ),
      body: comments.isEmpty
          ? const Center(child: Text('Tap the FAB to add a comment'))
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView.builder(
                controller: scrollController,
                itemCount: comments.length,
                itemBuilder: (context, idx) {
                  final comment = comments[idx];
                  return Card(
                    key: Key('comment-${comment.id}'),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        leading: Text(
                          '${comment.value}',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                        title: Text(
                          comment.name,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                        subtitle: Text(comment.description),
                      ),
                    ),
                  );
                },
              ),
            ),
    );
  }
}
