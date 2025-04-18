import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  final List<Map<String, String>> allSites = [
    {
      'title': 'Online Stopwatch',
      'url': 'https://www.online-stopwatch.com',
      'image': 'assets/images/logo-hijau.jpg',
      'description': 'Stopwatch dan timer gratis online',
    },
    {
      'title': 'Time and Date',
      'url': 'https://www.timeanddate.com',
      'image': 'assets/images/logo-hijau.jpg',
      'description': 'Konversi waktu, kalender, dan zona waktu',
    },
    {
      'title': 'Desmos',
      'url': 'https://www.desmos.com',
      'image': 'assets/images/logo-hijau.jpg',
      'description': 'Kalkulator grafik interaktif',
    },
    {
      'title': 'Math is Fun',
      'url': 'https://www.mathsisfun.com',
      'image': 'assets/images/logo-hijau.jpg',
      'description': 'Penjelasan konsep matematika dengan visual',
    },
    {
      'title': 'GeoGebra',
      'url': 'https://www.geogebra.org',
      'image': 'assets/images/logo-hijau.jpg',
      'description': 'Alat interaktif untuk grafik & geometri',
    },
  ];

  List<Map<String, String>> favoriteSites = [];

  @override
  void initState() {
    super.initState();
    _loadFavoriteSites();
  }

  Future<void> _loadFavoriteSites() async {
    final prefs = await SharedPreferences.getInstance();
    final favUrls = prefs.getStringList('favoriteSites') ?? [];
    setState(() {
      favoriteSites =
          allSites.where((site) => favUrls.contains(site['url'])).toList();
    });
  }

  Future<void> _launchURL(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SITUS FAVORIT',
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.teal, Colors.teal],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: favoriteSites.isEmpty
            ? const Center(
                child: Text(
                  'Belum ada situs favorit.',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              )
            : ListView.builder(
                padding: const EdgeInsets.all(20),
                itemCount: favoriteSites.length,
                itemBuilder: (context, index) {
                  final site = favoriteSites[index];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 20),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.15),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        )
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.asset(
                                site['image']!,
                                width: 60,
                                height: 60,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    site['title']!,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: Color(0xFF1D1C4C),
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    site['description']!,
                                    style: const TextStyle(
                                      color: Colors.black87,
                                      fontSize: 13,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: TextButton.icon(
                            onPressed: () => _launchURL(site['url']!),
                            icon: const Icon(Icons.open_in_new, size: 18),
                            label: const Text(
                              'Kunjungi situs',
                              style: TextStyle(fontSize: 13),
                            ),
                            style: TextButton.styleFrom(
                              foregroundColor: Colors.blueAccent,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
      ),
    );
  }
}
