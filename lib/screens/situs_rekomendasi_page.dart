import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class SitusRekomendasiPage extends StatefulWidget {
  const SitusRekomendasiPage({super.key});

  @override
  State<SitusRekomendasiPage> createState() => _SitusRekomendasiPageState();
}

class _SitusRekomendasiPageState extends State<SitusRekomendasiPage> {
  final List<Map<String, String>> rekomendasi = [
    {
      'title': 'Online Stopwatch',
      'url': 'https://www.online-stopwatch.com',
      'image': 'assets/images/stopwatch.png',
      'description': 'Stopwatch dan timer gratis online',
    },
    {
      'title': 'Time and Date',
      'url': 'https://www.timeanddate.com',
      'image': 'assets/images/timeanddate.png',
      'description': 'Konversi waktu, kalender, dan zona waktu',
    },
    {
      'title': 'Desmos',
      'url': 'https://www.desmos.com',
      'image': 'assets/images/desmos.png',
      'description': 'Kalkulator grafik interaktif',
    },
    {
      'title': 'Math is Fun',
      'url': 'https://www.mathsisfun.com',
      'image': 'assets/images/mathisfun.png',
      'description': 'Penjelasan konsep matematika dengan visual',
    },
    {
      'title': 'GeoGebra',
      'url': 'https://www.geogebra.org',
      'image': 'assets/images/geogebra.png',
      'description': 'Alat interaktif untuk grafik & geometri',
    },
  ];

  Set<String> favorites = {};

  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final favList = prefs.getStringList('favoriteSites') ?? [];
    setState(() {
      favorites = favList.toSet();
    });
  }

  Future<void> _toggleFavorite(String url) async {
    final prefs = await SharedPreferences.getInstance();
    if (favorites.contains(url)) {
      favorites.remove(url);
    } else {
      favorites.add(url);
    }
    await prefs.setStringList('favoriteSites', favorites.toList());
    setState(() {});
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
        title: const Text('Situs Rekomendasi'),
        centerTitle: true,
        backgroundColor: const Color(0xFF1D1C4C),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF1D1C4C), Color(0xFFC474E6)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: ListView.builder(
          padding: const EdgeInsets.all(20),
          itemCount: rekomendasi.length,
          itemBuilder: (context, index) {
            final site = rekomendasi[index];
            final isFav = favorites.contains(site['url']);
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
                  ),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton.icon(
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
                      IconButton(
                        icon: Icon(
                          isFav ? Icons.favorite : Icons.favorite_border,
                          color: isFav ? Colors.red : Colors.grey,
                        ),
                        onPressed: () => _toggleFavorite(site['url']!),
                      ),
                    ],
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
