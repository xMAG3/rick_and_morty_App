import 'package:bloc_app/constant/strings.dart';
import 'package:bloc_app/presentation/screens/characters_screen.dart';
import 'package:flutter/material.dart';

class AppRouter {
  Route? generateRoute(RouteSettings settings){
    switch(settings.name){
      case charactersScreen:
        return MaterialPageRoute(builder: (_)=> CharactersScreen());
      case characterDetailsScreen:
        return MaterialPageRoute(builder: (_)=> CharactersScreen()); 
    }
  }
}