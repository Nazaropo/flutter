import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application/kuis_sceen.dart';

class HomeSceen extends StatefulWidget {
  const HomeSceen({super.key});

  @override
  State<HomeSceen> createState() => _HomeSceenState();
}

class _HomeSceenState extends State<HomeSceen> {
  Widget _buildKartuKategori(
    BuildContext context,
    String title,
    IconData icon,
    Color color,
    String soals,
  ) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => KuisSceen()),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.white.withOpacity(0.3),
              blurRadius: 10,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: color.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 30, color: color),
            ),
            SizedBox(height: 15),
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xff2c3e50),
              ),
            ),
            SizedBox(height: 5),
            Text(
              soals,
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xff6c63ff), Color(0xff3f3d9d)],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.white.withOpacity(0.9),
                            child: Icon(Icons.person, color: Color(0xff6c63ff)),
                          ),
                          SizedBox(width: 10),
                          Text(
                            "fir",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Icon(Icons.notifications, color: Colors.white),
                  ],
                ),
                SizedBox(height: 40),
                Text(
                  "Ayo Mulai",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white.withOpacity(0.7),
                  ),
                ),
                Text(
                  "Uji pengetahuanmu dan raih skor tertinggi! ",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  "Pilih Kategori Untuk Memulai Kuis",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white.withOpacity(0.7),
                  ),
                ),
                SizedBox(height: 40),
                Expanded(
                  child: GridView.count(
                    crossAxisCount: 2,
                    childAspectRatio: 0.85,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 15,
                    children: [
                      _buildKartuKategori(
                        context,
                        "Agama",
                        Icons.volunteer_activism,
                        Color.fromARGB(255, 83, 214, 105),
                        "10 Soal",
                      ),
                      _buildKartuKategori(
                        context,
                        "Bahasa Indonesia",
                        Icons.menu_book,
                        Color(0xffff6b6b),
                        "10 Soal",
                      ),
                      _buildKartuKategori(
                        context,
                        "Pendidikan Jasmani",
                        Icons.sports_soccer,
                        Color.fromARGB(255, 66, 102, 218),
                        "10 Soal",
                      ),
                      _buildKartuKategori(
                        context,
                        "Pendidikan Kewarganegaraan",
                        Icons.balance,
                        Color.fromARGB(255, 108, 86, 86),
                        "10 Soal",
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
