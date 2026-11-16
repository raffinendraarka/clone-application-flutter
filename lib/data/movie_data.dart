import '../models/movie_model.dart';

/// Data statis katalog film dan serial menggunakan poster & backdrop dari TMDB CDN.
class MovieData {
  MovieData._();

  /// Nama pengguna statis yang ditampilkan pada Netflix Dashboard.
  static const String currentUserName = 'Arka Raffinendra';

  /// 6 Kategori utama pada Netflix Dashboard sesuai spesifikasi revisi.
  static const List<String> categories = <String>[
    'Trending Now',
    'Popular on Netflix',
    'Top 10 Movies',
    'Action Movies',
    'Recommended for You',
    'Continue Watching',
  ];

  /// Gambar background sinematik untuk halaman Login dan Register.
  static const String authBackgroundUrl =
      'https://image.tmdb.org/t/p/w1280/56v2KjBlU4XaOv9rVYEQypROD7P.jpg';

  /// Daftar film unggulan yang ditampilkan pada Hero Banner.
  static List<MovieModel> get featuredHeroMovies => <MovieModel>[
        allMovies[0], // Stranger Things
        allMovies[4], // Dune: Part Two
        allMovies[2], // Squid Game
        allMovies[10], // Extraction 2
      ];

  /// Mengambil daftar film berdasarkan nama kategori.
  static List<MovieModel> getMoviesByCategory(String categoryName) {
    if (categoryName == 'Top 10 Movies') {
      final List<MovieModel> top10 = allMovies
          .where((MovieModel m) => m.top10Rank != null)
          .toList()
        ..sort(
          (MovieModel a, MovieModel b) =>
              (a.top10Rank ?? 99).compareTo(b.top10Rank ?? 99),
        );
      return top10;
    }

    if (categoryName == 'Continue Watching') {
      return allMovies
          .where((MovieModel m) => m.watchProgress != null)
          .toList();
    }

    return allMovies
        .where((MovieModel m) => m.belongsToCategory(categoryName))
        .toList();
  }

