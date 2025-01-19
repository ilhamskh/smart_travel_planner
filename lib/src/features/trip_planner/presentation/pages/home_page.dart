import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_travel_planner/src/features/trip_planner/presentation/widget/popular_destinations.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Smart Travel Planner'),
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SearchBar(),
            const SizedBox(height: 16),
            const Text(
              'Popular Destinations',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Expanded(child: PopularDestinations()),
            const SizedBox(height: 16),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  context.push('/trip-planner');
                },
                child: const Text('Start Planning a Trip'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}