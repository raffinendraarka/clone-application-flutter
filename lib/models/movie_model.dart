/// Model sederhana untuk merepresentasikan data Film/Serial pada Netflix Clone.
class MovieModel {
  final String id;
  final String title;
  final String description;
  final String posterUrl;
  final String backdropUrl;
  final String rating;
  final String releaseYear;
  final String genre;
  final String duration;
  final String category;

  // Metadata visual tambahan untuk mendukung tampilan kartu & hero banner Netflix
  final List<String> additionalCategories;
  final String maturityAge;
  final int matchScore;
  final bool isSeries;
  final int? top10Rank;
  final double? watchProgress;
  final int accentColorValue;

  const MovieModel({
    required this.id,
    required this.title,
    required this.description,
    required this.posterUrl,
    required this.backdropUrl,
    required this.rating,
    required this.releaseYear,
    required this.genre,
    required this.duration,
    required this.category,
    this.additionalCategories = const <String>[],
    this.maturityAge = '16+',
    this.matchScore = 96,
    this.isSeries = false,
    this.top10Rank,
    this.watchProgress,
    this.accentColorValue = 0xFFE50914,
  });

  /// Memeriksa apakah film ini termasuk ke dalam kategori tertentu.
  bool belongsToCategory(String targetCategory) {
    if (category.toLowerCase() == targetCategory.toLowerCase()) {
      return true;
    }
    return additionalCategories.any(
      (String item) => item.toLowerCase() == targetCategory.toLowerCase(),
    );
  }

  /// Memisahkan teks genre menjadi list tag individual.
  List<String> get genreList => genre
      .split(',')
      .map((String g) => g.trim())
      .where((String g) => g.isNotEmpty)
      .toList();
}
