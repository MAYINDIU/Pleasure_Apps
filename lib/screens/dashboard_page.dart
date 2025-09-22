// dashboard_page.dart
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _currentIndex = 0;

  final List<String> _bannerImages = [
    'assets/images/basic.jpg',
    'assets/images/standard.jpg',
    'assets/images/premium.jpg',
    'assets/images/family.jpg',
  ];

  Future<void> _logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('isLoggedIn');
    await prefs.remove('userEmail');
    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> menuItems = [
      {"title": "Sales Statement", "icon": Icons.receipt_long},
      {"title": "Daily Sales", "icon": Icons.bar_chart},
      {"title": "Ranking", "icon": Icons.leaderboard},
      {"title": "Buy Card", "icon": Icons.credit_card},
      {"title": "Card Renewal", "icon": Icons.refresh},
      {"title": "Chain Setup", "icon": Icons.settings},
      {"title": "Business", "icon": Icons.business_center},
      {"title": "Personal Info", "icon": Icons.person},
      {"title": "Card Balance", "icon": Icons.account_balance_wallet},
      {"title": "Reference", "icon": Icons.link},
      {"title": "Hospital List", "icon": Icons.local_hospital},
      {"title": "Discount Claim", "icon": Icons.local_offer},
      {"title": "Change Password", "icon": Icons.lock_reset},
      {"title": "Discount", "icon": Icons.discount},
      {"title": "Claim Individual", "icon": Icons.person_add},
    ];

    const Color menuBgColor = Color(0xFF004D40);

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Dashboard',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
        backgroundColor: Colors.teal,
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              onPressed: () => _logout(context),
              icon: const Icon(Icons.logout, color: Colors.white),
              tooltip: 'Logout',
            ),
          ],
        ),
        body: Column(
          children: [
            // Carousel Slider
            SizedBox(
              height: 160,
              child: Stack(
                children: [
                  CarouselSlider.builder(
                    itemCount: _bannerImages.length,
                    options: CarouselOptions(
                      autoPlay: true,
                      enlargeCenterPage: true,
                      enlargeFactor: 0.25,
                      viewportFraction: 0.75,
                      aspectRatio: 16 / 9,
                      scrollPhysics: const BouncingScrollPhysics(),
                      onPageChanged: (index, reason) {
                        setState(() {
                          _currentIndex = index;
                        });
                      },
                    ),
                    itemBuilder: (context, index, realIndex) {
                      return _bannerCard(_bannerImages[index]);
                    },
                  ),
                  Positioned(
                    bottom: 8,
                    left: 0,
                    right: 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: _bannerImages.asMap().entries.map((entry) {
                        return GestureDetector(
                          onTap: () => setState(() => _currentIndex = entry.key),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            width: _currentIndex == entry.key ? 12 : 8,
                            height: _currentIndex == entry.key ? 12 : 8,
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: _currentIndex == entry.key
                                  ? const Color.fromARGB(255, 0, 87, 78)
                                  : const Color.fromARGB(255, 0, 94, 84).withOpacity(0.3),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 15),

            // Menu Items Grid
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.all(12),
                itemCount: menuItems.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 1,
                ),
                itemBuilder: (context, index) {
                  final item = menuItems[index];
                  return GestureDetector(
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('${item['title']} tapped')),
                      );
                    },
                    child: Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: menuBgColor.withOpacity(0.12),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Icon(
                              item['icon'] as IconData,
                              size: 26,
                              color: menuBgColor,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            item['title'],
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Banner Card without title
  Widget _bannerCard(String imagePath) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Image.asset(
        imagePath,
        fit: BoxFit.cover,
      ),
    );
  }
}
