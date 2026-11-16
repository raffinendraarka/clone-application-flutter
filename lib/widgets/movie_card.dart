import 'package:flutter/material.dart';
import '../models/movie_model.dart';
import '../theme/app_theme.dart';
import 'netflix_logo.dart';

/// Kartu Film Netflix dengan animasi hover scale, poster dari internet,
/// informasi film (Judul, Rating, Tahun Rilis, Genre), dan efek interaktif.
class MovieCard extends StatefulWidget {
  final MovieModel movie;
  final ValueChanged<MovieModel> onTapCard;
  final bool showTop10Badge;
  final bool showProgress;
  final double width;
  final double height;

  const MovieCard({
    super.key,
    required this.movie,
    required this.onTapCard,
    this.showTop10Badge = false,
    this.showProgress = false,
    this.width = 200,
    this.height = 300,
  });

  @override
  State<MovieCard> createState() => _MovieCardState();
}

class _MovieCardState extends State<MovieCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final bool isTouchScreen = MediaQuery.of(context).size.width < 700;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: () => widget.onTapCard(widget.movie),
        child: AnimatedScale(
          scale: _isHovered ? 1.07 : 1.0,
          duration: const Duration(milliseconds: 220),
          curve: Curves.easeOutCubic,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 220),
            curve: Curves.easeOutCubic,
            width: widget.width,
            height: widget.height,
            decoration: BoxDecoration(
              color: AppTheme.cardBackground,
              borderRadius: BorderRadius.circular(6),
              border: Border.all(
                color: _isHovered
                    ? AppTheme.primaryText.withValues(alpha: 0.45)
                    : AppTheme.borderColor.withValues(alpha: 0.5),
                width: _isHovered ? 1.4 : 1.0,
              ),
              boxShadow: _isHovered
                  ? const <BoxShadow>[
                      BoxShadow(
                        color: Color(0xDD000000),
                        blurRadius: 22,
                        spreadRadius: 3,
                        offset: Offset(0, 10),
                      ),
                    ]
                  : const <BoxShadow>[
                      BoxShadow(
                        color: Color(0x66000000),
                        blurRadius: 8,
                        offset: Offset(0, 4),
                      ),
                    ],
            ),
            clipBehavior: Clip.antiAlias,
            child: Stack(
              fit: StackFit.expand,
              children: <Widget>[
                // 1. Gambar Poster Film dengan Loading & Fallback
                Image.network(
                  widget.movie.posterUrl,
                  fit: BoxFit.cover,
                  loadingBuilder: (
                    BuildContext context,
                    Widget child,
                    ImageChunkEvent? loadingProgress,
                  ) {
                    if (loadingProgress == null) return child;
                    return Container(
                      color: AppTheme.cardBackground,
                      alignment: Alignment.center,
                      child: const SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(
                          color: AppTheme.netflixRed,
                          strokeWidth: 2,
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
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: <Color>[
                            Color(widget.movie.accentColorValue)
                                .withValues(alpha: 0.75),
                            AppTheme.cardBackground,
                            AppTheme.primaryBackground,
                          ],
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          const NetflixLogo(fontSize: 28, compact: true),
                          const SizedBox(height: 12),
                          Text(
                            widget.movie.title,
                            textAlign: TextAlign.center,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: AppTheme.primaryText,
                              fontSize: 15,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            widget.movie.genre,
                            textAlign: TextAlign.center,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: AppTheme.secondaryText,
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),

                // 2. Badge 'N' di kiri atas & Badge Top 10 di kanan atas
                Positioned(
                  top: 8,
                  left: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 5,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.65),
                      borderRadius: BorderRadius.circular(3),
                    ),
                    child: const NetflixLogo(fontSize: 14, compact: true),
                  ),
                ),

                if (widget.showTop10Badge && widget.movie.top10Rank != null)
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 5,
                      ),
                      decoration: const BoxDecoration(
                        color: AppTheme.netflixRed,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(6),
                        ),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          const Text(
                            'TOP',
                            style: TextStyle(
                              color: AppTheme.primaryText,
                              fontSize: 8,
                              fontWeight: FontWeight.w900,
                              letterSpacing: 0.8,
                            ),
                          ),
                          Text(
                            '${widget.movie.top10Rank}',
                            style: const TextStyle(
                              color: AppTheme.primaryText,
                              fontSize: 13,
                              fontWeight: FontWeight.w900,
                              height: 1.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                // 3. Overlay Informasi Film di Bagian Bawah
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 220),
                    curve: Curves.easeOutCubic,
                    padding: EdgeInsets.fromLTRB(
                      10,
                      _isHovered ? 28 : 22,
                      10,
                      10,
                    ),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        stops: const <double>[0.0, 0.65, 1.0],
                        colors: <Color>[
                          Colors.black.withValues(
                            alpha: _isHovered ? 0.96 : 0.88,
                          ),
                          Colors.black.withValues(
                            alpha: _isHovered ? 0.82 : 0.45,
                          ),
                          Colors.transparent,
                        ],
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        // Tombol Visual saat Hover
                        AnimatedCrossFade(
                          duration: const Duration(milliseconds: 180),
                          crossFadeState: (_isHovered || isTouchScreen)
                              ? CrossFadeState.showFirst
                              : CrossFadeState.showSecond,
                          firstChild: Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: Row(
                              children: <Widget>[
                                Container(
                                  width: 30,
                                  height: 30,
                                  decoration: const BoxDecoration(
                                    color: AppTheme.primaryText,
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.play_arrow_rounded,
                                    color: Colors.black,
                                    size: 20,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Container(
                                  width: 30,
                                  height: 30,
                                  decoration: BoxDecoration(
                                    color: const Color(0xCC232323),
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: AppTheme.secondaryText,
                                      width: 1.4,
                                    ),
                                  ),
                                  child: const Icon(
                                    Icons.info_outline_rounded,
                                    color: AppTheme.primaryText,
                                    size: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          secondChild: const SizedBox.shrink(),
                        ),

                        // Judul Film
                        Text(
                          widget.movie.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: AppTheme.primaryText,
                            fontSize: 13.5,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 3),

                        // Rating & Tahun Rilis
                        Row(
                          children: <Widget>[
                            Text(
                              widget.movie.rating,
                              style: const TextStyle(
                                color: AppTheme.matchGreen,
                                fontSize: 11.5,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(width: 6),
                            Text(
                              widget.movie.releaseYear,
                              style: const TextStyle(
                                color: AppTheme.primaryText,
                                fontSize: 11.5,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(width: 6),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 4,
                                vertical: 0.5,
                              ),
                              decoration: BoxDecoration(
                                border: Border.all(color: AppTheme.borderColor),
                                borderRadius: BorderRadius.circular(2),
                              ),
                              child: Text(
                                widget.movie.maturityAge,
                                style: const TextStyle(
                                  color: AppTheme.secondaryText,
                                  fontSize: 9.5,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 3),

                        // Genre
                        Text(
                          widget.movie.genre,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: AppTheme.secondaryText,
                            fontSize: 11,
                          ),
                        ),

                        // Progress Bar untuk kategori Continue Watching
                        if (widget.showProgress &&
                            widget.movie.watchProgress != null) ...<Widget>[
                          const SizedBox(height: 6),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(2),
                            child: LinearProgressIndicator(
                              value: widget.movie.watchProgress!,
                              minHeight: 3.5,
                              backgroundColor: AppTheme.borderColor,
                              valueColor: const AlwaysStoppedAnimation<Color>(
                                AppTheme.netflixRed,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
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
