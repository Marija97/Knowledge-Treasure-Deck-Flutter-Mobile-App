import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app/routing/router.dart';
import 'app/theme/theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();
  runApp(const ProviderScope(child: KnowFlowApp()));
}

class KnowFlowApp extends StatelessWidget {
  const KnowFlowApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Know Flow',
      debugShowCheckedModeBanner: false,
      routerDelegate: AppRouter.instance.routerDelegate,
      routeInformationParser: AppRouter.instance.routeInformationParser,
      routeInformationProvider: AppRouter.instance.routeInformationProvider,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      themeMode: ThemeMode.light,
      theme: AppTheme.light().data,
      darkTheme: AppTheme.dark().data,
    );
  }
}
