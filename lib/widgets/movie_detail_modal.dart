import 'package:flutter/material.dart';
import '../models/movie_model.dart';
import '../theme/app_theme.dart';
import 'netflix_logo.dart';

/// Modal dialog sederhana dan elegan untuk menampilkan informasi film saat pengguna
/// menekan tombol Play, More Info, atau mengetuk kartu film.
void showMovieSimpleModal(
  BuildContext context,
  MovieModel movie, {
  bool isPlay = false,
}) {
  showDialog<void>(
    context: context,
    builder: (BuildContext dialogContext) {
      final Size screenSize = MediaQuery.of(dialogContext).size;
      final bool isMobile = screenSize.width < 640;

      return Dialog(
        backgroundColor: AppTheme.secondaryBackground,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: const BorderSide(color: AppTheme.borderColor),
        ),
        clipBehavior: Clip.antiAlias,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: isMobile ? screenSize.width * 0.92 : 620,
            maxHeight: screenSize.height * 0.88,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // Backdrop Image dengan Tombol Tutup
                Stack(
                  children: <Widget>[
                    AspectRatio(
                      aspectRatio: 16 / 9,
                      child: Image.network(
                        movie.backdropUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (_, _, _) => Container(
                          color: AppTheme.cardBackground,
                          alignment: Alignment.center,
                          child: const NetflixLogo(fontSize: 28, compact: true),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 12,
                      right: 12,
                      child: IconButton(
                        tooltip: 'Close',
                        onPressed: () => Navigator.of(dialogContext).pop(),
                        style: IconButton.styleFrom(
                          backgroundColor: Colors.black.withValues(alpha: 0.7),
                          foregroundColor: AppTheme.primaryText,
                        ),
                        icon: const Icon(Icons.close_rounded, size: 20),
                      ),
                    ),
                    if (isPlay)
                      Positioned.fill(
                        child: Container(
                          color: Colors.black.withValues(alpha: 0.35),
                          child: const Center(
                            child: Icon(
                              Icons.play_circle_fill_rounded,
                              color: AppTheme.netflixRed,
                              size: 64,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),

                // Informasi Film
                Padding(
                  padding: const EdgeInsets.all(22),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      if (isPlay) ...<Widget>[
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 5,
                          ),
                          margin: const EdgeInsets.only(bottom: 12),
                          decoration: BoxDecoration(
                            color: AppTheme.netflixRed.withValues(alpha: 0.18),
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(color: AppTheme.netflixRed),
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Icon(
                                Icons.play_arrow_rounded,
                                color: AppTheme.netflixRed,
                                size: 16,
                              ),
                              SizedBox(width: 6),
                              Text(
                                'Simulasi Pemutaran Film (Tugas Edukasi UI/UX)',
                                style: TextStyle(
                                  color: AppTheme.netflixRed,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                      Text(
                        movie.title,
                        style: TextStyle(
                          color: AppTheme.primaryText,
                          fontSize: isMobile ? 22 : 26,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      const SizedBox(height: 8),

                      // Metadata badges
                      Wrap(
                        spacing: 10,
                        runSpacing: 6,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: <Widget>[
                          Text(
                            '${movie.matchScore}% Match',
                            style: const TextStyle(
                              color: AppTheme.matchGreen,
                              fontSize: 14,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          Text(
                            movie.releaseYear,
                            style: const TextStyle(
                              color: AppTheme.primaryText,
                              fontSize: 13.5,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 1.5,
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(color: AppTheme.secondaryText),
                              borderRadius: BorderRadius.circular(3),
                            ),
                            child: Text(
                              movie.maturityAge,
                              style: const TextStyle(
                                color: AppTheme.primaryText,
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Text(
                            movie.duration,
                            style: const TextStyle(
                              color: AppTheme.secondaryText,
                              fontSize: 13,
                            ),
                          ),
                          Text(
                            movie.rating,
                            style: const TextStyle(
                              color: Colors.amber,
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 14),

                      Text(
                        movie.description,
                        style: const TextStyle(
                          color: AppTheme.primaryText,
                          fontSize: 14.5,
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(height: 14),

                      RichText(
                        text: TextSpan(
                          style: const TextStyle(fontSize: 13.5),
                          children: <TextSpan>[
                            const TextSpan(
                              text: 'Genre: ',
                              style: TextStyle(color: AppTheme.secondaryText),
                            ),
                            TextSpan(
                              text: movie.genre,
                              style: const TextStyle(
                                color: AppTheme.primaryText,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
