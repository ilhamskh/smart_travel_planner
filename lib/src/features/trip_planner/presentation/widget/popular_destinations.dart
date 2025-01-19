import 'package:flutter/material.dart';

class PopularDestinations extends StatelessWidget {
  const PopularDestinations({super.key});

  @override
  Widget build(BuildContext context) {
    // Replace with actual data fetching and display logic
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) {
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 8.0),
          child: ListTile(
            leading: Icon(Icons.place, color: Theme.of(context).primaryColor),
            title: Text('Destination ${index + 1}'),
            subtitle: Text('Description of destination ${index + 1}'),
            trailing: Icon(Icons.arrow_forward, color: Theme.of(context).primaryColor),
            onTap: () {
              // Handle destination tap
            },
          ),
        );
      },
    );
  }
}