# FamPay Flutter Assignment

This repository contains the implementation of the FamPay Flutter assignment, which involves creating a standalone container that displays a list of dynamic **Contextual Cards** based on an API response.

## Table of Contents

- [Project Overview](#project-overview)
- [Features](#features)
- [Installation](#installation)
- [Usage](#usage)
- [API Details](#api-details)
- [Design Specifications](#design-specifications)
- [Code Structure](#code-structure)
- [License](#license)
- [Demo](#demo)

## Project Overview

The goal of this assignment was to develop a plug-and-play component that can be integrated into any screen or widget in a Flutter application. The component fetches data from a provided API and renders contextual cards dynamically, allowing for various properties such as images, colors, texts, and buttons to be modified from the backend.

## Features

- **Dynamic Rendering**: Displays contextual cards based on API responses.
- **Deeplink Handling**: All deeplinks (card, CTAs, formatted text entities) are managed effectively.
- **Long Press Actions**: Big display cards can be long-pressed to reveal action buttons.
  - "Remind Later" removes the card from display but shows it on the next app start.
  - "Dismiss Now" permanently removes the card.
- **Swipe to Refresh**: Implemented swipe down to refresh functionality.
- **Loading and Error States**: Proper handling of loading and error states during API calls.
- **Reusable Components**: Code is structured with flexible and reusable components.

## Installation

To run this project locally, follow these steps:

1. Clone the repository:
   ```
   git clone https://github.com/BhadrakshB/FamAssignment.git
   ```

2. Navigate into the project directory:
   ```
   cd FamAssignment
   ```

3. Install dependencies:
   ```
   flutter pub get
   ```

4. Run the application:
   ```
   flutter run
   ```

## Usage

Once the application is running, you will see a list of contextual cards rendered from the API. You can interact with these cards by long pressing them to access additional actions or refreshing the list by swiping down.

### Example Code Snippet

Here’s an example of how to use the `ContextualCardContainer` in your Flutter application:

```
import 'package:fam_assignment/utils/storage_utils.dart';
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

```

## API Details

The application fetches data from the following API endpoint:

```
https://polyjuice.kong.fampay.co/mock/famapp/feed/home_section/?slugs=famx-paypage
```

The API provides a list of **Card Group** objects that contain various card properties as defined in the assignment instructions.

## Design Specifications

The design for different card types is referenced from Figma. The design specifications can be found here:

[Design Specifications on Figma](https://www.figma.com/file/AvK2BRGwMTv4kQab5ymJ0K/AAL3-Android-assignment-Design-Specs)

## Code Structure

The project is organized into several key files:

- `lib/main.dart`: Entry point for the Flutter application.
- `lib/contextual_card_container.dart`: Contains the main widget for rendering contextual cards.
- `lib/models/card_model.dart`: Defines data models for parsing API responses.
- `lib/services/api_client.dart`: Handles API calls and data fetching.

## Demo


https://github.com/user-attachments/assets/dea737f3-60bb-48dd-ab3c-646a6c50c22c


  
Each file contains comments explaining its purpose and functionality.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
