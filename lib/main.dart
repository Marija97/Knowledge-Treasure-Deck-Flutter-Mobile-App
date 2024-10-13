import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app/routing/router.dart';
import 'app/theme/theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(child: KnowFlowApp()));
}

class KnowFlowApp extends StatelessWidget {
  const KnowFlowApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'KnowFlow',
      debugShowCheckedModeBanner: false,
      routerDelegate: AppRouter.instance.routerDelegate,
      routeInformationParser: AppRouter.instance.routeInformationParser,
      routeInformationProvider: AppRouter.instance.routeInformationProvider,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: AppTheme.dark().data,
    );
  }
}
