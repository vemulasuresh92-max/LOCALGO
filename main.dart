import 'package:flutter/material.dart';

void main() => runApp(const LocalGoApp());

class LocalGoApp extends StatelessWidget {
  const LocalGoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'LOCALGO',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: const Color(0xFF155EEF),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static const categories = [
    'Mobile & Electronics', 'Clothing', 'Furniture', 'Hardware',
    'Automobile', 'Repair', 'Building Materials', 'Photography',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('LOCALGO', style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.notifications_none))],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text('Find Local. Book Local. Grow Local.',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          TextField(
            decoration: InputDecoration(
              hintText: 'Search businesses or services',
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
            ),
          ),
          const SizedBox(height: 20),
          Row(children: [
            Expanded(child: _actionCard(Icons.storefront, 'FIND BUSINESSES')),
            const SizedBox(width: 12),
            Expanded(child: _actionCard(Icons.handyman, 'BOOK SERVICES')),
          ]),
          const SizedBox(height: 24),
          const Text('Categories', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          ...categories.map((c) => Card(
            child: ListTile(leading: const Icon(Icons.location_city), title: Text(c), trailing: const Icon(Icons.chevron_right)),
          )),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: 0,
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.explore_outlined), label: 'Explore'),
          NavigationDestination(icon: Icon(Icons.calendar_month_outlined), label: 'Bookings'),
          NavigationDestination(icon: Icon(Icons.bookmark_border), label: 'Saved'),
          NavigationDestination(icon: Icon(Icons.person_outline), label: 'Profile'),
        ],
      ),
    );
  }

  Widget _actionCard(IconData icon, String label) => Card(
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 18),
      child: Column(children: [Icon(icon, size: 32), const SizedBox(height: 8), Text(label, textAlign: TextAlign.center, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12))]),
    ),
  );
}
