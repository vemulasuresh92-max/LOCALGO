import 'package:flutter/material.dart';

void main() => runApp(const LocalGoApp());

class LocalGoApp extends StatelessWidget {
  const LocalGoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'LOCALGO',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: const Color(0xFF155EEF)),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int index = 0;
  final categories = const [
    'Mobile & Electronics','Clothing','Furniture','Hardware','Cosmetics',
    'Stationery','Building Materials','Automobile','Gift Shops','Repair Shops',
  ];

  @override
  Widget build(BuildContext context) {
    final pages = [
      _home(context),
      const Center(child: Text('Explore', style: TextStyle(fontSize: 24))),
      const Center(child: Text('Bookings', style: TextStyle(fontSize: 24))),
      const Center(child: Text('Saved', style: TextStyle(fontSize: 24))),
      const Center(child: Text('Profile', style: TextStyle(fontSize: 24))),
    ];
    return Scaffold(
      body: SafeArea(child: pages[index]),
      bottomNavigationBar: NavigationBar(
        selectedIndex: index,
        onDestinationSelected: (i) => setState(() => index = i),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.explore_outlined), selectedIcon: Icon(Icons.explore), label: 'Explore'),
          NavigationDestination(icon: Icon(Icons.calendar_month_outlined), selectedIcon: Icon(Icons.calendar_month), label: 'Bookings'),
          NavigationDestination(icon: Icon(Icons.bookmark_border), selectedIcon: Icon(Icons.bookmark), label: 'Saved'),
          NavigationDestination(icon: Icon(Icons.person_outline), selectedIcon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }

  Widget _home(BuildContext context) => ListView(
    padding: const EdgeInsets.fromLTRB(18, 18, 18, 24),
    children: [
      const Text('LOCALGO', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
      const SizedBox(height: 4),
      const Text('Find Local. Book Local. Grow Local.'),
      const SizedBox(height: 20),
      TextField(decoration: InputDecoration(hintText: 'Search businesses or services', prefixIcon: const Icon(Icons.search), border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)))),
      const SizedBox(height: 18),
      Row(children: [
        Expanded(child: _actionCard(context, Icons.storefront, 'Find Businesses')),
        const SizedBox(width: 12),
        Expanded(child: _actionCard(context, Icons.handyman, 'Book Services')),
      ]),
      const SizedBox(height: 24),
      const Text('Categories', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
      const SizedBox(height: 12),
      Wrap(spacing: 8, runSpacing: 8, children: categories.map((c) => Chip(label: Text(c))).toList()),
      const SizedBox(height: 26),
      const Text('Nearby Businesses', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
      const SizedBox(height: 10),
      Card(child: ListTile(leading: const CircleAvatar(child: Icon(Icons.store)), title: const Text('Local Business'), subtitle: const Text('Tap to explore businesses and services'), trailing: const Icon(Icons.chevron_right))),
    ],
  );

  Widget _actionCard(BuildContext context, IconData icon, String title) => Card(
    child: InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: () => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$title coming next'))),
      child: Padding(padding: const EdgeInsets.all(16), child: Column(children: [Icon(icon, size: 32), const SizedBox(height: 8), Text(title, textAlign: TextAlign.center, style: const TextStyle(fontWeight: FontWeight.bold))])),
    ),
  );
}
