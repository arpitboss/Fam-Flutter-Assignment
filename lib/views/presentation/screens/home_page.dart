import 'package:flutter/material.dart';

import '../../../models/card_group_model.dart';
import '../../../models/services/api_service.dart';
import '../widgets/card_group_widget.dart';

class FamScreen extends StatefulWidget {
  const FamScreen({super.key});

  @override
  _FamScreenState createState() => _FamScreenState();
}

class _FamScreenState extends State<FamScreen> {
  final ApiService _apiService = ApiService();
  late Future<List<CardGroup>> _cardGroupsFuture;

  @override
  void initState() {
    super.initState();
    _loadCardGroups(); // by calling this function we will load card groups when the screen initializes
  }

  // function to fetch card groups from the API
  void _loadCardGroups() {
    _cardGroupsFuture = _apiService.fetchCardGroups();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        setState(() {
          _loadCardGroups(); // it will refresh the card groups when pulled down
        });
      },
      child: FutureBuilder<List<CardGroup>>(
        future: _cardGroupsFuture,
        builder: (context, snapshot) {
          // while the data is loading, it will show a loading spinner
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          // it will show error message if there was an issue fetching the data
          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }

          // if no data is found, then it will show a message
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text('No cards available'),
            );
          }

          // it will display the list of card groups when data is ready
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              return CardGroupWidget(
                cardGroup: snapshot.data![
                    index], // it will pass the card group data to the widget
              );
            },
          );
        },
      ),
    );
  }
}
