import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../data/knowledge_repository/knowledge_repository.dart';
import '../../../routing/router.dart';
import '../../../widgets/button.dart';
import '../../../widgets/text.dart';
import '../controllers/knowledge_controller.dart';
import 'widgets/category_view.dart';
import 'package:http/http.dart' as http;

class KnowledgeOverviewPage extends ConsumerWidget {
  const KnowledgeOverviewPage();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(knowledgeControllerProvider.notifier);
    final state = ref.watch(knowledgeControllerProvider);

    Future<void> updateData() async {
      controller.setDataRefreshingStatus('...');

      await dotenv.load(fileName: '.env');
      final token = dotenv.env['GITHUB_ACCESS_TOKEN'];
      final url = 'https://api.github.com/repos/Marija97/Knowledge-Treasure-Deck-Flutter-Mobile-App/contents/assets/quiz_data/german.json';

      try {
        final response = await http.get(
          Uri.parse(url),
          headers: {'Authorization': 'Bearer $token'},
        );
        final temp = jsonDecode(response.body)['content'].replaceAll('\n', '');
        final data = utf8.decode(base64Decode(temp));
        debugPrint('Success!');

        await ref.read(knowledgeRepositoryProvider).setupInitialKnowledge(data);
        controller.setDataRefreshingStatus(':)');
      } catch (e, s) {
        controller.setDataRefreshingStatus(':(');
        debugPrint('Failed to read user data. Status Code: $e');
        debugPrint(s.toString());
      }
    }

    return Scaffold(
      body: SafeArea(
        child: Padding(
          // Todo global padding
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Column(
            children: [
              const Spacer(),

              Row(children: [
                GestureDetector(
                  onLongPress: updateData,
                  child: Image.asset(
                    './assets/images/logos/owl_orange.png',
                    height: 70,
                  ),
                ),
                const SizedBox(width: 12),
                AppText.large(state.status),
              ]),

              const SizedBox(height: 12),
              TextButton(
                onPressed: controller.refreshFromRemoteDatabase,
                child: Text('Refresh From Remote Database'),
              ),
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
                            numberOfObtained:
                                controller.getObtainedCount(category),
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
                title: 'Start the quest ✨',
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
