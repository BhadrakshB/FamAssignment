import 'package:fam_assignment/utils/storage_utils.dart';
import 'package:flutter/material.dart';
import '../api/api_client.dart';
import '../api/models/screen_card.dart';
import '../widgets/contextual_card_container.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<ScreenCard>> cardGroups;

  @override
  void initState() {
    super.initState();
    cardGroups = apiClient.getContextualCards(); // API call
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text('Contextual Cards'),
        actions: [
          TextButton(
            onPressed: () {
              StorageUtil.removeAllDismissCard();
            },
            child: const Text("Refresh Dismiss Storage"), // This button is to text the dismiss feature. Will not be included during production
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          cardGroups = apiClient.getContextualCards();
        },
        child: FutureBuilder<List<ScreenCard>>(
          future: cardGroups,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
              // } else if (snapshot.hasError) {
              //   return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No Cards Available'));
            }

            final cardGroups = snapshot.data!;
            final group = cardGroups[0];
            return ContextualCardContainer(cards: group.hcGroups);
          },
        ),
      ),
    );
  }
}
