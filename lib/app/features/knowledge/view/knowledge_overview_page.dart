import 'package:ash/app/features/knowledge/view/widgets/category_view.dart';
import 'package:ash/app/routing/router.dart';
import 'package:ash/app/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

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
                child: ListView(
                  children: controller
                      .allCategories()
                      .map((category) => CategoryView(
                            category,
                            isSelected: state.selectedCategory == category,
                            onTap: () => controller.selectCategory(category),
                            total: controller.getTotalCount(category),
                            numberOfObtained: controller.getObtainedCount(category),
                          ))
                      .toList(),
                ),
              ),
              // const Spacer(),
              // AppButton(
              //   title: '📝 Test filling the database',
              //   onTap: controller.databaseFillUpTest,
              // ),
              // const SizedBox(height: 12),
              // AppButton(
              //   title: '📖 Test reading the database',
              //   onTap: controller.readDatabaseTest,
              // ),
              // const SizedBox(height: 12),
              // AppButton(
              //   title: '🗑️ Test clearing the database',
              //   onTap: controller.clearDatabaseTest,
              // ),
              // const SizedBox(height: 12),
              // AppButton(title: '🌟 Expand the knowledge treasure 🌟'),
              const SizedBox(height: 12),
              AppButton(
                title: 'Start the quest',
                onTap: state.selectedCategory != null
                    ? () => GoRouter.of(context).push(
                          RoutePaths.quiz,
                          extra: state.selectedCategory,
                        )
                    : null,
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
