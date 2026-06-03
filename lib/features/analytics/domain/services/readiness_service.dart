import '../../../progress/domain/services/category_service.dart';

class ReadinessReport {
  final double readinessScore;
  final String confidenceLevel;
  final String strongestTopic;
  final String weakestTopic;

  const ReadinessReport({
    required this.readinessScore,
    required this.confidenceLevel,
    required this.strongestTopic,
    required this.weakestTopic,
  });
}

class ReadinessService {
  final CategoryService _categoryService = CategoryService();

  ReadinessReport generateReport() {
    final categories = _categoryService.getCategoryStats();

    if (categories.isEmpty) {
      return const ReadinessReport(
        readinessScore: 0,
        confidenceLevel: 'Low',
        strongestTopic: '-',
        weakestTopic: '-',
      );
    }

    categories.sort(
      (a, b) => (a['accuracy'] as double).compareTo(b['accuracy'] as double),
    );

    final weakest = categories.first;
    final strongest = categories.last;

    final average =
        categories.map((e) => e['accuracy'] as double).reduce((a, b) => a + b) /
        categories.length;

    String confidence;

    if (average >= 85) {
      confidence = 'Very High';
    } else if (average >= 70) {
      confidence = 'High';
    } else if (average >= 55) {
      confidence = 'Moderate';
    } else {
      confidence = 'Low';
    }

    return ReadinessReport(
      readinessScore: average,
      confidenceLevel: confidence,
      strongestTopic: strongest['category'],
      weakestTopic: weakest['category'],
    );
  }
}
