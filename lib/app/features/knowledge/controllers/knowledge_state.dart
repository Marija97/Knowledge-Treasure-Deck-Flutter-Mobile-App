import 'package:equatable/equatable.dart';

class KnowledgeState extends Equatable {
  const KnowledgeState(this.units);

  // Todo KnowledgeUnits as a model
  final List<String> units;

  @override
  List<Object?> get props => [];
}
