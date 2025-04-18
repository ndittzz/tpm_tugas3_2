import 'package:flutter/material.dart';
import 'package:tugas3_tpm/screens/favorite_page.dart';
import 'package:tugas3_tpm/screens/jenis_bilangan_page.dart';
import 'package:tugas3_tpm/screens/situs_rekomendasi_page.dart';
import 'package:tugas3_tpm/screens/welcome_page.dart';
import 'package:tugas3_tpm/screens/stopwatch_page.dart';
import 'package:tugas3_tpm/screens/konversiwaktu_page.dart';
import 'package:tugas3_tpm/screens/tracking_lbs_page.dart';
import '../session_manager.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    MainMenuPage(),
    MembersPage(),
    HelpPage(),
  ];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  // Future<void> _logout() async {
  //   await SessionManager.logout();
  //   Navigator.pushAndRemoveUntil(
  //     context,
  //     MaterialPageRoute(builder: (_) => const WelcomePage()),
  //     (route) => false,
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'HOME PAGE',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 255, 255, 255),
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.teal,
        // actions: [
        //   IconButton(
        //     icon: Icon(Icons.logout),
        //     onPressed: _logout,
        //     color: Colors.white,
        //   ),
        // ],
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        selectedItemColor: Colors.white,
        backgroundColor: Colors.teal,
        unselectedItemColor: Colors.white70,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Beranda',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.group),
            label: 'Anggota',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.help),
            label: 'Bantuan',
          ),
        ],
      ),
    );
  }
}

class MainMenuPage extends StatelessWidget {
  const MainMenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.teal, // hijau tua elegan
            Colors.teal, // hijau pastel cerah
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/logo-hijau.jpg',
                width: 400,
              ),
              const SizedBox(height: 12),
              // const Text(
              //   'PILIH MENU',
              //   style: TextStyle(
              //     fontSize: 14,
              //     fontWeight: FontWeight.bold,
              //     color: Colors.white,
              //   ),
              // ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _verticalMenuCard(
                    context,
                    title: 'Stopwatch',
                    icon: Icons.timer,
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => StopwatchPage()));
                    },
                  ),
                  _verticalMenuCard(
                    context,
                    title: 'Tracking LBS',
                    icon: Icons.location_on,
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => TrackingPage()));
                    },
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: _menuCard(
                      context,
                      title: 'Konversi Waktu',
                      icon: Icons.access_time,
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => KonverterWaktuPage()));
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _menuCard(
                      context,
                      title: 'Jenis Bilangan',
                      icon: Icons.calculate,
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => JenisBilanganPage()));
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              _menuCard(
                context,
                title: 'Website Rekomendasi',
                icon: Icons.web,
                fullWidth: true,
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => SitusRekomendasiPage()));
                },
              ),
              const SizedBox(height: 12),
              _menuCard(
                context,
                title: 'Favorite',
                icon: Icons.favorite,
                fullWidth: true,
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => FavoritePage()));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 🔳 Tombol Horizontal
  Widget _menuCard(BuildContext context,
      {required String title,
      required IconData icon,
      required VoidCallback onTap,
      bool fullWidth = false}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      width: fullWidth ? double.infinity : null,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.9),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.15),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment:
                fullWidth ? MainAxisAlignment.center : MainAxisAlignment.start,
            children: [
              Icon(icon, color: Colors.teal, size: 28), // hijau bold
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  title,
                  textAlign: fullWidth ? TextAlign.center : TextAlign.start,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal, // hijau gelap/soft black
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 🔲 Tombol Kotak Vertikal
  Widget _verticalMenuCard(BuildContext context,
      {required String title,
      required IconData icon,
      required VoidCallback onTap}) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.42,
      height: 130,
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.teal, size: 32),
            const SizedBox(height: 12),
            Text(
              title,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1c1917),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MenuButton extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  const MenuButton({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      color: Colors.white.withOpacity(0.9),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: ListTile(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        leading: Icon(icon, color: Color(0xFF5B0583), size: 28),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 16,
            color: Color(0xFF1D1C4C),
            fontWeight: FontWeight.bold,
          ),
        ),
        trailing:
            Icon(Icons.arrow_forward_ios, color: Color(0xFF1D1C4C), size: 16),
        onTap: onTap,
      ),
    );
  }
}

class MembersPage extends StatelessWidget {
  const MembersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'PROFIL ANGGOTA',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.teal,
              Colors.teal,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildProfileCard(
                    imagePath: 'assets/images/anggota1.jpg',
                    name: 'Ageng Sandar',
                    nim: '123220011',
                  ),
                  SizedBox(width: 20),
                  _buildProfileCard(
                    imagePath: 'assets/images/anggota2.jpg',
                    name: 'Mohamad Risqi',
                    nim: '123220021',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileCard({
    required String imagePath,
    required String name,
    required String nim,
  }) {
    return Container(
      width: 160,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              imagePath,
              height: 160, // Mengatur aspek rasio 3x4
              width: 120,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 10),
          Text(
            name,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 5),
          Text(
            nim,
            style: TextStyle(fontSize: 16, color: Colors.black54),
          ),
        ],
      ),
    );
  }
}

class HelpPage extends StatelessWidget {
  const HelpPage({super.key});

  Future<void> _logout(BuildContext context) async {
    await SessionManager.logout();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const WelcomePage()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'BANTUAN',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.teal,
              Colors.teal,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 320,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFFE5E5E5),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Cara Menggunakan Aplikasi:',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF5B0583),
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      '1. Login menggunakan username dan password.\n'
                      '2. Gunakan menu di halaman utama untuk memilih fitur.\n'
                      '3. Gunakan menu bawah untuk navigasi lainnya.',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: 320, // sesuaikan dengan container atasnya
                child: ElevatedButton.icon(
                  onPressed: () => _logout(context),
                  icon: const Icon(Icons.logout, color: Colors.white),
                  label: const Text('Logout',
                      style: TextStyle(color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
