import 'package:flutter/material.dart';

void main() => runApp(const LocalGoApp());

class LocalGoApp extends StatelessWidget {
  const LocalGoApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'LOCALGO',
        theme: ThemeData(useMaterial3: true, colorSchemeSeed: const Color(0xFF155EEF)),
        home: const HomePage(),
      );
}

class LocalBusiness {
  final String name, category, city;
  const LocalBusiness(this.name, this.category, this.city);
}

const businesses = <LocalBusiness>[
  LocalBusiness('Sri Lakshmi Mobiles', 'Mobile & Electronics', 'Tirupati'),
  LocalBusiness('Fashion Point', 'Clothing', 'Tirupati'),
  LocalBusiness('City Furniture House', 'Furniture', 'Tirupati'),
  LocalBusiness('Venkateswara Hardware', 'Hardware', 'Tirupati'),
  LocalBusiness('Tirupati Auto Care', 'Automobile', 'Tirupati'),
  LocalBusiness('Quick Fix Services', 'Repair', 'Tirupati'),
  LocalBusiness('Sri Balaji Builders Mart', 'Building Materials', 'Tirupati'),
  LocalBusiness('Lens Studio Tirupati', 'Photography', 'Tirupati'),
];

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final search = TextEditingController();
  int nav = 0;
  static const categories = [
    'Mobile & Electronics','Clothing','Furniture','Hardware','Automobile','Repair','Building Materials','Photography'
  ];

  void openSearch([String? value]) {
    final q = (value ?? search.text).trim();
    Navigator.push(context, MaterialPageRoute(builder: (_) => ResultsPage(query: q, category: null)));
  }

  void openCategory(String category) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => ResultsPage(query: '', category: category)));
  }

  @override void dispose() { search.dispose(); super.dispose(); }

  @override Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('LOCALGO', style: TextStyle(fontWeight: FontWeight.bold)), actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.notifications_none))]),
      body: ListView(padding: const EdgeInsets.all(16), children: [
        const Text('Find Local. Book Local. Grow Local.', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        TextField(
          controller: search,
          textInputAction: TextInputAction.search,
          onSubmitted: openSearch,
          decoration: InputDecoration(hintText: 'Search businesses or services', prefixIcon: const Icon(Icons.search), suffixIcon: IconButton(icon: const Icon(Icons.arrow_forward), onPressed: openSearch), border: OutlineInputBorder(borderRadius: BorderRadius.circular(14))),
        ),
        const SizedBox(height: 20),
        Row(children: [Expanded(child: _actionCard(Icons.storefront, 'FIND BUSINESSES', () => openSearch())), const SizedBox(width: 12), Expanded(child: _actionCard(Icons.handyman, 'BOOK SERVICES', () => openSearch()))]),
        const SizedBox(height: 24),
        const Text('Categories', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        ...categories.map((c) => Card(child: ListTile(onTap: () => openCategory(c), leading: const Icon(Icons.location_city), title: Text(c), trailing: const Icon(Icons.chevron_right)))),
      ]),
      bottomNavigationBar: NavigationBar(selectedIndex: nav, onDestinationSelected: (i) => setState(() => nav = i), destinations: const [
        NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: 'Home'),
        NavigationDestination(icon: Icon(Icons.explore_outlined), label: 'Explore'),
        NavigationDestination(icon: Icon(Icons.calendar_month_outlined), label: 'Bookings'),
        NavigationDestination(icon: Icon(Icons.bookmark_border), label: 'Saved'),
        NavigationDestination(icon: Icon(Icons.person_outline), label: 'Profile'),
      ]),
    );
  }

  Widget _actionCard(IconData icon, String label, VoidCallback onTap) => Card(child: InkWell(onTap: onTap, borderRadius: BorderRadius.circular(12), child: Padding(padding: const EdgeInsets.symmetric(vertical: 18), child: Column(children: [Icon(icon, size: 32), const SizedBox(height: 8), Text(label, textAlign: TextAlign.center, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12))]))));
}

class ResultsPage extends StatelessWidget {
  final String query;
  final String? category;
  const ResultsPage({super.key, required this.query, required this.category});

  @override Widget build(BuildContext context) {
    final q = query.toLowerCase();
    final results = businesses.where((b) {
      final catOk = category == null || b.category == category;
      final queryOk = q.isEmpty || b.name.toLowerCase().contains(q) || b.category.toLowerCase().contains(q) || b.city.toLowerCase().contains(q);
      return catOk && queryOk;
    }).toList();
    final title = category ?? (query.isEmpty ? 'All Businesses' : 'Search Results');
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: results.isEmpty
          ? const Center(child: Text('No businesses found'))
          : ListView.builder(padding: const EdgeInsets.all(12), itemCount: results.length, itemBuilder: (_, i) {
              final b = results[i];
              return Card(child: ListTile(leading: const CircleAvatar(child: Icon(Icons.storefront)), title: Text(b.name, style: const TextStyle(fontWeight: FontWeight.bold)), subtitle: Text('${b.category}\n${b.city}'), isThreeLine: true, trailing: const Icon(Icons.chevron_right), onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => BusinessPage(business: b))));
            }),
    );
  }
}

class BusinessPage extends StatelessWidget {
  final LocalBusiness business;
  const BusinessPage({super.key, required this.business});
  @override Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: Text(business.name)), body: Padding(padding: const EdgeInsets.all(20), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [const CircleAvatar(radius: 38, child: Icon(Icons.store, size: 38)), const SizedBox(height: 16), Text(business.name, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)), const SizedBox(height: 8), Text(business.category), const SizedBox(height: 8), Text(business.city), const SizedBox(height: 24), FilledButton(onPressed: () {}, child: const Text('Contact Business'))])));
}
