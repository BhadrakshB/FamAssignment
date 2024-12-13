import 'package:flutter/material.dart';
import '../api/api_client.dart';
import '../api/models/screen_card.dart';
import '../widgets/card_group_widget.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<ScreenCard>> cardGroups;

  @override
  void initState() {
    super.initState();
    print('Init State');
    cardGroups = apiClient.getContextualCards(); // API call
    print('Init State Done');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contextual Cards'),
      ),
      body: FutureBuilder<List<ScreenCard>>(
        future: cardGroups,
        builder: (context, snapshot) {
          print('Snapshot: ${snapshot.data}');
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          // } else if (snapshot.hasError) {
          //   return Center(child: Text('Error: ${snapshot.error}'));
          }
          else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No Cards Available'));
          }

          final cardGroups = snapshot.data!;
          final group = cardGroups[0];
          return
              CardGroupWidget(cards: group.hcGroups);
          // return ListView.builder(
          //   itemCount: cardGroups.length,
          //   itemBuilder: (context, index) {
          //     final ScreenCard group = cardGroups[index];
          //     return ;
          //   },
          // );
        },
      ),
    );
  }
}
