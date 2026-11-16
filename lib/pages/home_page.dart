import 'package:flutter/material.dart';
import '../data/movie_data.dart';
import '../models/movie_model.dart';
import '../theme/app_theme.dart';
import '../widgets/hero_banner.dart';
import '../widgets/movie_category.dart';
import '../widgets/movie_detail_modal.dart';
import '../widgets/navbar.dart';
import '../widgets/netflix_logo.dart';

/// Halaman Netflix Dashboard / Home Page.
///
/// Fitur:
/// - Desain sinematik premium gelap (Netflix Red #E50914, background #141414).
/// - Navigation Bar dengan menu, Search icon, Notification icon, Profile (Arka Raffinendra),
///   dan tombol Logout.
/// - Hero Banner sinematik besar dengan tombol Play dan More Info.
/// - 6 Kategori film (Trending Now, Popular on Netflix, Top 10 Movies,
///   Action Movies, Recommended for You, Continue Watching) dengan poster internet.
/// - Horizontal scrolling dan efek hover responsif.
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();
  bool _isScrolled = false;
  String _activeNavTab = 'Home';

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;
    final bool scrolledNow = _scrollController.offset > 30;
    if (scrolledNow != _isScrolled) {
      setState(() {
        _isScrolled = scrolledNow;
      });
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _handleTabSelected(String tab) {
    setState(() {
      _activeNavTab = tab;
    });
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        0,
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeOutCubic,
      );
    }
  }

  void _openMovieDetail(MovieModel movie, {bool isPlay = false}) {
    showMovieSimpleModal(context, movie, isPlay: isPlay);
  }

  void _performLogout() {
    // Logout hanya berfungsi sebagai navigasi kembali ke Login Page
    Navigator.of(context).pushNamedAndRemoveUntil(
      '/login',
      (Route<dynamic> route) => false,
    );
  }

  void _showNotificationSnackbar() {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        const SnackBar(
          content: Text('Tidak ada notifikasi baru saat ini.'),
          duration: Duration(seconds: 2),
        ),
      );
  }

  void _showSearchDialog() {
    showDialog<void>(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          backgroundColor: AppTheme.secondaryBackground,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: const BorderSide(color: AppTheme.borderColor),
          ),
          title: const Row(
            children: <Widget>[
              Icon(Icons.search_rounded, color: AppTheme.netflixRed),
              SizedBox(width: 10),
              Text(
                'Search Movies',
                style: TextStyle(
                  color: AppTheme.primaryText,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextField(
                autofocus: true,
                style: const TextStyle(color: AppTheme.primaryText),
                decoration: InputDecoration(
                  hintText: 'Ketik judul film, genre, serial...',
                  hintStyle: const TextStyle(color: AppTheme.secondaryText),
                  filled: true,
                  fillColor: AppTheme.cardBackground,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                    borderSide: const BorderSide(color: AppTheme.borderColor),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                    borderSide: const BorderSide(color: AppTheme.netflixRed),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'Koleksi film dapat dijelajahi langsung melalui baris kategori di dashboard.',
                style: TextStyle(
                  color: AppTheme.secondaryText,
                  fontSize: 12.5,
                ),
              ),
            ],
          ),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.netflixRed,
                foregroundColor: AppTheme.primaryText,
              ),
              child: const Text('Tutup'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.primaryBackground,
      body: Stack(
        children: <Widget>[
          // Main Scrollable Content Area
          CustomScrollView(
            controller: _scrollController,
            slivers: <Widget>[
              // 1. Large Cinematic Hero Banner
              SliverToBoxAdapter(
                child: HeroBanner(
                  featuredMovies: MovieData.featuredHeroMovies,
                  onPlayPressed: (MovieModel movie) =>
                      _openMovieDetail(movie, isPlay: true),
                  onMoreInfoPressed: (MovieModel movie) =>
                      _openMovieDetail(movie, isPlay: false),
                ),
              ),

              // Active Tab Subheader Pill jika memilih tab selain 'Home'
              if (_activeNavTab != 'Home')
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(48, 8, 48, 20),
                    child: Row(
                      children: <Widget>[
                        Container(
                          width: 4,
                          height: 24,
                          decoration: BoxDecoration(
                            color: AppTheme.netflixRed,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          'Browsing: $_activeNavTab',
                          style: const TextStyle(
                            color: AppTheme.primaryText,
                            fontSize: 22,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(width: 14),
                        TextButton.icon(
                          onPressed: () => _handleTabSelected('Home'),
                          icon: const Icon(
                            Icons.clear_all_rounded,
                            size: 18,
                            color: AppTheme.secondaryText,
                          ),
                          label: const Text(
                            'Show All Categories',
                            style: TextStyle(
                              color: AppTheme.secondaryText,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

              // 2. 6 Kategori Film Utama Sesuai Spesifikasi Revisi
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    final String categoryName = MovieData.categories[index];
                    final List<MovieModel> categoryMovies =
                        MovieData.getMoviesByCategory(categoryName);

                    return MovieCategorySection(
                      title: categoryName,
                      movies: categoryMovies,
                      onTapMovie: (MovieModel movie) =>
                          _openMovieDetail(movie, isPlay: false),
                    );
                  },
                  childCount: MovieData.categories.length,
                ),
              ),

              // 3. Netflix Footer
              SliverToBoxAdapter(
                child: _buildNetflixFooter(),
              ),
            ],
          ),

          // Fixed Top Navigation Bar
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: NetflixNavbar(
              isScrolled: _isScrolled,
              activeTab: _activeNavTab,
              onTabSelected: _handleTabSelected,
              onLogout: _performLogout,
              onSearchTap: _showSearchDialog,
              onNotificationTap: _showNotificationSnackbar,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNetflixFooter() {
    final bool isMobile = MediaQuery.of(context).size.width < 640;
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 32),
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 72,
        vertical: 44,
      ),
      decoration: const BoxDecoration(
        color: Color(0xFF0E0E0E),
        border: Border(
          top: BorderSide(color: AppTheme.borderColor, width: 0.8),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              const NetflixLogo(fontSize: 22),
              const SizedBox(width: 12),
              Text(
                'DASHBOARD • ${MovieData.currentUserName.toUpperCase()}',
                style: const TextStyle(
                  color: AppTheme.secondaryText,
                  fontSize: 11.5,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.4,
                ),
              ),
            ],
          ),
          const SizedBox(height: 22),
          Wrap(
            spacing: 48,
            runSpacing: 14,
            children: const <Widget>[
              Text(
                'Audio and Subtitles',
                style: TextStyle(color: AppTheme.secondaryText, fontSize: 13),
              ),
              Text(
                'Audio Description',
                style: TextStyle(color: AppTheme.secondaryText, fontSize: 13),
              ),
              Text(
                'Help Center',
                style: TextStyle(color: AppTheme.secondaryText, fontSize: 13),
              ),
              Text(
                'Media Center',
                style: TextStyle(color: AppTheme.secondaryText, fontSize: 13),
              ),
              Text(
                'Terms of Use',
                style: TextStyle(color: AppTheme.secondaryText, fontSize: 13),
              ),
              Text(
                'Privacy',
                style: TextStyle(color: AppTheme.secondaryText, fontSize: 13),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Text(
            '© 2026 Netflix Clone College Project by ${MovieData.currentUserName} — Built with Flutter Web & Dart.',
            style: const TextStyle(
              color: Color(0xFF777777),
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
