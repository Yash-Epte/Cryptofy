import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Favourites extends ConsumerStatefulWidget {
  const Favourites({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _FavouritesState();
}

class _FavouritesState extends ConsumerState<Favourites> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Favourites screen"),
      ),
    );
  }
}