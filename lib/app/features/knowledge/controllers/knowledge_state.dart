import 'package:equatable/equatable.dart';

import '../../../data/models/factoid.dart';

class KnowledgeState extends Equatable {
  const KnowledgeState({
    required this.factoidsByCategory,
    required this.selectedCategory,
  });

  final String? selectedCategory;
  final Map<String, List<Factoid>>? factoidsByCategory;

  // Todo add rigorous checks
  List<Factoid> getSection() => factoidsByCategory![selectedCategory!]!;
  List<String> allCategories() => factoidsByCategory?.keys.toList() ?? [];

  @override
  List<Object?> get props => [selectedCategory, factoidsByCategory];

  KnowledgeState copyWith({
    Map<String, List<Factoid>>? factoidsByCategory,
    String? selectedCategory,
  }) {
    return KnowledgeState(
      factoidsByCategory: factoidsByCategory ?? this.factoidsByCategory,
      selectedCategory: selectedCategory ?? this.selectedCategory,
    );
  }
}
