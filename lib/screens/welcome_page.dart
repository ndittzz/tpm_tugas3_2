import 'package:flutter/material.dart';
import 'login_page.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity, // Pastikan lebar penuh
        height: double.infinity, // Pastikan tinggi penuh
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF1D1C4C), // Warna atas
              Color(0xFFC474E6), // Warna bawah
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          // Menggunakan Center agar isi tetap berada di tengah
          child: Column(
            mainAxisSize: MainAxisSize
                .min, // Menghindari column mengambil semua ruang secara tidak perlu
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Logo Aplikasi
              Image.asset(
                'assets/images/hitungku_logo.png',
                width: 150,
              ),
              SizedBox(height: 20),

              // Teks Judul
              Text(
                "WELCOME TO OUR APP",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 10),

              // Teks Sambutan
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 40),
                child: Text(
                  "Setiap angka punya arti, mari kita hitung bersama",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white70,
                  ),
                ),
              ),
              SizedBox(height: 30),

              // Tombol Mulai
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF5B0583), // Warna tombol
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                ),
                child: Text(
                  "LET'S START",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
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
