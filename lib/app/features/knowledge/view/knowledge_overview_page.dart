import 'package:ash/app/features/knowledge/view/widgets/factoid_view.dart';
import 'package:ash/app/routing/router.dart';
import 'package:ash/app/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../theme/colors.dart';
import '../../../widgets/text.dart';
import '../controllers/knowledge_controller.dart';

class KnowledgeOverviewPage extends ConsumerWidget {
  const KnowledgeOverviewPage();

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
              const Spacer(),
              AppText.large('Looking into the knowledge treasure...'),
              const SizedBox(height: 12),
              Expanded(
                flex: 8,
                child: state.when(
                  data: (knowledge) => ListView(
                    children: knowledge.units.map(FactoidView.new).toList(),
                  ),
                  error: (error, _) => Text(error.toString()),
                  loading: () => Center(
                    child: CircularProgressIndicator.adaptive(
                      backgroundColor: AppColors.primaryLight,
                    ),
                  ),
                ),
              ),
              AppButton(title: '🌟 Expand the knowledge treasure 🌟'),
              AppButton(
                title: 'Start the quest',
                onTap: () => GoRouter.of(context).push(RoutePaths.quiz),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
