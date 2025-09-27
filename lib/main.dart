import 'package:bloc_app/app_router.dart';
import 'package:flutter/material.dart';

void main() {
  runApp( RickMortyApp(appRouter: AppRouter(),));
}

class RickMortyApp extends StatelessWidget {
   const RickMortyApp({super.key, required this.appRouter});

  final AppRouter appRouter;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: appRouter.generateRoute,
    );
  }
}