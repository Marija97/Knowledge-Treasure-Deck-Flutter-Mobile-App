import 'package:equatable/equatable.dart';

import '../../../data/models/factoid.dart';

class KnowledgeState extends Equatable {
  const KnowledgeState(this.units);

  final List<Factoid> units;

  @override
  List<Object?> get props => [];
}