  static const List<MovieModel> allMovies = <MovieModel>[
    MovieModel(
      id: 'stranger-things',
      title: 'Stranger Things',
      description:
          'When a young boy vanishes in a small Indiana town, his friends, a terrified mother, and a local police chief uncover a dark government conspiracy and supernatural forces.',
      posterUrl:
          'https://image.tmdb.org/t/p/w500/49WJfeN0moxb9IPfGn8AIqMGskD.jpg',
      backdropUrl:
          'https://image.tmdb.org/t/p/w1280/56v2KjBlU4XaOv9rVYEQypROD7P.jpg',
      rating: '8.7 ★',
      releaseYear: '2024',
      genre: 'Sci-Fi, Mystery, Drama',
      duration: '4 Seasons',
      category: 'Trending Now',
      additionalCategories: <String>[
        'Popular on Netflix',
        'Top 10 Movies',
        'Continue Watching',
        'Recommended for You',
      ],
      maturityAge: '16+',
      matchScore: 99,
      isSeries: true,
      top10Rank: 1,
      watchProgress: 0.72,
      accentColorValue: 0xFFE50914,
    ),
    MovieModel(
      id: 'wednesday',
      title: 'Wednesday',
      description:
          'Smart, sarcastic and a little dead inside, Wednesday Addams investigates a twisted murder spree while making new friends — and foes — at Nevermore Academy.',
      posterUrl:
          'https://image.tmdb.org/t/p/w500/9PFonBhy4cQy7Jz20NpMygczOkv.jpg',
      backdropUrl:
          'https://image.tmdb.org/t/p/w1280/iHSwvRVsRyxpX7FE7GbviaDvgGZ.jpg',
      rating: '8.5 ★',
      releaseYear: '2023',
      genre: 'Comedy, Mystery, Fantasy',
      duration: '1 Season',
      category: 'Popular on Netflix',
      additionalCategories: <String>[
        'Trending Now',
        'Top 10 Movies',
        'Recommended for You',
      ],
      maturityAge: '13+',
      matchScore: 97,
      isSeries: true,
      top10Rank: 2,
      accentColorValue: 0xFF6B21A8,
    ),
    MovieModel(
      id: 'squid-game',
      title: 'Squid Game',
      description:
          'Hundreds of cash-strapped players accept a strange invitation to compete in children\'s games. Inside, a tempting prize awaits with deadly high stakes.',
      posterUrl:
          'https://image.tmdb.org/t/p/w500/dDlEmu3EZ0Pgg93K2SVNLCjCSvE.jpg',
      backdropUrl:
          'https://image.tmdb.org/t/p/w1280/qw3J9cNeLioOLoR68WX7z79aCdK.jpg',
      rating: '8.4 ★',
      releaseYear: '2024',
      genre: 'Thriller, Action, Drama',
      duration: '2 Seasons',
      category: 'Top 10 Movies',
      additionalCategories: <String>[
        'Trending Now',
        'Popular on Netflix',
        'Continue Watching',
        'Action Movies',
      ],
      maturityAge: '18+',
      matchScore: 98,
      isSeries: true,
      top10Rank: 3,
      watchProgress: 0.45,
      accentColorValue: 0xFFDB2777,
    ),
    MovieModel(
      id: 'money-heist',
      title: 'Money Heist',
      description:
          'An unusual group of robbers attempt to carry out the most perfect robbery in Spanish history — stealing 2.4 billion euros from the Royal Mint of Spain.',
      posterUrl:
          'https://image.tmdb.org/t/p/w500/reEMJA1uzscCbkpeRJeTT2bjqUp.jpg',
      backdropUrl:
          'https://image.tmdb.org/t/p/w1280/gFZriCkpJYsApPZEF3jhxL4yLzG.jpg',
      rating: '8.3 ★',
      releaseYear: '2021',
      genre: 'Action, Crime, Thriller',
      duration: '5 Parts',
      category: 'Popular on Netflix',
      additionalCategories: <String>[
        'Trending Now',
        'Action Movies',
        'Recommended for You',
      ],
      maturityAge: '18+',
      matchScore: 96,
      isSeries: true,
      accentColorValue: 0xFFB91C1C,
    ),
    MovieModel(
      id: 'dune-part-two',
      title: 'Dune: Part Two',
      description:
          'Paul Atreides unites with Chani and the Fremen while on a warpath of revenge against the conspirators who destroyed his family.',
      posterUrl:
          'https://image.tmdb.org/t/p/w500/1pdfLvkbY9ohJlCjQH2CZjjYVvJ.jpg',
      backdropUrl:
          'https://image.tmdb.org/t/p/w1280/xOMo8BRK7PfcJv9JCnx7s5hj0PX.jpg',
      rating: '8.8 ★',
      releaseYear: '2024',
      genre: 'Sci-Fi, Adventure, Action',
      duration: '2h 46m',
      category: 'Trending Now',
      additionalCategories: <String>[
        'Top 10 Movies',
        'Action Movies',
        'Continue Watching',
        'Recommended for You',
      ],
      maturityAge: '13+',
      matchScore: 99,
      isSeries: false,
      top10Rank: 4,
      watchProgress: 0.85,
      accentColorValue: 0xFFD97706,
    ),
    MovieModel(
      id: 'oppenheimer',
      title: 'Oppenheimer',
      description:
          'The story of J. Robert Oppenheimer\'s role in the development of the atomic bomb during World War II and the dramatic political fallout that followed.',
      posterUrl:
          'https://image.tmdb.org/t/p/w500/8Gxv8gSFCU0XGDykEGv7zR1n2ua.jpg',
      backdropUrl:
          'https://image.tmdb.org/t/p/w1280/fm6KqXpk3M2HVveHwCrBSSBaO0V.jpg',
      rating: '8.9 ★',
      releaseYear: '2023',
      genre: 'Drama, History, Thriller',
      duration: '3h 00m',
      category: 'Trending Now',
      additionalCategories: <String>[
        'Popular on Netflix',
        'Top 10 Movies',
        'Recommended for You',
      ],
      maturityAge: '16+',
      matchScore: 97,
      isSeries: false,
      top10Rank: 5,
      accentColorValue: 0xFFEA580C,
    ),
    MovieModel(
      id: 'spider-verse',
      title: 'Spider-Man: Across the Spider-Verse',
      description:
          'After reuniting with Gwen Stacy, Brooklyn\'s full-time, friendly neighborhood Spider-Man is catapulted across the Multiverse.',
      posterUrl:
          'https://image.tmdb.org/t/p/w500/8Vt6mWEReuy4Of61Lnj5Xj704m8.jpg',
      backdropUrl:
          'https://image.tmdb.org/t/p/w1280/4HodYYKEIsGOdinkGi2Ucz6X9i0.jpg',
      rating: '8.7 ★',
      releaseYear: '2023',
      genre: 'Animation, Action, Sci-Fi',
      duration: '2h 20m',
      category: 'Popular on Netflix',
      additionalCategories: <String>[
        'Trending Now',
        'Action Movies',
        'Continue Watching',
        'Recommended for You',
      ],
      maturityAge: '13+',
      matchScore: 98,
      isSeries: false,
      watchProgress: 0.60,
      accentColorValue: 0xFFE11D48,
    ),
    MovieModel(
      id: 'the-dark-knight',
      title: 'The Dark Knight',
      description:
          'Batman raises the stakes in his war on crime. With the help of Lt. Jim Gordon and District Attorney Harvey Dent, Batman sets out to dismantle criminal organizations.',
      posterUrl:
          'https://image.tmdb.org/t/p/w500/qJ2tW6WMUDux911r6m7haRef0WH.jpg',
      backdropUrl:
          'https://image.tmdb.org/t/p/w1280/nMKdUUepR0i5zn0y1T4CsSB5chy.jpg',
      rating: '9.0 ★',
      releaseYear: '2008',
      genre: 'Action, Crime, Drama',
      duration: '2h 32m',
      category: 'Action Movies',
      additionalCategories: <String>[
        'Popular on Netflix',
        'Recommended for You',
      ],
      maturityAge: '16+',
      matchScore: 99,
      isSeries: false,
      accentColorValue: 0xFF1D4ED8,
    ),
    MovieModel(
      id: 'inception',
      title: 'Inception',
      description:
          'Cobb, a skilled thief who commits corporate espionage by infiltrating the subconscious of his targets, is offered a chance to regain his old life.',
      posterUrl:
          'https://image.tmdb.org/t/p/w500/oYuLEt3zVCKq57qu2F8dT7NIa6f.jpg',
      backdropUrl:
          'https://image.tmdb.org/t/p/w1280/8ZTVqvKDQ8emSGUEMjsS4yHAwrp.jpg',
      rating: '8.8 ★',
      releaseYear: '2010',
      genre: 'Action, Sci-Fi, Adventure',
      duration: '2h 28m',
      category: 'Recommended for You',
      additionalCategories: <String>[
        'Action Movies',
        'Popular on Netflix',
      ],
      maturityAge: '13+',
      matchScore: 98,
      isSeries: false,
      accentColorValue: 0xFF0284C7,
    ),
    MovieModel(
      id: 'interstellar',
      title: 'Interstellar',
      description:
          'The adventures of a group of explorers who make use of a newly discovered wormhole to surpass the limitations on human space travel.',
      posterUrl:
          'https://image.tmdb.org/t/p/w500/gEU2QniE6E77NI6lCU6MxlNBvIx.jpg',
      backdropUrl:
          'https://image.tmdb.org/t/p/w1280/xJHokMbljvjADYdit5fK5VQsXEG.jpg',
      rating: '8.7 ★',
      releaseYear: '2014',
      genre: 'Sci-Fi, Adventure, Drama',
      duration: '2h 49m',
      category: 'Recommended for You',
      additionalCategories: <String>[
        'Popular on Netflix',
        'Continue Watching',
      ],
      maturityAge: '13+',
      matchScore: 99,
      isSeries: false,
      watchProgress: 0.30,
      accentColorValue: 0xFF4F46E5,
    ),
    MovieModel(
      id: 'extraction-2',
      title: 'Extraction 2',
      description:
          'Tasked with extracting a family who is at the mercy of a Georgian gangster, Tyler Rake infiltrates one of the world\'s deadliest prisons in order to save them.',
      posterUrl:
          'https://image.tmdb.org/t/p/w500/7gKI9hpEMcZUQpNgKrkDzJpbnNS.jpg',
      backdropUrl:
          'https://image.tmdb.org/t/p/w1280/fhquRW28vRZHr26orSaFFnhYIA0.jpg',
      rating: '7.9 ★',
      releaseYear: '2023',
      genre: 'Action, Thriller',
      duration: '2h 02m',
      category: 'Action Movies',
      additionalCategories: <String>[
        'Trending Now',
        'Top 10 Movies',
        'Popular on Netflix',
      ],
      maturityAge: '18+',
      matchScore: 95,
      isSeries: false,
      top10Rank: 6,
      accentColorValue: 0xFFB45309,
    ),
    MovieModel(
      id: 'john-wick-4',
      title: 'John Wick: Chapter 4',
      description:
          'With the price on his head ever increasing, John Wick uncovers a path to defeating The High Table and earning his freedom.',
      posterUrl:
          'https://image.tmdb.org/t/p/w500/vZloFAK7NmvMGKE7VkF5UHaz0I.jpg',
      backdropUrl:
          'https://image.tmdb.org/t/p/w1280/h8gHn0OzBoaefsYseUByqsmEDMY.jpg',
      rating: '8.2 ★',
      releaseYear: '2023',
      genre: 'Action, Thriller, Crime',
      duration: '2h 49m',
      category: 'Action Movies',
      additionalCategories: <String>[
        'Trending Now',
        'Top 10 Movies',
        'Continue Watching',
      ],
      maturityAge: '18+',
      matchScore: 96,
      isSeries: false,
      top10Rank: 7,
      watchProgress: 0.52,
      accentColorValue: 0xFF9333EA,
    ),
    MovieModel(
      id: 'top-gun-maverick',
      title: 'Top Gun: Maverick',
      description:
          'After more than thirty years of service as one of the Navy\'s top aviators, Pete "Maverick" Mitchell pushes the envelope as a courageous test pilot.',
      posterUrl:
          'https://image.tmdb.org/t/p/w500/62HCnUTziyWcpDaBO2i1DX17ljH.jpg',
      backdropUrl:
          'https://image.tmdb.org/t/p/w1280/AaV1YIdWKnjAIAOe8UUKBFm327v.jpg',
      rating: '8.3 ★',
      releaseYear: '2022',
      genre: 'Action, Drama',
      duration: '2h 11m',
      category: 'Action Movies',
      additionalCategories: <String>[
        'Popular on Netflix',
        'Recommended for You',
      ],
      maturityAge: '13+',
      matchScore: 97,
      isSeries: false,
      accentColorValue: 0xFF0369A1,
    ),
    MovieModel(
      id: 'deadpool-wolverine',
      title: 'Deadpool & Wolverine',
      description:
          'When his homeworld faces an existential threat, Wade Wilson must reluctantly suit-up again alongside Wolverine.',
      posterUrl:
          'https://image.tmdb.org/t/p/w500/8cdWjvZQUExUUTzyp4t6EDMubfO.jpg',
      backdropUrl:
          'https://image.tmdb.org/t/p/w1280/yDHYTfA3R0jFYba16jBB1ef8oIt.jpg',
      rating: '8.1 ★',
      releaseYear: '2024',
      genre: 'Comedy, Action, Sci-Fi',
      duration: '2h 08m',
      category: 'Trending Now',
      additionalCategories: <String>[
        'Top 10 Movies',
        'Action Movies',
        'Continue Watching',
      ],
      maturityAge: '18+',
      matchScore: 96,
      isSeries: false,
      top10Rank: 8,
      watchProgress: 0.65,
      accentColorValue: 0xFFDC2626,
    ),
    MovieModel(
      id: 'a-quiet-place-day-one',
      title: 'A Quiet Place: Day One',
      description:
          'As New York City is invaded by alien creatures who hunt by sound, a woman named Sam fights to survive with her cat Frodo.',
      posterUrl:
          'https://image.tmdb.org/t/p/w500/hU42CRk14JuPEdqZG3AWmagiPAP.jpg',
      backdropUrl:
          'https://image.tmdb.org/t/p/w1280/2RVcJbWFmICRDsVxRI8F5xRmRsK.jpg',
      rating: '7.6 ★',
      releaseYear: '2024',
      genre: 'Horror, Sci-Fi, Thriller',
      duration: '1h 39m',
      category: 'Trending Now',
      additionalCategories: <String>[
        'Top 10 Movies',
        'Recommended for You',
      ],
      maturityAge: '16+',
      matchScore: 94,
      isSeries: false,
      top10Rank: 9,
      accentColorValue: 0xFF374151,
    ),
    MovieModel(
      id: 'train-to-busan',
      title: 'Train to Busan',
      description:
          'Martial law is declared when a mysterious viral outbreak pushes Korea into a state of emergency aboard an express train to Busan.',
      posterUrl:
          'https://image.tmdb.org/t/p/w500/3H1WFCuxyNRP35oiL2qqwhAXxc0.jpg',
      backdropUrl:
          'https://image.tmdb.org/t/p/w1280/fVpFOcQyHJM2di9upgSIwWD5wac.jpg',
      rating: '8.0 ★',
      releaseYear: '2016',
      genre: 'Horror, Action, Thriller',
      duration: '1h 58m',
      category: 'Top 10 Movies',
      additionalCategories: <String>[
        'Action Movies',
        'Popular on Netflix',
      ],
      maturityAge: '18+',
      matchScore: 97,
      isSeries: false,
      top10Rank: 10,
      accentColorValue: 0xFF1E3A8A,
    ),
    MovieModel(
      id: 'arcane',
      title: 'Arcane',
      description:
          'Amid the stark discord of twin cities Piltover and Zaun, two sisters fight on rival sides of a war between magic technologies and clashing convictions.',
      posterUrl:
          'https://image.tmdb.org/t/p/w500/fqldf2t8ztc9aiwn3k6mlX3tvRT.jpg',
      backdropUrl:
          'https://image.tmdb.org/t/p/w1280/rkB4LyZHo1NHXFEDHl9vSD9r1lI.jpg',
      rating: '9.0 ★',
      releaseYear: '2024',
      genre: 'Animation, Action, Sci-Fi',
      duration: '2 Seasons',
      category: 'Recommended for You',
      additionalCategories: <String>[
        'Trending Now',
        'Popular on Netflix',
        'Continue Watching',
      ],
      maturityAge: '16+',
      matchScore: 99,
      isSeries: true,
      watchProgress: 0.90,
      accentColorValue: 0xFF2563EB,
    ),
    MovieModel(
      id: 'one-piece-live-action',
      title: 'One Piece',
      description:
          'With his straw hat and ragtag crew, young pirate Monkey D. Luffy goes on an epic voyage for treasure in this live-action adaptation.',
      posterUrl:
          'https://image.tmdb.org/t/p/w500/rVX05xRKS5JhEYQFObCi4lAnZT4.jpg',
      backdropUrl:
          'https://image.tmdb.org/t/p/w1280/aRKQdF6AGbhnF9IAyJbte5epH5R.jpg',
      rating: '8.3 ★',
      releaseYear: '2023',
      genre: 'Action, Adventure, Fantasy',
      duration: '1 Season',
      category: 'Popular on Netflix',
      additionalCategories: <String>[
        'Action Movies',
        'Continue Watching',
        'Recommended for You',
      ],
      maturityAge: '13+',
      matchScore: 96,
      isSeries: true,
      watchProgress: 0.40,
      accentColorValue: 0xFFD97706,
    ),
  ];
}
