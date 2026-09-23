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
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final searchController = TextEditingController();
  static const categories = [
    'Mobile & Electronics', 'Clothing', 'Furniture', 'Hardware',
    'Automobile', 'Repair', 'Building Materials', 'Photography',
  ];

  void openSearch() {
    final query = searchController.text.trim();
    Navigator.push(context, MaterialPageRoute(builder: (_) => ResultsPage(
      title: query.isEmpty ? 'Search Businesses & Services' : 'Search: $query',
      query: query,
    )));
  }

  void openCategory(String category) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => ResultsPage(
      title: category,
      query: category,
    )));
  }

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
          const Text('Find Local. Book Local. Grow Local.', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          TextField(
            controller: searchController,
            textInputAction: TextInputAction.search,
            onSubmitted: (_) => openSearch(),
            decoration: InputDecoration(
              hintText: 'Search businesses or services',
              prefixIcon: const Icon(Icons.search),
              suffixIcon: IconButton(icon: const Icon(Icons.arrow_forward), onPressed: openSearch),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
            ),
          ),
          const SizedBox(height: 20),
          Row(children: [
            Expanded(child: _actionCard(Icons.storefront, 'FIND BUSINESSES', () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ResultsPage(title: 'Businesses', query: 'Businesses'))))),
            const SizedBox(width: 12),
            Expanded(child: _actionCard(Icons.handyman, 'BOOK SERVICES', () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ResultsPage(title: 'Services', query: 'Services'))))),
          ]),
          const SizedBox(height: 24),
          const Text('Categories', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          ...categories.map((c) => Card(
            child: ListTile(
              onTap: () => openCategory(c),
              leading: const Icon(Icons.location_city),
              title: Text(c),
              trailing: const Icon(Icons.chevron_right),
            ),
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

  Widget _actionCard(IconData icon, String label, VoidCallback onTap) => Card(
    child: InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 18),
        child: Column(children: [Icon(icon, size: 32), const SizedBox(height: 8), Text(label, textAlign: TextAlign.center, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12))]),
      ),
    ),
  );
}

class ResultsPage extends StatelessWidget {
  final String title;
  final String query;
  const ResultsPage({super.key, required this.title, required this.query});

  @override
  Widget build(BuildContext context) {
    final items = [
      'Local Business 1', 'Local Business 2', 'Service Provider 1', 'Service Provider 2'
    ];
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(query.isEmpty ? 'All local results' : 'Results for "$query"', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          ...items.map((item) => Card(
            child: ListTile(
              onTap: () {},
              leading: const CircleAvatar(child: Icon(Icons.storefront)),
              title: Text(item),
              subtitle: const Text('Local business • View details'),
              trailing: const Icon(Icons.chevron_right),
            ),
          )),
        ],
      ),
    );
  }
}
