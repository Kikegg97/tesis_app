class CategoryEntity {
  final String categoryId;
  final String name;
  final int totalExpenses;
  final String icon;
  final int color;

  const CategoryEntity({
    required this.categoryId,
    required this.name,
    required this.totalExpenses,
    required this.icon,
    required this.color,
  });

  Map<String, dynamic> toDocument() {
    return {
      'categoryId': categoryId,
      'name': name,
      'totalExpenses': totalExpenses,
      'icon': icon,
      'color': color,
    };
  }

  static CategoryEntity fromDocument(Map<String, dynamic> doc) {
    return CategoryEntity(
      categoryId: (doc['categoryId'] as String?) ?? '',
      name: (doc['name'] as String?) ?? '',
      totalExpenses: (doc['totalExpenses'] as num?)?.toInt() ?? 0,
      icon: (doc['icon'] as String?) ?? '',
      color: _parseColorToInt(doc['color']),
    );
  }

  // Acepta int, "0xAARRGGBB", "#RRGGBB" o "AARRGGBB"/"RRGGBB"
  static int _parseColorToInt(Object? v) {
    if (v is int) return v;
    if (v == null) return 0xFF000000;
    var s = v.toString().trim().toUpperCase();
    if (s.startsWith('#')) s = s.substring(1);
    if (s.startsWith('0X')) s = s.substring(2);
    if (s.length == 6) s = 'FF$s';
    return int.tryParse(s, radix: 16) ?? 0xFF000000;
  }
}
