import 'package:bloc_app/business_logic/cubit/characters_cubit.dart';
import 'package:bloc_app/constant/my_colors.dart';
import 'package:bloc_app/data/models/characters.dart';
import 'package:bloc_app/presentation/widgets/character_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CharactersScreen extends StatefulWidget {
  const CharactersScreen({super.key});

  @override
  State<CharactersScreen> createState() => _CharactersScreenState();
}

class _CharactersScreenState extends State<CharactersScreen> {
  late List<Character> allCharacters;
  late List<Character> searchedForCharacters;
  bool _isSearching = false;
  final _searchTextController = TextEditingController();

  List<Widget> _buildAppBarActions() {
    if (_isSearching) {
      return [
        IconButton(
          onPressed: () {
            _clearSearch();
            Navigator.pop(context);
          },
          icon: const Icon(Icons.clear, color: MyColors.dgrey),
        ),
      ];
    } else {
      return [
        IconButton(
          onPressed: _startSearch,
          icon: const Icon(Icons.search, color: MyColors.dgrey),
        ),
      ];
    }
  }

  Widget _buildAppBarTitle() {
    return const Text('Characters', style: TextStyle(color: MyColors.dgrey));
  }

  @override
  void initState() {
    super.initState();
    BlocProvider.of<CharactersCubit>(context).getAllCharacters();
  }

  Widget _buildSearchField() {
    return TextField(
      controller: _searchTextController,
      cursorColor: Colors.amber,
      decoration: const InputDecoration(
        hintText: 'Find a character...',
        border: InputBorder.none,
        hintStyle: TextStyle(color: MyColors.dgrey, fontSize: 20),
      ),
      style: const TextStyle(color: MyColors.dgrey, fontSize: 18),
      onChanged: (searchedCharacter) {
        addSearchedForItemsToSearchedList(searchedCharacter);
      },
    );
  }

  Widget buildBlocWidget() {
    return BlocBuilder<CharactersCubit, CharactersState>(
      builder: (context, state) {
        if (state is CharactersLoaded) {
          allCharacters = (state).characters;
          return buildLoadedListWidget();
        } else {
          return showLoadingIndicator();
        }
      },
    );
  }

  Widget showLoadingIndicator() {
    return const Center(
      child: CircularProgressIndicator(color: MyColors.grenne),
    );
  }

  Widget buildLoadedListWidget() {
    return SingleChildScrollView(
      child: Container(
        color: MyColors.dgrey,
        child: Column(children: [buildCharachterList()]),
      ),
    );
  }

  Widget buildCharachterList() {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 2 / 3,
        crossAxisSpacing: 1,
        mainAxisSpacing: 1,
      ),
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      itemCount: _searchTextController.text.isEmpty
          ? allCharacters.length
          : searchedForCharacters.length,
      itemBuilder: (context, index) {
        return CharacterItem(
          character: _searchTextController.text.isEmpty
              ? allCharacters[index]
              : searchedForCharacters[index],
        );
      },
    );
  }

  @override
  Widget build(context) {
    return Scaffold(
      backgroundColor: MyColors.dgrey,
      appBar: AppBar(
        title: _isSearching ? _buildSearchField() : _buildAppBarTitle(),
        actions: _buildAppBarActions(),
        backgroundColor: MyColors.grenne,
        titleTextStyle: const TextStyle(fontSize: 22),
      ),
      body: buildBlocWidget(),
    );
  }

  void addSearchedForItemsToSearchedList(String searchedCharacter) {
    searchedForCharacters = allCharacters
        .where(
          (character) =>
              character.name.toLowerCase().startsWith(searchedCharacter),
        )
        .toList();
    setState(() {});
  }

  void _startSearch() {
    ModalRoute.of(
      context,
    )!.addLocalHistoryEntry(LocalHistoryEntry(onRemove: _stopSearching));
    setState(() {
      _isSearching = true;
    });
  }

  void _stopSearching() {
    _clearSearch();
    setState(() {
      _isSearching = false;
    });
  }

  void _clearSearch() {
    setState(() {
      _searchTextController.clear();
    });
  }
}
