import 'package:ash/app/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../theme/colors.dart';
import '../controllers/knowledge_controller.dart';

class KnowledgeOverviewPage extends ConsumerWidget {
  const KnowledgeOverviewPage();

  Widget knowledgeUnitAsView(String unit) {
    return Text(unit);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(knowledgeControllerProvider.notifier);
    final state = ref.watch(knowledgeControllerProvider);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          // Todo global padding
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Column(
            children: [
              Text('Looking into the knowledge treasure...'),
              Expanded(
                child: state.when(
                  data: (knowledge) => ListView(
                    children: knowledge.units.map(knowledgeUnitAsView).toList(),
                  ),
                  error: (error, _) => Text(error.toString()),
                  loading: () => Center(
                    child: CircularProgressIndicator.adaptive(
                      backgroundColor: AppColors.primaryLight,
                    ),
                  ),
                ),
              ),
              AppButton(title: 'Start the quest...'),
            ],
          ),
        ),
      ),
    );
  }
}
