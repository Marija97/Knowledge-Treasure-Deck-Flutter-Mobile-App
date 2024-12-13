import 'package:equatable/equatable.dart';

class KnowledgeState extends Equatable {
  const KnowledgeState({
    required this.selectedCategory,
    this.status = ':)',
  });

  final String? selectedCategory;
  final String status;

  @override
  List<Object?> get props => [selectedCategory];

  KnowledgeState copyWith({
    String? selectedCategory,
    String? status,
  }) {
    return KnowledgeState(
      selectedCategory: selectedCategory ?? this.selectedCategory,
      status: status ?? this.status,
    );
  }
}
