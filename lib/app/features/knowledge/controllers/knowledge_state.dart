import 'package:equatable/equatable.dart';

class KnowledgeState extends Equatable {
  const KnowledgeState({
    required this.selectedCategory,
  });

  final String? selectedCategory;

  @override
  List<Object?> get props => [selectedCategory];

  KnowledgeState copyWith({
    String? selectedCategory,
  }) {
    return KnowledgeState(
      selectedCategory: selectedCategory ?? this.selectedCategory,
    );
  }
}
