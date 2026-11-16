import 'package:flutter/material.dart';
import '../models/movie_model.dart';
import '../theme/app_theme.dart';
import 'netflix_logo.dart';

/// Large Cinematic Netflix Hero Banner displayed at the top of the Home Page.
///
/// Features:
/// - Full-bleed high-resolution movie backdrop with loading indicator and
///   rich fallback gradient if image fails to load.
/// - Left-to-right dark gradient and bottom vignette blending into #141414.
/// - Displays N SERIES / N FILM badge, large Movie Title, Rating, Release Year,
///   Duration, Genre tags, and readable Movie Description.
/// - White "Play" button and translucent grey "More Info" button with hover animations.
/// - Interactive featured movie switcher pills so users can preview multiple hero titles.
class HeroBanner extends StatefulWidget {
  final List<MovieModel> featuredMovies;
  final ValueChanged<MovieModel> onPlayPressed;
  final ValueChanged<MovieModel> onMoreInfoPressed;

  const HeroBanner({
    super.key,
    required this.featuredMovies,
    required this.onPlayPressed,
    required this.onMoreInfoPressed,
  });

  @override
  State<HeroBanner> createState() => _HeroBannerState();
}

class _HeroBannerState extends State<HeroBanner>
    with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;
  bool _playHovered = false;
  bool _moreInfoHovered = false;
  late final AnimationController _fadeController;
  late final Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 650),
    );
    _fadeAnimation = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeOutCubic,
    );
    _fadeController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  void _selectHeroMovie(int index) {
    if (index == _selectedIndex) return;
    setState(() {
      _selectedIndex = index;
    });
    _fadeController
      ..reset()
      ..forward();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.featuredMovies.isEmpty) {
      return const SizedBox.shrink();
    }

    final MovieModel movie =
        widget.featuredMovies[_selectedIndex % widget.featuredMovies.length];
    final Size screenSize = MediaQuery.of(context).size;
    final bool isMobile = screenSize.width < 640;
    final bool isTablet = screenSize.width >= 640 && screenSize.width < 1024;
    final double bannerHeight = isMobile
        ? 570
        : (isTablet
            ? 600
            : (screenSize.height * 0.82).clamp(580.0, 760.0));

    return SizedBox(
      width: double.infinity,
      height: bannerHeight,
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          // 1. High-resolution Backdrop Image with fade transition, loading & fallback
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 550),
            child: SizedBox.expand(
              key: ValueKey<String>(movie.backdropUrl),
              child: Image.network(
                movie.backdropUrl,
                fit: BoxFit.cover,
                alignment: Alignment.topCenter,
                loadingBuilder: (
                  BuildContext context,
                  Widget child,
                  ImageChunkEvent? loadingProgress,
                ) {
                  if (loadingProgress == null) return child;
                  return Container(
                    color: AppTheme.secondaryBackground,
                    alignment: Alignment.center,
                    child: const SizedBox(
                      width: 36,
                      height: 36,
                      child: CircularProgressIndicator(
                        color: AppTheme.netflixRed,
                        strokeWidth: 2.5,
                      ),
                    ),
                  );
                },
                errorBuilder: (
                  BuildContext context,
                  Object error,
                  StackTrace? stackTrace,
                ) {
                  return Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: <Color>[
                          Color(movie.accentColorValue).withValues(alpha: 0.55),
                          AppTheme.secondaryBackground,
                          AppTheme.primaryBackground,
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),

          // 2. Left-to-Right Cinematic Dark Gradient
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                stops: const <double>[0.0, 0.45, 0.78, 1.0],
                colors: <Color>[
                  AppTheme.primaryBackground.withValues(alpha: 0.94),
                  AppTheme.primaryBackground.withValues(alpha: 0.68),
                  AppTheme.primaryBackground.withValues(alpha: 0.22),
                  Colors.transparent,
                ],
              ),
            ),
          ),

          // 3. Bottom-to-Top Gradient blending seamlessly into #141414 background
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                stops: <double>[0.0, 0.25, 0.60, 1.0],
                colors: <Color>[
                  AppTheme.primaryBackground,
                  Color(0xCC141414),
                  Colors.transparent,
                  Color(0x66000000),
                ],
              ),
            ),
          ),

          // 4. Foreground Content (Title, Metadata, Description, Buttons)
          FadeTransition(
            opacity: _fadeAnimation,
            child: Padding(
              padding: EdgeInsets.only(
                left: isMobile ? 20 : (isTablet ? 32 : 56),
                right: isMobile ? 20 : 48,
                top: isMobile ? 72 : 100,
                bottom: isMobile ? 24 : 52,
              ),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: SingleChildScrollView(
                  physics: const NeverScrollableScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                  // N SERIES / N FILM badge
                  Wrap(
                    spacing: 8,
                    runSpacing: 6,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: <Widget>[
                      const NetflixLogo(fontSize: 22, compact: true),
                      Text(
                        movie.isSeries ? 'S E R I E S' : 'F I L M',
                        style: const TextStyle(
                          color: AppTheme.secondaryText,
                          fontSize: 12,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 3.2,
                        ),
                      ),
                      if (movie.top10Rank != null)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 7,
                            vertical: 3,
                          ),
                          decoration: BoxDecoration(
                            color: AppTheme.netflixRed,
                            borderRadius: BorderRadius.circular(3),
                          ),
                          child: Text(
                            '#${movie.top10Rank} in Indonesia Today',
                            style: const TextStyle(
                              color: AppTheme.primaryText,
                              fontSize: 11,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Large Cinematic Movie Title
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: isMobile ? screenSize.width - 40 : 650,
                    ),
                    child: Text(
                      movie.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: AppTheme.primaryText,
                        fontSize: isMobile ? 32 : (isTablet ? 44 : 56),
                        fontWeight: FontWeight.w900,
                        letterSpacing: -0.8,
                        height: 1.06,
                        shadows: const <Shadow>[
                          Shadow(
                            color: Color(0xCC000000),
                            blurRadius: 16,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 14),

                  // Metadata Row: Match %, Rating, Release Year, Maturity Age, Duration, Genre
                  Wrap(
                    spacing: 10,
                    runSpacing: 8,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: <Widget>[
                      Text(
                        '${movie.matchScore}% Match',
                        style: const TextStyle(
                          color: AppTheme.matchGreen,
                          fontSize: 14.5,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 7,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.amber.withValues(alpha: 0.16),
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(
                            color: Colors.amber.withValues(alpha: 0.7),
                          ),
                        ),
                        child: Text(
                          movie.rating,
                          style: const TextStyle(
                            color: Colors.amber,
                            fontSize: 12.5,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      Text(
                        movie.releaseYear,
                        style: const TextStyle(
                          color: AppTheme.primaryText,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 1.5,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: AppTheme.secondaryText,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(3),
                        ),
                        child: Text(
                          movie.maturityAge,
                          style: const TextStyle(
                            color: AppTheme.primaryText,
                            fontSize: 11.5,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Text(
                        movie.duration,
                        style: const TextStyle(
                          color: AppTheme.secondaryText,
                          fontSize: 13.5,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 5,
                          vertical: 1,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(color: AppTheme.borderColor),
                          borderRadius: BorderRadius.circular(3),
                        ),
                        child: const Text(
                          '4K Ultra HD',
                          style: TextStyle(
                            color: AppTheme.secondaryText,
                            fontSize: 10.5,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),

                  // Genre bullet pills
                  Wrap(
                    spacing: 8,
                    runSpacing: 4,
                    children: movie.genreList.map((String g) {
                      return Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Container(
                            width: 5,
                            height: 5,
                            decoration: const BoxDecoration(
                              color: AppTheme.netflixRed,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 5),
                          Text(
                            g,
                            style: const TextStyle(
                              color: AppTheme.primaryText,
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 14),

                  // Movie Description with readable width limit
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: isMobile ? screenSize.width - 40 : 560,
                    ),
                    child: Text(
                      movie.description,
                      maxLines: isMobile ? 3 : 4,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: AppTheme.primaryText.withValues(alpha: 0.92),
                        fontSize: isMobile ? 13.5 : 15.5,
                        height: 1.45,
                        shadows: const <Shadow>[
                          Shadow(
                            color: Color(0xDD000000),
                            blurRadius: 8,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 22),

                  // Action Buttons Row (White Play + Translucent Grey More Info) & Hero Switcher
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: Wrap(
                          spacing: 12,
                          runSpacing: 10,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: <Widget>[
                            // White Play Button
                            MouseRegion(
                              cursor: SystemMouseCursors.click,
                              onEnter: (_) =>
                                  setState(() => _playHovered = true),
                              onExit: (_) =>
                                  setState(() => _playHovered = false),
                              child: GestureDetector(
                                onTap: () => widget.onPlayPressed(movie),
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 160),
                                  padding: EdgeInsets.symmetric(
                                    horizontal: isMobile ? 18 : 28,
                                    vertical: isMobile ? 10 : 13,
                                  ),
                                  decoration: BoxDecoration(
                                    color: _playHovered
                                        ? AppTheme.primaryText
                                            .withValues(alpha: 0.82)
                                        : AppTheme.primaryText,
                                    borderRadius: BorderRadius.circular(4),
                                    boxShadow: const <BoxShadow>[
                                      BoxShadow(
                                        color: Color(0x66000000),
                                        blurRadius: 10,
                                        offset: Offset(0, 4),
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Icon(
                                        Icons.play_arrow_rounded,
                                        color: Colors.black,
                                        size: isMobile ? 22 : 28,
                                      ),
                                      const SizedBox(width: 6),
                                      Text(
                                        'Play',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: isMobile ? 14.5 : 17,
                                          fontWeight: FontWeight.w800,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),

                            // Translucent Grey More Info Button
                            MouseRegion(
                              cursor: SystemMouseCursors.click,
                              onEnter: (_) =>
                                  setState(() => _moreInfoHovered = true),
                              onExit: (_) =>
                                  setState(() => _moreInfoHovered = false),
                              child: GestureDetector(
                                onTap: () => widget.onMoreInfoPressed(movie),
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 160),
                                  padding: EdgeInsets.symmetric(
                                    horizontal: isMobile ? 16 : 26,
                                    vertical: isMobile ? 10 : 13,
                                  ),
                                  decoration: BoxDecoration(
                                    color: _moreInfoHovered
                                        ? const Color(0x996D6D6E)
                                        : const Color(0xB36D6D6E),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Icon(
                                        Icons.info_outline_rounded,
                                        color: AppTheme.primaryText,
                                        size: isMobile ? 20 : 26,
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        'More Info',
                                        style: TextStyle(
                                          color: AppTheme.primaryText,
                                          fontSize: isMobile ? 14.5 : 17,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Featured Hero Switcher Indicators + Maturity Badge on Desktop/Tablet
                      if (!isMobile && widget.featuredMovies.length > 1)
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            ...List<Widget>.generate(
                              widget.featuredMovies.length,
                              (int index) {
                                final bool active = index == _selectedIndex;
                                return GestureDetector(
                                  onTap: () => _selectHeroMovie(index),
                                  child: MouseRegion(
                                    cursor: SystemMouseCursors.click,
                                    child: AnimatedContainer(
                                      duration:
                                          const Duration(milliseconds: 220),
                                      margin: const EdgeInsets.only(right: 6),
                                      width: active ? 24 : 10,
                                      height: 4,
                                      decoration: BoxDecoration(
                                        color: active
                                            ? AppTheme.netflixRed
                                            : AppTheme.secondaryText
                                                .withValues(alpha: 0.45),
                                        borderRadius: BorderRadius.circular(2),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                            const SizedBox(width: 14),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              decoration: const BoxDecoration(
                                color: Color(0x99232323),
                                border: Border(
                                  left: BorderSide(
                                    color: AppTheme.primaryText,
                                    width: 3,
                                  ),
                                ),
                              ),
                              child: Text(
                                movie.maturityAge,
                                style: const TextStyle(
                                  color: AppTheme.primaryText,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                ],
              ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

