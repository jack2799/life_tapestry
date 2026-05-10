import 'package:flutter/material.dart';
import '../models/entry.dart';
import '../main.dart';

class CategoryCard extends StatelessWidget {
  final Category category;
  final int count;
  final VoidCallback onTap;

  const CategoryCard({
    Key? key,
    required this.category,
    required this.count,
    required this.onTap,
  }) : super(key: key);

  Color _getCategoryColor() {
    switch (category) {
      case Category.health:
        return AppColors.health;
      case Category.work:
        return AppColors.work;
      case Category.relationships:
        return AppColors.relationships;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: _getCategoryColor(),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              category.label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Color(0xFF333333),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              count.toString(),
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Color(0xFF000000),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'entries',
              style: TextStyle(fontSize: 12, color: Color(0xFF666666)),
            ),
          ],
        ),
      ),
    );
  }
}
