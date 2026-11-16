import 'package:flutter/material.dart';
import '../models/movie_model.dart';
import '../theme/app_theme.dart';
import 'movie_card.dart';

/// Baris kategori film horizontal pada Netflix Dashboard.
class MovieCategorySection extends StatefulWidget {
  final String title;
  final List<MovieModel> movies;
  final ValueChanged<MovieModel> onTapMovie;

  const MovieCategorySection({
    super.key,
    required this.title,
    required this.movies,
    required this.onTapMovie,
  });

  @override
  State<MovieCategorySection> createState() => _MovieCategorySectionState();
}

class _MovieCategorySectionState extends State<MovieCategorySection> {
  final ScrollController _scrollController = ScrollController();
  bool _rowHovered = false;

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollHorizontal(double delta) {
    if (!_scrollController.hasClients) return;
    final double target = (_scrollController.offset + delta).clamp(
      0.0,
      _scrollController.position.maxScrollExtent,
    );
    _scrollController.animateTo(
      target,
      duration: const Duration(milliseconds: 420),
      curve: Curves.easeOutCubic,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.movies.isEmpty) {
      return const SizedBox.shrink();
    }

    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isMobile = screenWidth < 640;
    final bool isTablet = screenWidth >= 640 && screenWidth < 1024;
    final double horizontalPadding = isMobile ? 16 : (isTablet ? 28 : 48);
    final double cardWidth = isMobile ? 150 : (isTablet ? 175 : 200);
    final double cardHeight = isMobile ? 235 : (isTablet ? 265 : 295);

    final bool isTop10Category = widget.title == 'Top 10 Movies';
    final bool isContinueWatching = widget.title == 'Continue Watching';

    return MouseRegion(
      onEnter: (_) => setState(() => _rowHovered = true),
      onExit: (_) => setState(() => _rowHovered = false),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 28),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Judul Kategori
            Padding(
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
              child: Row(
                children: <Widget>[
                  Flexible(
                    child: Text(
                      widget.title,
                      style: TextStyle(
                        color: AppTheme.primaryText,
                        fontSize: isMobile ? 17 : 21,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.2,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  AnimatedOpacity(
                    opacity: _rowHovered ? 1.0 : 0.0,
                    duration: const Duration(milliseconds: 200),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(
                          'Explore All',
                          style: TextStyle(
                            color: Color(0xFF54B9C5),
                            fontSize: 12.5,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(width: 2),
                        Icon(
                          Icons.chevron_right_rounded,
                          color: Color(0xFF54B9C5),
                          size: 18,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),

            // Horizontal Scrolling List Poster Film
            SizedBox(
              height: cardHeight + 24,
              child: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  ListView.separated(
                    controller: _scrollController,
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    padding: EdgeInsets.symmetric(
                      horizontal: horizontalPadding,
                      vertical: 12,
                    ),
                    itemCount: widget.movies.length,
                    separatorBuilder: (_, _) =>
                        SizedBox(width: isMobile ? 10 : 14),
                    itemBuilder: (BuildContext context, int index) {
                      final MovieModel movie = widget.movies[index];
                      return MovieCard(
                        movie: movie,
                        width: cardWidth,
                        height: cardHeight,
                        showTop10Badge: isTop10Category,
                        showProgress: isContinueWatching,
                        onTapCard: widget.onTapMovie,
                      );
                    },
                  ),

                  // Tombol Scroll Kiri (Saat Hover di Desktop)
                  if (!isMobile && _rowHovered)
                    Positioned(
                      left: 0,
                      top: 12,
                      bottom: 12,
                      child: GestureDetector(
                        onTap: () => _scrollHorizontal(-cardWidth * 3),
                        child: MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: Container(
                            width: 42,
                            decoration: BoxDecoration(
                              color: Colors.black.withValues(alpha: 0.65),
                              borderRadius: const BorderRadius.only(
                                topRight: Radius.circular(6),
                                bottomRight: Radius.circular(6),
                              ),
                            ),
                            child: const Icon(
                              Icons.chevron_left_rounded,
                              color: AppTheme.primaryText,
                              size: 34,
                            ),
                          ),
                        ),
                      ),
                    ),

                  // Tombol Scroll Kanan (Saat Hover di Desktop)
                  if (!isMobile && _rowHovered)
                    Positioned(
                      right: 0,
                      top: 12,
                      bottom: 12,
                      child: GestureDetector(
                        onTap: () => _scrollHorizontal(cardWidth * 3),
                        child: MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: Container(
                            width: 42,
                            decoration: BoxDecoration(
                              color: Colors.black.withValues(alpha: 0.65),
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(6),
                                bottomLeft: Radius.circular(6),
                              ),
                            ),
                            child: const Icon(
                              Icons.chevron_right_rounded,
                              color: AppTheme.primaryText,
                              size: 34,
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
