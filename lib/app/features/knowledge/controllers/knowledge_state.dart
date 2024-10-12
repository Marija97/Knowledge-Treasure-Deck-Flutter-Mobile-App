import 'package:ash/app/features/models/factoid.dart';
import 'package:equatable/equatable.dart';

class KnowledgeState extends Equatable {
  const KnowledgeState(this.units);

  final List<Factoid> units;

  @override
  List<Object?> get props => [];
}
