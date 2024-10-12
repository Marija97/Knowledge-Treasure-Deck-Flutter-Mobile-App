import 'package:ash/app/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controllers/knowledge_controller.dart';

class KnowledgeOverviewPage extends ConsumerWidget {
  const KnowledgeOverviewPage();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final knowledgeController = ref.read(knowledgeControllerProvider.notifier);
    final knowledgeState = ref.watch(knowledgeControllerProvider);

    return Scaffold(
      body: Column(
        children: [
          Text('Looking into the knowledge treasure...'),
          const Spacer(),
          AppButton(title: 'Start the quest...'),
        ],
      ),
    );
  }
}
