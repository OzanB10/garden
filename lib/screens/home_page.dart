import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAF7F4),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 24),
              _buildHeader(),
              const SizedBox(height: 28),
              _buildWeatherCard(),
              const SizedBox(height: 32),
              _buildMyPlantsSection(),
              const SizedBox(height: 28),
              _buildTodayTasksSection(),
              const SizedBox(height: 26),
              _buildAlertsSection(),
              const SizedBox(height: 32),
              _buildTipCard(),
              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNavigation(),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Merhaba Hiya! ☀️',
              style: GoogleFonts.poppins(
                fontSize: 26,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF2D3748),
              ),
            ),
            const SizedBox(height: 6),
            Text(
              'Bugün bitkilerinle nasıl vakit geçireceksin?',
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: const Color(0xFF718096),
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
        Container(
          width: 52,
          height: 52,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF68D391), Color(0xFF38A169)],
            ),
            borderRadius: BorderRadius.circular(18),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF68D391).withOpacity(0.4),
                blurRadius: 12,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: const Icon(
            Icons.favorite_rounded,
            color: Colors.white,
            size: 26,
          ),
        ),
      ],
    );
  }

  Widget _buildWeatherCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFFFF7ED), Color(0xFFFED7AA)],
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFED8936).withOpacity(0.15),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Bugün hava süper! 🌤️',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF9C4221),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '22°C',
                  style: GoogleFonts.poppins(
                    fontSize: 42,
                    fontWeight: FontWeight.w800,
                    color: const Color(0xFF9C4221),
                  ),
                ),
                Text(
                  'Bitkiler için ideal 🌱',
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    color: const Color(0xFFC05621),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
            decoration: BoxDecoration(
              color: const Color(0xFF68D391),
              borderRadius: BorderRadius.circular(22),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF68D391).withOpacity(0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.camera_alt_rounded,
                  color: Colors.white,
                  size: 18,
                ),
                const SizedBox(width: 6),
                Text(
                  'Fotoğraf',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMyPlantsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Yeşil Dostlarım 🪴',
              style: GoogleFonts.poppins(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF2D3748),
              ),
            ),
            Text(
              '7 tane sevimli bitki',
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: const Color(0xFF718096),
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        const SizedBox(height: 18),
        SizedBox(
          height: 190,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 4,
            itemBuilder: (context, index) {
              final plants = [
                {'name': 'Yılan Bitkisi', 'health': 'Yeni yaprak çıkarıyor 🌱', 'image': '🐍', 'color': const Color(0xFFE6FFFA)},
                {'name': 'ZZ Plant', 'health': 'Biraz susuz 💧', 'image': '🌿', 'color': const Color(0xFFF0FFF4)},
                {'name': 'Barış Çiçeği', 'health': 'Güneşten memnun ☀️', 'image': '🕊️', 'color': const Color(0xFFFFF5F5)},
                {'name': 'Kaktüsüm', 'health': 'Büyüme modunda 📈', 'image': '🌵', 'color': const Color(0xFFFFFBF0)},
              ];
              return _buildPlantCard(plants[index]);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildPlantCard(Map<String, dynamic> plant) {
    return Container(
      width: 150,
      margin: const EdgeInsets.only(right: 16),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: plant['color'],
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFF68D391).withOpacity(0.2),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 15,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            width: 75,
            height: 75,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.8),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Center(
              child: Text(
                plant['image']!,
                style: const TextStyle(fontSize: 34),
              ),
            ),
          ),
          const SizedBox(height: 14),
          Text(
            plant['name']!,
            style: GoogleFonts.poppins(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF2D3748),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 6),
          Text(
            plant['health']!,
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: const Color(0xFF68D391),
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildTodayTasksSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'Bugünkü İşlerim ',
              style: GoogleFonts.poppins(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF2D3748),
              ),
            ),
            const Text('✨', style: TextStyle(fontSize: 20)),
          ],
        ),
        const SizedBox(height: 6),
        Text(
          'Hep birlikte bakım zamanı!',
          style: GoogleFonts.poppins(
            fontSize: 14,
            color: const Color(0xFF718096),
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(height: 18),
        _buildTaskCard('ZZ Plant\'ime su ver 💧', 'İki gündür bekliyor, susadı galiba', Icons.water_drop_rounded, false),
        const SizedBox(height: 14),
        _buildTaskCard('Yaprakları temizle ✨', 'Parlak olsunlar istiyorum', Icons.cleaning_services_rounded, true),
        const SizedBox(height: 14),
        _buildTaskCard('Gübre ver 🌱', 'Büyüme zamanı geldi sanırım', Icons.eco_rounded, false),
      ],
    );
  }

  Widget _buildTaskCard(String title, String subtitle, IconData icon, bool isCompleted) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: isCompleted ? const Color(0xFFF0FFF4) : Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: isCompleted ? const Color(0xFF68D391).withOpacity(0.3) : const Color(0xFFE2E8F0),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: isCompleted ? const Color(0xFF68D391) : const Color(0xFFF7FAFC),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Icon(
              isCompleted ? Icons.check_circle_rounded : icon,
              color: isCompleted ? Colors.white : const Color(0xFF718096),
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF2D3748),
                    decoration: isCompleted ? TextDecoration.lineThrough : null,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    color: const Color(0xFF718096),
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAlertsSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFFFF5F5), Color(0xFFFED7D7)],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFF56565).withOpacity(0.2), width: 1),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: const Color(0xFFF56565).withOpacity(0.1),
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Icon(
              Icons.favorite_border_rounded,
              color: Color(0xFFF56565),
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'ZZ Plant\'in sana mesajı var! 💌',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF742A2A),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '"Biraz su içebilir miyim? Susadım galiba 🥺"',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: const Color(0xFF9B2C2C),
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTipCard() {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF667EEA), Color(0xFF764BA2)],
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF667EEA).withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Text('💡', style: TextStyle(fontSize: 24)),
                    const SizedBox(width: 8),
                    Text(
                      'Günün İpucu',
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  'Bitkilerinin yapraklarını hafta da bir kez nemli bezle sil. Daha iyi nefes alabilirler! 🌿',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Colors.white.withOpacity(0.9),
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavigation() {
    return Container(
      height: 85,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(Icons.home_rounded, 'Ana Sayfa', true),
            _buildNavItem(Icons.search_rounded, 'Keşfet', false),
            _buildNavItem(Icons.camera_alt_rounded, 'Bahçem', false),
            _buildNavItem(Icons.person_rounded, 'Profil', false),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, bool isActive) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          color: isActive ? const Color(0xFF68D391) : const Color(0xFFA0AEC0),
          size: 26,
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: isActive ? const Color(0xFF68D391) : const Color(0xFFA0AEC0),
          ),
        ),
      ],
    );
  }
}