import 'package:equatable/equatable.dart';

import '../../../models/factoid.dart';

class KnowledgeState extends Equatable {
  const KnowledgeState(this.units);

  final List<Factoid> units;

  @override
  List<Object?> get props => [];
}
